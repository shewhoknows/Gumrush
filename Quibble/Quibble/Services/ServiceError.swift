import Foundation

enum ServiceError: LocalizedError, Equatable {
    case notConfigured
    case offline
    case invalidResponse
    case duplicateUsername
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
        case .friendly(let message):
            return message
        }
    }
}
