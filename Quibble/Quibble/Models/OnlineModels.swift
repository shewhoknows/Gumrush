import Foundation

enum OnlineMode: String, Codable, Equatable {
    case localDemo
    case remote
    case offlineFallback
}

enum ServiceStatus: Equatable {
    case idle
    case loading
    case ready
    case failed(String)
}

struct UserProfile: Identifiable, Codable, Equatable {
    let id: String
    var username: String
    var displayName: String
    var avatarSeed: String
    var totalXP: Int
    var currentStreak: Int
    var createdAt: Date?
    var updatedAt: Date?
}

struct AnswerOption: Identifiable, Codable, Equatable {
    let id: String
    let text: String
    let isCorrect: Bool?
}

enum OnlineMatchStatus: String, Codable, Equatable {
    case waiting
    case inProgress = "in_progress"
    case completed
    case botFallback = "bot_fallback"
}

struct OnlineMatch: Identifiable, Codable, Equatable {
    let id: String
    let topicID: String
    var matchType: String
    var status: OnlineMatchStatus
    var createdBy: String?
    var winnerID: String?
    var createdAt: Date?
    var completedAt: Date?
}

struct MatchPlayer: Identifiable, Codable, Equatable {
    let id: String
    let matchID: String
    let userID: String
    let playerSlot: Int
    var score: Int
    var correctCount: Int
    var avgAnswerMS: Int?
    var bestStreak: Int
    var xpGained: Int
    var completedAt: Date?
}

struct PlayerAnswer: Identifiable, Codable, Equatable {
    let id: String
    let matchID: String
    let userID: String
    let questionID: String
    let selectedOption: String?
    let isCorrect: Bool
    let answerMS: Int
    let points: Int
}

struct MatchResult: Identifiable, Codable, Equatable {
    let id: String
    let match: OnlineMatch
    let player: MatchPlayer
    let opponent: MatchPlayer?
    let answers: [PlayerAnswer]

    var isWaitingForOpponent: Bool {
        match.status == .waiting || opponent?.completedAt == nil
    }
}

struct TopicUserStats: Identifiable, Codable, Equatable {
    let id: String
    let userID: String
    let topicID: String
    var xp: Int
    var wins: Int
    var losses: Int
    var matchesPlayed: Int
    var bestScore: Int
    var correctAnswers: Int
    var totalAnswers: Int
}

struct DailyChallenge: Identifiable, Codable, Equatable {
    let id: String
    let dateKey: String
    let topicID: String?
    let title: String
    let questions: [Question]
    var completedResult: DailyChallengeResult?
}

struct DailyChallengeResult: Identifiable, Codable, Equatable {
    let id: String
    let challengeID: String
    let userID: String
    let score: Int
    let correctCount: Int
    let xpGained: Int
    let completedAt: Date
}

struct OnlineMatchDraft: Equatable {
    let topic: Topic
    let questions: [Question]
    let match: OnlineMatch?
    let opponent: Bot?
    let mode: OnlineMode

    var usesBotFallback: Bool { opponent != nil || mode != .remote }
}
