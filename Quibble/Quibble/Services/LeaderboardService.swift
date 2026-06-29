import Foundation

final class LeaderboardService {
    private let remote: LeaderboardRepositoryProtocol
    private let local: LeaderboardRepositoryProtocol

    init(remote: LeaderboardRepositoryProtocol, local: LeaderboardRepositoryProtocol) {
        self.remote = remote
        self.local = local
    }

    func topicLeaderboard(topicID: String, limit: Int = 20) async -> [LeaderboardEntry] {
        do {
            return try await remote.topicLeaderboard(topicID: topicID, limit: limit)
        } catch {
            logError("topicLeaderboard remote fetch failed",
                     error: error,
                     metadata: ["function": "topicLeaderboard"])
            return (try? await local.topicLeaderboard(topicID: topicID, limit: limit)) ?? []
        }
    }

    func dailyLeaderboard(dateKey: String, limit: Int = 20) async -> [LeaderboardEntry] {
        do {
            return try await remote.dailyLeaderboard(dateKey: dateKey, limit: limit)
        } catch {
            logError("dailyLeaderboard remote fetch failed",
                     error: error,
                     metadata: ["function": "dailyLeaderboard"])
            return (try? await local.dailyLeaderboard(dateKey: dateKey, limit: limit)) ?? []
        }
    }
}
