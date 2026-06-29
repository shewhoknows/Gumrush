import Foundation

final class MatchService {
    private let remoteMatches: MatchRepositoryProtocol
    private let localMatches: MatchRepositoryProtocol
    private let remoteQuestions: QuestionRepositoryProtocol
    private let localQuestions: QuestionRepositoryProtocol

    init(remoteMatches: MatchRepositoryProtocol,
         localMatches: MatchRepositoryProtocol,
         remoteQuestions: QuestionRepositoryProtocol,
         localQuestions: QuestionRepositoryProtocol) {
        self.remoteMatches = remoteMatches
        self.localMatches = localMatches
        self.remoteQuestions = remoteQuestions
        self.localQuestions = localQuestions
    }

    func prepareAsyncDuel(topic: Topic, userID: String) async -> OnlineMatchDraft {
        await prepareRemoteDuel(topic: topic, userID: userID, matchType: "async", onlineMode: .remote)
    }

    func prepareLiveDuel(topic: Topic, userID: String) async -> OnlineMatchDraft {
        await prepareRemoteDuel(topic: topic, userID: userID, matchType: "live", onlineMode: .live)
    }

    private func prepareRemoteDuel(topic: Topic, userID: String, matchType: String, onlineMode: OnlineMode) async -> OnlineMatchDraft {
        do {
            if let waiting = try await remoteMatches.findWaitingMatch(topicID: topic.id,
                                                                      excluding: userID,
                                                                      matchType: matchType) {
                let questionIDs = try await remoteMatches.questionIDs(for: waiting.id)
                if questionIDs.count == 7 {
                    let joined = try await remoteMatches.joinMatch(waiting.id, userID: userID)
                    let questions = try await remoteQuestions.fetchQuestions(questionIDs: questionIDs)
                    guard questions.count == 7 else { throw ServiceError.invalidResponse }
                    return OnlineMatchDraft(topic: topic,
                                            questions: questions,
                                            match: joined,
                                            opponent: nil,
                                            mode: onlineMode)
                }
                logError("skipped stale remote match",
                         error: ServiceError.invalidResponse,
                         metadata: ["function": "prepareRemoteDuel",
                                   "message": "expected 7 questions, found \(questionIDs.count)"])
            }

            return try await createRemoteMatch(topic: topic,
                                               userID: userID,
                                               matchType: matchType,
                                               onlineMode: onlineMode)
        } catch {
            logError("prepareRemoteDuel remote setup failed",
                     error: error,
                     metadata: ["function": "prepareRemoteDuel"])
            let questions = (try? await localQuestions.fetchQuestions(topicID: topic.id, count: 7))
                ?? QuestionBank.matchSet(topicID: topic.id)
            return OnlineMatchDraft(topic: topic,
                                    questions: questions,
                                    match: nil,
                                    opponent: MockData.randomBot(),
                                    mode: .offlineFallback)
        }
    }

    private func createRemoteMatch(topic: Topic,
                                   userID: String,
                                   matchType: String,
                                   onlineMode: OnlineMode) async throws -> OnlineMatchDraft {
        let questions = try await remoteQuestions.fetchQuestions(topicID: topic.id, count: 7)
        let match = try await remoteMatches.createMatch(topicID: topic.id,
                                                        questionIDs: questions.map(\.id),
                                                        userID: userID,
                                                        matchType: matchType)
        return OnlineMatchDraft(topic: topic,
                                questions: questions,
                                match: match,
                                opponent: nil,
                                mode: onlineMode)
    }

    func submitResult(matchID: String?, userID: String, answers: [AnswerRecord], topicID: String) async -> MatchResult? {
        guard let matchID else { return nil }
        do {
            return try await remoteMatches.submitResult(matchID: matchID, userID: userID, answers: answers, topicID: topicID)
        } catch {
            logError("submitResult remote submit failed",
                     error: error,
                     metadata: ["function": "submitResult"])
            return try? await localMatches.submitResult(matchID: matchID, userID: userID, answers: answers, topicID: topicID)
        }
    }

    func history(userID: String) async -> [MatchResult] {
        do {
            return try await remoteMatches.matchHistory(userID: userID)
        } catch {
            logError("matchHistory remote fetch failed",
                     error: error,
                     metadata: ["function": "matchHistory"])
            return (try? await localMatches.matchHistory(userID: userID)) ?? []
        }
    }
}
