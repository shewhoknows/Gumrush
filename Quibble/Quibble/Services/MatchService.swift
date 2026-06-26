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
        do {
            if let waiting = try await remoteMatches.findWaitingMatch(topicID: topic.id, excluding: userID) {
                let joined = try await remoteMatches.joinMatch(waiting.id, userID: userID)
                let questionIDs = try await remoteMatches.questionIDs(for: waiting.id)
                let questions = try await remoteQuestions.fetchQuestions(questionIDs: questionIDs)
                guard questions.count == 7 else { throw ServiceError.invalidResponse }
                return OnlineMatchDraft(topic: topic,
                                        questions: questions,
                                        match: joined,
                                        opponent: nil,
                                        mode: .remote)
            }

            let questions = try await remoteQuestions.fetchQuestions(topicID: topic.id, count: 7)
            let match = try await remoteMatches.createMatch(topicID: topic.id,
                                                            questionIDs: questions.map(\.id),
                                                            userID: userID)
            return OnlineMatchDraft(topic: topic,
                                    questions: questions,
                                    match: match,
                                    opponent: nil,
                                    mode: .remote)
        } catch {
            let questions = (try? await localQuestions.fetchQuestions(topicID: topic.id, count: 7))
                ?? QuestionBank.matchSet(topicID: topic.id)
            return OnlineMatchDraft(topic: topic,
                                    questions: questions,
                                    match: nil,
                                    opponent: MockData.randomBot(),
                                    mode: .offlineFallback)
        }
    }

    func submitResult(matchID: String?, userID: String, answers: [AnswerRecord], topicID: String) async -> MatchResult? {
        guard let matchID else { return nil }
        do {
            return try await remoteMatches.submitResult(matchID: matchID, userID: userID, answers: answers, topicID: topicID)
        } catch {
            return try? await localMatches.submitResult(matchID: matchID, userID: userID, answers: answers, topicID: topicID)
        }
    }

    func history(userID: String) async -> [MatchResult] {
        do {
            return try await remoteMatches.matchHistory(userID: userID)
        } catch {
            return (try? await localMatches.matchHistory(userID: userID)) ?? []
        }
    }
}
