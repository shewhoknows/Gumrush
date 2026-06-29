import Foundation

struct SupabaseConfig: Equatable {
    let url: URL
    let anonKey: String

    static func load(bundle: Bundle = .main,
                     environment: [String: String] = ProcessInfo.processInfo.environment) -> SupabaseConfig? {
        let rawURL = environment["SUPABASE_URL"]
            ?? bundle.object(forInfoDictionaryKey: "SUPABASE_URL") as? String
        let rawKey = environment["SUPABASE_ANON_KEY"]
            ?? bundle.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String

        guard let rawURL, let url = URL(string: rawURL),
              let rawKey, !rawKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            logError("Supabase configuration missing",
                     error: ServiceError.notConfigured,
                     metadata: ["message": "missing URL or anon key"])
            return nil
        }
        return SupabaseConfig(url: url, anonKey: rawKey)
    }
}

final class SupabaseRESTClient {
    private let config: SupabaseConfig
    private let session: URLSession
    private(set) var accessToken: String?
    private(set) var currentUserID: String?

    /// Default session with a 20 s request timeout so friend-code
    /// loading and other REST/RPC calls do not hang indefinitely.
    private static func defaultSession() -> URLSession {
        URLSession(configuration: Self.makeDefaultSessionConfiguration())
    }

