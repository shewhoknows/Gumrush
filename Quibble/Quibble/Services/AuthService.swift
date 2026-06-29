import AuthenticationServices
import Foundation

enum AuthSession: Equatable {
    case guest(UserProfile)
    case apple(UserProfile)
    case remote(UserProfile)

    var profile: UserProfile {
        switch self {
        case .guest(let profile), .apple(let profile), .remote(let profile):
            return profile
        }
    }

    var isGuest: Bool {
        if case .guest = self { return true }
        return false
    }
}

final class AuthService {
    private let profileRepository: ProfileRepositoryProtocol
    private let client: SupabaseRESTClient?
    private let sessionStore: AuthSessionStore

    init(profileRepository: ProfileRepositoryProtocol,
         client: SupabaseRESTClient? = nil,
         sessionStore: AuthSessionStore = AuthSessionStore()) {
        self.profileRepository = profileRepository
        self.client = client
        self.sessionStore = sessionStore
    }

    func guestSession(from profile: PlayerProfile) async -> AuthSession {
        let user = (try? await profileRepository.currentProfile(localProfile: profile))
            ?? UserProfile(id: "guest",
                           username: "guest",
                           displayName: profile.name,
                           avatarSeed: profile.colorName,
                           totalXP: profile.xp,
                           currentStreak: profile.dailyStreak,
                           createdAt: nil,
                           updatedAt: nil)
        return .guest(user)
    }

    func appleSession(credential: ASAuthorizationAppleIDCredential, rawNonce: String?, fallback profile: PlayerProfile) async throws -> AuthSession {
        let displayName = [
            credential.fullName?.givenName,
            credential.fullName?.familyName
        ].compactMap { $0 }.joined(separator: " ")
        let name = displayName.isEmpty ? profile.name : displayName
        guard let tokenData = credential.identityToken,
              let idToken = String(data: tokenData, encoding: .utf8),
              !idToken.isEmpty else {
            throw ServiceError.friendly("Apple did not return a sign-in token.")
        }
        guard let rawNonce, !rawNonce.isEmpty else {
            throw ServiceError.friendly("Apple sign-in could not verify securely. Try again.")
        }

        let auth = try await authenticateWithIDToken(provider: "apple", idToken: idToken, nonce: rawNonce)
        guard let accessToken = auth.accessToken, let userID = auth.resolvedUserID else {
            throw ServiceError.invalidResponse
        }
        client?.setSession(accessToken: accessToken, userID: userID)
        sessionStore.save(accessToken: accessToken, refreshToken: auth.refreshToken, userID: userID)

        do {
            let remote = try await profileRepository.currentProfile(localProfile: profile)
            return .remote(remote)
        } catch {
            let username = uniqueAppleUsername(from: name, userID: userID)
            let remote = try await profileRepository.createProfile(username: username,
                                                                   displayName: name,
                                                                   avatarSeed: profile.colorName)
            return .remote(remote)
        }
    }

    func createProfile(username: String, displayName: String, avatarSeed: String) async throws -> AuthSession {
        let profile = try await profileRepository.createProfile(username: username,
                                                                displayName: displayName,
                                                                avatarSeed: avatarSeed)
        return .remote(profile)
    }

    func restoreRemoteSession(localProfile: PlayerProfile) async -> AuthSession? {
        guard let stored = sessionStore.load(), let client else { return nil }

        // Try the stored access token first.
        client.setSession(accessToken: stored.accessToken, userID: stored.userID)
        do {
            let profile = try await profileRepository.currentProfile(localProfile: localProfile)
            return .remote(profile)
        } catch {
            // Access token may have expired — attempt a refresh.
            guard let refresh = stored.refreshToken, !refresh.isEmpty else {
                sessionStore.clear()
                return nil
            }
            do {
                let refreshed = try await refreshSession(refreshToken: refresh, client: client)
                client.setSession(accessToken: refreshed.accessToken, userID: refreshed.userID)
                sessionStore.save(accessToken: refreshed.accessToken,
                                  refreshToken: refreshed.refreshToken,
                                  userID: refreshed.userID)
                let profile = try await profileRepository.currentProfile(localProfile: localProfile)
                return .remote(profile)
            } catch {
                sessionStore.clear()
                return nil
            }
        }
    }

    private func refreshSession(refreshToken: String, client: SupabaseRESTClient) async throws -> (accessToken: String, refreshToken: String?, userID: String) {
        let body = try JSONEncoder().encode(SupabaseTokenRefreshRequest(refreshToken: refreshToken))
        let data = try await client.authRequest(path: "auth/v1/token",
                                                queryItems: [URLQueryItem(name: "grant_type", value: "refresh_token")],
                                                body: body,
                                                authErrorMessage: "Session expired. Please sign in again.")
        let response = try JSONDecoder().decode(SupabaseAuthResponse.self, from: data)
        guard let accessToken = response.accessToken, !accessToken.isEmpty,
              let userID = response.resolvedUserID else {
            throw ServiceError.authFailed("Could not refresh session.")
        }
        return (accessToken, response.refreshToken, userID)
    }

