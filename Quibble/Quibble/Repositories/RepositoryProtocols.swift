import Foundation

protocol TopicRepositoryProtocol {
    func fetchTopics() async throws -> [Topic]
}

protocol QuestionRepositoryProtocol {
    func fetchQuestions(topicID: String, count: Int) async throws -> [Question]
    func fetchQuestions(questionIDs: [String]) async throws -> [Question]
}

protocol ProfileRepositoryProtocol {
    func currentProfile(localProfile: PlayerProfile) async throws -> UserProfile
    func createProfile(username: String, displayName: String, avatarSeed: String) async throws -> UserProfile
    func updateProfile(_ profile: UserProfile) async throws -> UserProfile
}

protocol MatchRepositoryProtocol {
    func findWaitingMatch(topicID: String, excluding userID: String) async throws -> OnlineMatch?
    func createMatch(topicID: String, questionIDs: [String], userID: String) async throws -> OnlineMatch
    func joinMatch(_ matchID: String, userID: String) async throws -> OnlineMatch
    func questionIDs(for matchID: String) async throws -> [String]
    func submitResult(matchID: String, userID: String, answers: [AnswerRecord], topicID: String) async throws -> MatchResult
    func matchHistory(userID: String) async throws -> [MatchResult]
}

protocol LeaderboardRepositoryProtocol {
    func topicLeaderboard(topicID: String, limit: Int) async throws -> [LeaderboardEntry]
    func dailyLeaderboard(dateKey: String, limit: Int) async throws -> [LeaderboardEntry]
}

protocol DailyChallengeRepositoryProtocol {
    func today(userID: String?) async throws -> DailyChallenge
    func submit(result: DailyChallengeResult) async throws -> DailyChallengeResult
}
