import Foundation

enum ServiceError: LocalizedError, Equatable {
    case notConfigured
    case offline
    case invalidResponse
    case duplicateUsername
    case authFailed(String)
    case friendly(String)

    var errorDescription: String? {
        switch self {
        case .notConfigured:
            return "Online mode is not configured."
        case .offline:
            return "Gumrush could not reach the server."
        case .invalidResponse:
            return "Gumrush received an unexpected server response."
        case .duplicateUsername:
            return "That username is taken."
        case .authFailed(let message):
            return message
        case .friendly(let message):
            return message
        }
    }

    var userMessage: String {
        switch self {
        case .notConfigured, .offline:
            return "Online play is taking a breather. Local demo mode still works."
        case .invalidResponse:
            return "Something came back weird. Try again in a moment."
        case .duplicateUsername:
            return "That username is taken. Try another."
        case .authFailed(let message):
            return message
        case .friendly(let message):
            return message
        }
    }
}

// MARK: - Diagnostic logging

/// Prints a prominent, searchable error line to the device console so that
/// friend-code and Supabase failures never fail silently in TestFlight/Xcode
/// logs.
///
/// - Parameters:
///   - context: Human-readable operation label (e.g. "Supabase REST request").
///   - error: The thrown error.
///   - metadata: Optional key-value pairs (method, path, function, status,
///     message). Only allowed keys are included; credential-like keys are
///     silently dropped so secrets never appear in logs.
func logError(_ context: String, error: Error, metadata: [String: String] = [:]) {
    let allowedKeys = Set(["method", "path", "function", "status", "message", "silent",
                           "aud", "iss", "sub_hash", "exp", "expected", "aud_matches_expected"])
    let safe = metadata.filter { allowedKeys.contains($0.key) }

    var output = ["!!! GUMRUSH ERROR !!!"]
    output.append("  context: \(context)")

    if let svc = error as? ServiceError {
        output.append("  user_message: \(svc.userMessage)")
        if let desc = svc.errorDescription {
            output.append("  error_description: \(desc)")
        }
    } else {
        output.append("  error: \(error.localizedDescription)")
        output.append("  error_type: \(String(describing: type(of: error)))")
    }

    for (key, val) in safe.sorted(by: { $0.key < $1.key }) {
        output.append("  \(key): \(val)")
    }

    NSLog("%@", output.joined(separator: "\n"))
}