    func signUp(email: String, password: String, username: String, displayName: String, avatarSeed: String) async throws -> AuthSession {
        let auth = try await authenticate(path: "auth/v1/signup", email: email, password: password)
        guard let accessToken = auth.accessToken, let userID = auth.resolvedUserID else {
            throw ServiceError.friendly("Check your email to finish signing in, then try again.")
        }
        client?.setSession(accessToken: accessToken, userID: userID)
        sessionStore.save(accessToken: accessToken, refreshToken: auth.refreshToken, userID: userID)
        let profile = try await profileRepository.createProfile(username: username,
                                                                displayName: displayName,
                                                                avatarSeed: avatarSeed)
        return .remote(profile)
    }

    func signIn(email: String, password: String, fallback: PlayerProfile) async throws -> AuthSession {
        let auth = try await authenticate(path: "auth/v1/token",
                                          queryItems: [URLQueryItem(name: "grant_type", value: "password")],
                                          email: email,
                                          password: password)
        guard let accessToken = auth.accessToken, let userID = auth.resolvedUserID else {
            throw ServiceError.friendly("Check your email to finish signing in, then try again.")
        }
        client?.setSession(accessToken: accessToken, userID: userID)
        sessionStore.save(accessToken: accessToken, refreshToken: auth.refreshToken, userID: userID)
        let profile = try await profileRepository.currentProfile(localProfile: fallback)
        return .remote(profile)
    }

    func signOut() {
        client?.setSession(accessToken: nil, userID: nil)
        sessionStore.clear()
    }

    private func authenticate(path: String,
                              queryItems: [URLQueryItem] = [],
                              email: String,
                              password: String) async throws -> SupabaseAuthResponse {
        guard let client else { throw ServiceError.notConfigured }
        let body = try JSONEncoder().encode(SupabaseAuthRequest(email: email, password: password))
        let data = try await client.authRequest(path: path, queryItems: queryItems, body: body)
        let response = try JSONDecoder().decode(SupabaseAuthResponse.self, from: data)
        guard let accessToken = response.accessToken, !accessToken.isEmpty, response.user != nil else {
            throw ServiceError.friendly("Check your email to finish signing in, then try again.")
        }
        return response
    }

    private func authenticateWithIDToken(provider: String, idToken: String, nonce: String) async throws -> SupabaseAuthResponse {
        guard let client else { throw ServiceError.notConfigured }
        let body = try JSONEncoder().encode(SupabaseIDTokenRequest(idToken: idToken,
                                                                    provider: provider,
                                                                    nonce: nonce))
        let data = try await client.authRequest(path: "auth/v1/token",
                                                queryItems: [URLQueryItem(name: "grant_type", value: "id_token")],
                                                body: body,
                                                authErrorMessage: "Apple sign-in is not enabled for this Supabase project yet.")
        let response = try JSONDecoder().decode(SupabaseAuthResponse.self, from: data)
        guard response.accessToken != nil, response.resolvedUserID != nil else {
            throw ServiceError.invalidResponse
        }
        return response
    }

    private func uniqueAppleUsername(from name: String, userID: String) -> String {
        let base = name
            .lowercased()
            .replacingOccurrences(of: " ", with: "_")
            .filter { $0.isLetter || $0.isNumber || $0 == "_" }
        let suffix = String(userID.prefix(8))
        return "\(base.isEmpty ? "apple" : base)_\(suffix)"
    }
}

struct AuthSessionStore {
    private let tokenKey = "quibble.supabase.accessToken"
    private let refreshKey = "quibble.supabase.refreshToken"
    private let userKey = "quibble.supabase.userID"

    func save(accessToken: String, refreshToken: String?, userID: String) {
        UserDefaults.standard.set(accessToken, forKey: tokenKey)
        UserDefaults.standard.set(userID, forKey: userKey)
        if let refresh = refreshToken, !refresh.isEmpty {
            UserDefaults.standard.set(refresh, forKey: refreshKey)
        } else {
            UserDefaults.standard.removeObject(forKey: refreshKey)
        }
    }

    func load() -> (accessToken: String, refreshToken: String?, userID: String)? {
        guard let token = UserDefaults.standard.string(forKey: tokenKey),
              let userID = UserDefaults.standard.string(forKey: userKey),
              !token.isEmpty, !userID.isEmpty else { return nil }
        let refresh = UserDefaults.standard.string(forKey: refreshKey)
        return (token, refresh, userID)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: refreshKey)
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}

private struct SupabaseAuthRequest: Encodable {
    let email: String
    let password: String
}

private struct SupabaseIDTokenRequest: Encodable {
    let idToken: String
    let provider: String
    let nonce: String

    enum CodingKeys: String, CodingKey {
        case provider, nonce
        case idToken = "id_token"
    }
}

private struct SupabaseTokenRefreshRequest: Encodable {
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

private struct SupabaseAuthResponse: Decodable {
    let accessToken: String?
    let refreshToken: String?
    let user: SupabaseAuthUser?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case user, id
    }

    var resolvedUserID: String? {
        user?.id ?? id
    }
}

private struct SupabaseAuthUser: Decodable {
    let id: String
}