    static func makeDefaultSessionConfiguration() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.timeoutIntervalForResource = 30
        return config
    }

    private static func safeBodyExcerpt(from data: Data, maxLength: Int = 200) -> String {
        if let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let message = object["msg"] as? String
            ?? object["message"] as? String
            ?? object["error_description"] as? String
            ?? object["error"] as? String {
            return message.count <= maxLength ? message : String(message.prefix(maxLength))
        }
        let raw = String(data: data, encoding: .utf8) ?? ""
        return raw.count <= maxLength ? raw : String(raw.prefix(maxLength))
    }

    init(config: SupabaseConfig, session: URLSession = SupabaseRESTClient.defaultSession()) {
        self.config = config
        self.session = session
    }

    func setSession(accessToken: String?, userID: String?) {
        self.accessToken = accessToken
        currentUserID = userID
    }

    func request(path: String,
                 method: String = "GET",
                 queryItems: [URLQueryItem] = [],
                 body: Data? = nil,
                 bearerToken: String? = nil,
                 returnRepresentation: Bool = true) async throws -> Data {
        let url = try makeURL(path: path, queryItems: queryItems)

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue(config.anonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if method != "GET" {
            let returnMode = returnRepresentation ? "return=representation" : "return=minimal"
            request.setValue("\(returnMode),resolution=merge-duplicates", forHTTPHeaderField: "Prefer")
        }
        let token = bearerToken ?? accessToken ?? config.anonKey
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            logError("Supabase REST request failed",
                     error: error,
                     metadata: ["method": method, "path": path])
            throw error
        }
        guard let http = response as? HTTPURLResponse else {
            logError("Supabase REST: non-HTTP response",
                     error: ServiceError.invalidResponse,
                     metadata: ["method": method, "path": path])
            throw ServiceError.invalidResponse
        }
        guard 200..<300 ~= http.statusCode else {
            let message = Self.safeBodyExcerpt(from: data)
            let theError: ServiceError = http.statusCode == 409 ? .duplicateUsername : .offline
            logError("Supabase REST: HTTP \(http.statusCode)",
                     error: theError,
                     metadata: ["method": method, "path": path,
                               "status": "\(http.statusCode)",
                               "message": message])
            throw theError
        }
        return data
    }

    func authRequest(path: String,
                     queryItems: [URLQueryItem] = [],
                     method: String = "POST",
                     body: Data? = nil,
                     authErrorMessage: String = "Check your email and password.") async throws -> Data {
        let url = try makeURL(path: path, queryItems: queryItems)
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue(config.anonKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(config.anonKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            logError("Supabase auth request failed",
                     error: error,
                     metadata: ["method": method, "path": path])
            throw error
        }
        guard let http = response as? HTTPURLResponse else {
            logError("Supabase auth: non-HTTP response",
                     error: ServiceError.invalidResponse,
                     metadata: ["method": method, "path": path])
            throw ServiceError.invalidResponse
        }
        guard 200..<300 ~= http.statusCode else {
            let serverMessage = Self.authErrorMessage(from: data)
            let theError: ServiceError
            if http.statusCode == 400 || http.statusCode == 422 {
                theError = .friendly(authErrorMessage)
            } else if http.statusCode == 401 || http.statusCode == 403 {
                theError = .authFailed("Apple sign-in reached Gumrush online, but Supabase rejected it. Check the Apple provider client ID.")
            } else {
                theError = .offline
            }
            logError("Supabase auth: HTTP \(http.statusCode)",
                     error: theError,
                     metadata: ["method": method, "path": path,
                               "status": "\(http.statusCode)",
                               "message": serverMessage ?? ""])
            throw theError
        }
        return data
    }

    private func makeURL(path: String, queryItems: [URLQueryItem] = []) throws -> URL {
        let parts = path.split(separator: "?", maxSplits: 1, omittingEmptySubsequences: false)
        let cleanPath = String(parts[0])
        var components = URLComponents(url: config.url.appendingPathComponent(cleanPath), resolvingAgainstBaseURL: false)
        var allQueryItems = queryItems
        if parts.count > 1, let queryComponents = URLComponents(string: "?\(parts[1])") {
            allQueryItems.append(contentsOf: queryComponents.queryItems ?? [])
        }
        components?.queryItems = allQueryItems.isEmpty ? nil : allQueryItems
        guard let url = components?.url else { throw ServiceError.invalidResponse }
        return url
    }

    private static func authErrorMessage(from data: Data) -> String? {
        guard let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return String(data: data, encoding: .utf8)
        }
        return object["msg"] as? String
            ?? object["message"] as? String
            ?? object["error_description"] as? String
            ?? object["error"] as? String
    }

    func rpc<T: Decodable>(_ function: String, params: [String: Any]? = nil) async throws -> T {
        let data = try await rpcData(function, params: params)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }

    /// Like rpc but resilient to scalar-vs-single-element-array ambiguity.
    /// Tries direct decode first; on failure attempts unwrapping from a
    /// single-element JSON array.
    func rpcValue<T: Decodable>(_ function: String, params: [String: Any]? = nil) async throws -> T {
        let data = try await rpcData(function, params: params)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if let result = try? decoder.decode(T.self, from: data) {
            return result
        }
        if let array = try? decoder.decode([T].self, from: data), let first = array.first {
            return first
        }
        throw ServiceError.invalidResponse
    }

    private func rpcData(_ function: String, params: [String: Any]?) async throws -> Data {
        let url = config.url.appendingPathComponent("rest/v1/rpc/\(function)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(config.anonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let token = accessToken ?? config.anonKey
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        if let params {
            request.httpBody = try JSONSerialization.data(withJSONObject: params)
        } else {
            request.httpBody = try JSONSerialization.data(withJSONObject: [:])
        }

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            logError("Supabase RPC failed",
                     error: error,
                     metadata: ["function": function])
            throw error
        }
        guard let http = response as? HTTPURLResponse else {
            logError("Supabase RPC: non-HTTP response",
                     error: ServiceError.invalidResponse,
                     metadata: ["function": function])
            throw ServiceError.invalidResponse
        }
        guard 200..<300 ~= http.statusCode else {
            let message = Self.safeBodyExcerpt(from: data)
            let theError: ServiceError
            if let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let msg = object["message"] as? String {
                theError = .friendly(msg)
            } else {
                theError = .offline
            }
            logError("Supabase RPC: HTTP \(http.statusCode)",
                     error: theError,
                     metadata: ["function": function,
                               "status": "\(http.statusCode)",
                               "message": message])
            throw theError
        }
        return data
    }

    func invokeFunction(_ name: String, body: Data) async throws -> Data {
        guard let accessToken else {
            logError("Supabase Edge Function: missing session",
                     error: ServiceError.notConfigured,
                     metadata: ["function": name])
            throw ServiceError.notConfigured
        }
        let url = config.url.appendingPathComponent("functions/v1/\(name)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue(config.anonKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            logError("Supabase Edge Function failed",
                     error: error,
                     metadata: ["function": name])
            throw error
        }
        guard let http = response as? HTTPURLResponse else {
            logError("Supabase Edge Function: non-HTTP response",
                     error: ServiceError.invalidResponse,
                     metadata: ["function": name])
            throw ServiceError.invalidResponse
        }
        guard 200..<300 ~= http.statusCode else {
            logError("Supabase Edge Function: HTTP \(http.statusCode)",
                     error: ServiceError.offline,
                     metadata: ["function": name,
                               "status": "\(http.statusCode)"])
            throw ServiceError.offline
        }
        return data
    }
}
