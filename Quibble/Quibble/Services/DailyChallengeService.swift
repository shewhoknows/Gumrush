import Foundation

final class DailyChallengeService {
    private let remote: DailyChallengeRepositoryProtocol
    private let local: DailyChallengeRepositoryProtocol

    init(remote: DailyChallengeRepositoryProtocol, local: DailyChallengeRepositoryProtocol) {
        self.remote = remote
        self.local = local
    }

    func today(userID: String?) async -> DailyChallenge {
        do {
            return try await remote.today(userID: userID)
        } catch {
            logError("dailyChallenge today remote fetch failed",
                     error: error,
                     metadata: ["function": "dailyChallengeToday"])
            return (try? await local.today(userID: userID))
                ?? DailyChallenge(id: DateKeys.today,
                                  dateKey: DateKeys.today,
                                  topicID: nil,
                                  title: "Daily Challenge",
                                  questions: QuestionBank.dailySet(dateKey: DateKeys.today),
                                  completedResult: nil)
        }
    }

    func submit(result: DailyChallengeResult) async -> DailyChallengeResult? {
        do {
            return try await remote.submit(result: result)
        } catch {
            logError("dailyChallenge submit remote failed",
                     error: error,
                     metadata: ["function": "dailyChallengeSubmit"])
            return try? await local.submit(result: result)
        }
    }
}
