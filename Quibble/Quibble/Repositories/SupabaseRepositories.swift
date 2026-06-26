import Foundation

final class SupabaseTopicRepository: TopicRepositoryProtocol {
    private let client: SupabaseRESTClient?

    init(client: SupabaseRESTClient?) {
        self.client = client
    }

    func fetchTopics() async throws -> [Topic] {
        guard let client else { throw ServiceError.notConfigured }
        let data = try await client.request(
            path: "rest/v1/topics",
            queryItems: [
                URLQueryItem(name: "select", value: "id,slug,title,subtitle,description,color_key,icon_asset_name"),
                URLQueryItem(name: "status", value: "eq.active"),
                URLQueryItem(name: "order", value: "is_featured.desc,title.asc")
            ])
        return try JSONDecoder().decode([SupabaseTopicDTO].self, from: data).map(\.topic)
    }
}

final class SupabaseQuestionRepository: QuestionRepositoryProtocol {
    private let client: SupabaseRESTClient?

    init(client: SupabaseRESTClient?) {
        self.client = client
    }

    func fetchQuestions(topicID: String, count: Int) async throws -> [Question] {
        guard let client else { throw ServiceError.notConfigured }
        let data = try await client.request(
            path: "rest/v1/questions",
            queryItems: [
                URLQueryItem(name: "select", value: "id,topic_id,prompt,option_a,option_b,option_c,option_d,correct_option,difficulty,topics!inner(slug)"),
                URLQueryItem(name: "status", value: "eq.approved"),
                URLQueryItem(name: "topics.slug", value: "eq.\(topicID)"),
                URLQueryItem(name: "limit", value: "\(count)")
            ])
        return try JSONDecoder().decode([SupabaseQuestionDTO].self, from: data).map(\.question)
    }

    func fetchQuestions(questionIDs: [String]) async throws -> [Question] {
        guard let client else { throw ServiceError.notConfigured }
        guard !questionIDs.isEmpty else { return [] }
        let quoted = questionIDs.map { "\"\($0)\"" }.joined(separator: ",")
        let data = try await client.request(
            path: "rest/v1/questions",
            queryItems: [
                URLQueryItem(name: "select", value: "id,topic_id,prompt,option_a,option_b,option_c,option_d,correct_option,difficulty"),
                URLQueryItem(name: "id", value: "in.(\(quoted))")
            ])
        return try JSONDecoder().decode([SupabaseQuestionDTO].self, from: data).map(\.question)
    }
}

final class SupabaseProfileRepository: ProfileRepositoryProtocol {
    private let client: SupabaseRESTClient?

    init(client: SupabaseRESTClient?) {
        self.client = client
    }

    func currentProfile(localProfile: PlayerProfile) async throws -> UserProfile {
        guard let client, let userID = client.currentUserID else { throw ServiceError.notConfigured }
        let data = try await client.request(
            path: "rest/v1/profiles",
            queryItems: [
                URLQueryItem(name: "select", value: "id,username,display_name,avatar_seed,total_xp,current_streak,created_at,updated_at"),
                URLQueryItem(name: "id", value: "eq.\(userID)"),
                URLQueryItem(name: "limit", value: "1")
            ])
        let profiles = try decoder.decode([SupabaseProfileDTO].self, from: data)
        if let profile = profiles.first?.userProfile {
            return profile
        }
        return try await createProfile(username: localProfile.name.lowercased().replacingOccurrences(of: " ", with: "_"),
                                       displayName: localProfile.name,
                                       avatarSeed: localProfile.colorName)
    }

    func createProfile(username: String, displayName: String, avatarSeed: String) async throws -> UserProfile {
        guard let client, let userID = client.currentUserID else { throw ServiceError.notConfigured }
        let cleaned = username.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleaned.isEmpty else { throw ServiceError.friendly("Pick a username first.") }
        let payload = ProfilePayload(id: userID,
                                     username: cleaned,
                                     displayName: displayName,
                                     avatarSeed: avatarSeed,
                                     totalXP: 0,
                                     currentStreak: 0)
        let data = try encoder.encode(payload)
        let response = try await client.request(
            path: "rest/v1/profiles",
            method: "POST",
            queryItems: [URLQueryItem(name: "select", value: "id,username,display_name,avatar_seed,total_xp,current_streak,created_at,updated_at")],
            body: data)
        return try decoder.decode([SupabaseProfileDTO].self, from: response).first?.userProfile
            ?? UserProfile(id: userID, username: cleaned, displayName: displayName, avatarSeed: avatarSeed,
                           totalXP: 0, currentStreak: 0, createdAt: nil, updatedAt: nil)
    }

    func updateProfile(_ profile: UserProfile) async throws -> UserProfile {
        guard let client else { throw ServiceError.notConfigured }
        let payload = ProfilePayload(id: profile.id,
                                     username: profile.username,
                                     displayName: profile.displayName,
                                     avatarSeed: profile.avatarSeed,
                                     totalXP: profile.totalXP,
                                     currentStreak: profile.currentStreak)
        let data = try encoder.encode(payload)
        let response = try await client.request(
            path: "rest/v1/profiles",
            method: "PATCH",
            queryItems: [
                URLQueryItem(name: "id", value: "eq.\(profile.id)"),
                URLQueryItem(name: "select", value: "id,username,display_name,avatar_seed,total_xp,current_streak,created_at,updated_at")
            ],
            body: data)
        return try decoder.decode([SupabaseProfileDTO].self, from: response).first?.userProfile ?? profile
    }

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}

private struct ProfilePayload: Encodable {
    let id: String
    let username: String
    let displayName: String
    let avatarSeed: String
    let totalXP: Int
    let currentStreak: Int
}

final class SupabaseMatchRepository: MatchRepositoryProtocol {
    private let client: SupabaseRESTClient?

    init(client: SupabaseRESTClient?) {
        self.client = client
    }

    func findWaitingMatch(topicID: String, excluding userID: String) async throws -> OnlineMatch? {
        guard let client else { throw ServiceError.notConfigured }
        let topicUUID = try await resolveTopicID(slug: topicID, client: client)
        let data = try await client.request(
            path: "rest/v1/matches",
            queryItems: [
                URLQueryItem(name: "select", value: "id,topic_id,match_type,status,created_by,winner_id,created_at,completed_at"),
                URLQueryItem(name: "topic_id", value: "eq.\(topicUUID)"),
                URLQueryItem(name: "status", value: "eq.waiting"),
                URLQueryItem(name: "created_by", value: "neq.\(userID)"),
                URLQueryItem(name: "order", value: "created_at.asc"),
                URLQueryItem(name: "limit", value: "1")
            ])
        return try decoder.decode([SupabaseMatchDTO].self, from: data).first?.match
    }

    func createMatch(topicID: String, questionIDs: [String], userID: String) async throws -> OnlineMatch {
        guard let client else { throw ServiceError.notConfigured }
        let topicUUID = try await resolveTopicID(slug: topicID, client: client)
        let payload = MatchPayload(topicID: topicUUID,
                                   matchType: "async",
                                   status: "waiting",
                                   createdBy: userID,
                                   winnerID: nil,
                                   completedAt: nil)
        let matchData = try await client.request(
            path: "rest/v1/matches",
            method: "POST",
            queryItems: [URLQueryItem(name: "select", value: "id,topic_id,match_type,status,created_by,winner_id,created_at,completed_at")],
            body: encoder.encode(payload))
        guard let match = try decoder.decode([SupabaseMatchDTO].self, from: matchData).first?.match else {
            throw ServiceError.invalidResponse
        }
        _ = try await client.request(
            path: "rest/v1/match_players",
            method: "POST",
            body: encoder.encode(MatchPlayerPayload(matchID: match.id, userID: userID, playerSlot: 1,
                                                    score: 0, correctCount: 0, avgAnswerMS: nil,
                                                    bestStreak: 0, xpGained: 0, completedAt: nil)))
        let questionRows = questionIDs.enumerated().map {
            MatchQuestionPayload(matchID: match.id, questionID: $0.element, questionIndex: $0.offset)
        }
        _ = try await client.request(path: "rest/v1/match_questions",
                                     method: "POST",
                                     body: encoder.encode(questionRows))
        return match
    }

    func joinMatch(_ matchID: String, userID: String) async throws -> OnlineMatch {
        guard let client else { throw ServiceError.notConfigured }
        _ = try await client.request(
            path: "rest/v1/match_players",
            method: "POST",
            body: encoder.encode(MatchPlayerPayload(matchID: matchID, userID: userID, playerSlot: 2,
                                                    score: 0, correctCount: 0, avgAnswerMS: nil,
                                                    bestStreak: 0, xpGained: 0, completedAt: nil)))
        let response = try await client.request(
            path: "rest/v1/matches",
            method: "PATCH",
            queryItems: [
                URLQueryItem(name: "id", value: "eq.\(matchID)"),
                URLQueryItem(name: "select", value: "id,topic_id,match_type,status,created_by,winner_id,created_at,completed_at")
            ],
            body: encoder.encode(MatchStatusPayload(status: "in_progress", winnerID: nil, completedAt: nil)))
        return try decoder.decode([SupabaseMatchDTO].self, from: response).first?.match
            ?? OnlineMatch(id: matchID, topicID: "mixed", matchType: "async", status: .inProgress,
                           createdBy: nil, winnerID: nil, createdAt: nil, completedAt: nil)
    }

    func questionIDs(for matchID: String) async throws -> [String] {
        guard let client else { throw ServiceError.notConfigured }
        let data = try await client.request(
            path: "rest/v1/match_questions",
            queryItems: [
                URLQueryItem(name: "select", value: "question_id,question_index"),
                URLQueryItem(name: "match_id", value: "eq.\(matchID)"),
                URLQueryItem(name: "order", value: "question_index.asc")
            ])
        return try JSONDecoder().decode([SupabaseDailyQuestionDTO].self, from: data).map(\.questionID)
    }

    func submitResult(matchID: String, userID: String, answers: [AnswerRecord], topicID: String) async throws -> MatchResult {
        guard let client else { throw ServiceError.notConfigured }
        do {
            return try await submitViaEdgeFunction(matchID: matchID, userID: userID, answers: answers, client: client)
        } catch {
            print("Quibble submit_match_answers function unavailable, using direct table fallback: \(error)")
        }
        return try await submitResultDirectly(matchID: matchID, userID: userID, answers: answers, client: client)
    }

    private func submitViaEdgeFunction(matchID: String,
                                       userID: String,
                                       answers: [AnswerRecord],
                                       client: SupabaseRESTClient) async throws -> MatchResult {
        let payload = EdgeSubmitMatchPayload(matchID: matchID,
                                             answers: answers.map {
                                                 EdgeSubmittedAnswer(questionID: $0.questionID,
                                                                     selectedOption: optionLetter($0.chosenIndex),
                                                                     answerMS: Int($0.timeTaken * 1000))
                                             })
        let data = try await client.invokeFunction("submit_match_answers", body: encoder.encode(payload))
        let response = try decoder.decode(EdgeSubmitMatchResponse.self, from: data)
        return response.result(id: matchID, userID: userID)
    }

    private func submitResultDirectly(matchID: String,
                                      userID: String,
                                      answers: [AnswerRecord],
                                      client: SupabaseRESTClient) async throws -> MatchResult {
        let score = answers.map(\.points).reduce(0, +)
        let correct = answers.filter(\.isCorrect).count
        let playerRows = try await fetchPlayers(matchID: matchID, client: client)
        let slot = playerRows.first(where: { $0.userID == userID })?.playerSlot ?? 1
        let completedAt = ISO8601DateFormatter().string(from: Date())
        let answerPayloads = answers.map {
            PlayerAnswerPayload(matchID: matchID,
                                userID: userID,
                                questionID: $0.questionID,
                                selectedOption: optionLetter($0.chosenIndex),
                                isCorrect: $0.isCorrect,
                                answerMS: Int($0.timeTaken * 1000),
                                points: $0.points)
        }
        if !answerPayloads.isEmpty {
            _ = try await client.request(path: "rest/v1/player_answers",
                                         method: "POST",
                                         body: encoder.encode(answerPayloads))
        }

        let playerPatch = MatchPlayerPayload(matchID: matchID,
                                             userID: userID,
                                             playerSlot: slot,
                                             score: score,
                                             correctCount: correct,
                                             avgAnswerMS: averageMS(answers),
                                             bestStreak: bestStreak(answers),
                                             xpGained: 60,
                                             completedAt: completedAt)
        let playerResponse = try await client.request(
            path: "rest/v1/match_players",
            method: "PATCH",
            queryItems: [
                URLQueryItem(name: "match_id", value: "eq.\(matchID)"),
                URLQueryItem(name: "user_id", value: "eq.\(userID)"),
                URLQueryItem(name: "select", value: "id,match_id,user_id,player_slot,score,correct_count,avg_answer_ms,best_streak,xp_gained,completed_at")
            ],
            body: encoder.encode(playerPatch))
        let player = try decoder.decode([SupabaseMatchPlayerDTO].self, from: playerResponse).first?.player
            ?? playerPatch.player(id: UUID().uuidString)

        let refreshedPlayers = try await fetchPlayers(matchID: matchID, client: client)
        let completedPlayers = refreshedPlayers.filter { $0.completedAt != nil || $0.userID == userID }
        var match = try await fetchMatch(matchID: matchID, client: client)
        if completedPlayers.count >= 2, let winner = completedPlayers.max(by: { $0.score < $1.score }) {
            let response = try await client.request(
                path: "rest/v1/matches",
                method: "PATCH",
                queryItems: [
                    URLQueryItem(name: "id", value: "eq.\(matchID)"),
                    URLQueryItem(name: "select", value: "id,topic_id,match_type,status,created_by,winner_id,created_at,completed_at")
                ],
                body: encoder.encode(MatchStatusPayload(status: "completed",
                                                        winnerID: winner.userID,
                                                        completedAt: completedAt)))
            match = try decoder.decode([SupabaseMatchDTO].self, from: response).first?.match ?? match
        }

        return MatchResult(id: matchID,
                           match: match,
                           player: player,
                           opponent: refreshedPlayers.first { $0.userID != userID },
                           answers: answerPayloads.map { $0.playerAnswer(id: UUID().uuidString) })
    }

    func matchHistory(userID: String) async throws -> [MatchResult] {
        guard let client else { throw ServiceError.notConfigured }
        let playerData = try await client.request(
            path: "rest/v1/match_players",
            queryItems: [
                URLQueryItem(name: "select", value: "id,match_id,user_id,player_slot,score,correct_count,avg_answer_ms,best_streak,xp_gained,completed_at"),
                URLQueryItem(name: "user_id", value: "eq.\(userID)"),
                URLQueryItem(name: "order", value: "completed_at.desc.nullslast"),
                URLQueryItem(name: "limit", value: "30")
            ])
        let players = try decoder.decode([SupabaseMatchPlayerDTO].self, from: playerData).map(\.player)
        var results: [MatchResult] = []
        for player in players {
            let match = try await fetchMatch(matchID: player.matchID, client: client)
            let allPlayers = try await fetchPlayers(matchID: player.matchID, client: client)
            results.append(MatchResult(id: player.matchID,
                                       match: match,
                                       player: player,
                                       opponent: allPlayers.first { $0.userID != userID },
                                       answers: []))
        }
        return results
    }

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }

    private func resolveTopicID(slug: String, client: SupabaseRESTClient) async throws -> String {
        let data = try await client.request(
            path: "rest/v1/topics",
            queryItems: [
                URLQueryItem(name: "select", value: "id,slug,title,subtitle,description,color_key,icon_asset_name"),
                URLQueryItem(name: "slug", value: "eq.\(slug)"),
                URLQueryItem(name: "limit", value: "1")
            ])
        guard let dto = try decoder.decode([SupabaseTopicDTO].self, from: data).first else {
            throw ServiceError.invalidResponse
        }
        return dto.id
    }

    private func fetchMatch(matchID: String, client: SupabaseRESTClient) async throws -> OnlineMatch {
        let data = try await client.request(
            path: "rest/v1/matches",
            queryItems: [
                URLQueryItem(name: "select", value: "id,topic_id,match_type,status,created_by,winner_id,created_at,completed_at"),
                URLQueryItem(name: "id", value: "eq.\(matchID)"),
                URLQueryItem(name: "limit", value: "1")
            ])
        guard let match = try decoder.decode([SupabaseMatchDTO].self, from: data).first?.match else {
            throw ServiceError.invalidResponse
        }
        return match
    }

    private func fetchPlayers(matchID: String, client: SupabaseRESTClient) async throws -> [MatchPlayer] {
        let data = try await client.request(
            path: "rest/v1/match_players",
            queryItems: [
                URLQueryItem(name: "select", value: "id,match_id,user_id,player_slot,score,correct_count,avg_answer_ms,best_streak,xp_gained,completed_at"),
                URLQueryItem(name: "match_id", value: "eq.\(matchID)")
            ])
        return try decoder.decode([SupabaseMatchPlayerDTO].self, from: data).map(\.player)
    }

    private func optionLetter(_ index: Int?) -> String? {
        guard let index else { return nil }
        return ["A", "B", "C", "D"][safe: index]
    }

    private func averageMS(_ answers: [AnswerRecord]) -> Int? {
        guard !answers.isEmpty else { return nil }
        return Int((answers.map(\.timeTaken).reduce(0, +) / Double(answers.count)) * 1000)
    }

    private func bestStreak(_ answers: [AnswerRecord]) -> Int {
        var best = 0
        var run = 0
        for answer in answers {
            run = answer.isCorrect ? run + 1 : 0
            best = max(best, run)
        }
        return best
    }
}

private struct MatchPayload: Encodable {
    let topicID: String
    let matchType: String
    let status: String
    let createdBy: String
    let winnerID: String?
    let completedAt: String?
}

private struct MatchStatusPayload: Encodable {
    let status: String
    let winnerID: String?
    let completedAt: String?
}

private struct EdgeSubmitMatchPayload: Encodable {
    let matchID: String
    let answers: [EdgeSubmittedAnswer]
}

private struct EdgeSubmittedAnswer: Encodable {
    let questionID: String
    let selectedOption: String?
    let answerMS: Int
}

private struct EdgeSubmitMatchResponse: Decodable {
    let match: SupabaseMatchDTO
    let player: SupabaseMatchPlayerDTO
    let opponent: SupabaseMatchPlayerDTO?
    let answers: [EdgePlayerAnswerDTO]

    func result(id: String, userID: String) -> MatchResult {
        MatchResult(id: id,
                    match: match.match,
                    player: player.player,
                    opponent: opponent?.player,
                    answers: answers.map { $0.answer(matchID: id, userID: userID) })
    }
}

private struct EdgePlayerAnswerDTO: Decodable {
    let matchID: String?
    let userID: String?
    let questionID: String
    let selectedOption: String?
    let isCorrect: Bool
    let answerMS: Int
    let points: Int

    enum CodingKeys: String, CodingKey {
        case points
        case matchID = "match_id"
        case userID = "user_id"
        case questionID = "question_id"
        case selectedOption = "selected_option"
        case isCorrect = "is_correct"
        case answerMS = "answer_ms"
    }

    func answer(matchID fallbackMatchID: String, userID fallbackUserID: String) -> PlayerAnswer {
        PlayerAnswer(id: questionID,
                     matchID: matchID ?? fallbackMatchID,
                     userID: userID ?? fallbackUserID,
                     questionID: questionID,
                     selectedOption: selectedOption,
                     isCorrect: isCorrect,
                     answerMS: answerMS,
                     points: points)
    }
}

private struct MatchPlayerPayload: Encodable {
    let matchID: String
    let userID: String
    let playerSlot: Int
    let score: Int
    let correctCount: Int
    let avgAnswerMS: Int?
    let bestStreak: Int
    let xpGained: Int
    let completedAt: String?

    func player(id: String) -> MatchPlayer {
        MatchPlayer(id: id,
                    matchID: matchID,
                    userID: userID,
                    playerSlot: playerSlot,
                    score: score,
                    correctCount: correctCount,
                    avgAnswerMS: avgAnswerMS,
                    bestStreak: bestStreak,
                    xpGained: xpGained,
                    completedAt: nil)
    }
}

private struct MatchQuestionPayload: Encodable {
    let matchID: String
    let questionID: String
    let questionIndex: Int
}

private struct PlayerAnswerPayload: Encodable {
    let matchID: String
    let userID: String
    let questionID: String
    let selectedOption: String?
    let isCorrect: Bool
    let answerMS: Int
    let points: Int

    func playerAnswer(id: String) -> PlayerAnswer {
        PlayerAnswer(id: id,
                     matchID: matchID,
                     userID: userID,
                     questionID: questionID,
                     selectedOption: selectedOption,
                     isCorrect: isCorrect,
                     answerMS: answerMS,
                     points: points)
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

final class SupabaseLeaderboardRepository: LeaderboardRepositoryProtocol {
    private let client: SupabaseRESTClient?

    init(client: SupabaseRESTClient?) {
        self.client = client
    }

    func topicLeaderboard(topicID: String, limit: Int) async throws -> [LeaderboardEntry] {
        guard let client else { throw ServiceError.notConfigured }
        var query = [
            URLQueryItem(name: "select", value: "id,user_id,xp,best_score,profiles(username,display_name,avatar_seed)"),
            URLQueryItem(name: "order", value: "xp.desc"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        if topicID != "all" {
            query.append(URLQueryItem(name: "topic_id", value: "eq.\(topicID)"))
        }
        let data = try await client.request(path: "rest/v1/topic_user_stats", queryItems: query)
        return try JSONDecoder().decode([SupabaseLeaderboardDTO].self, from: data).map(\.entry)
    }

    func dailyLeaderboard(dateKey: String, limit: Int) async throws -> [LeaderboardEntry] {
        guard let client else { throw ServiceError.notConfigured }
        let challenges = try await client.request(
            path: "rest/v1/daily_challenges",
            queryItems: [
                URLQueryItem(name: "select", value: "id"),
                URLQueryItem(name: "challenge_date", value: "eq.\(dateKey)"),
                URLQueryItem(name: "limit", value: "1")
            ])
        struct ChallengeID: Decodable { let id: String }
        guard let challengeID = try JSONDecoder().decode([ChallengeID].self, from: challenges).first?.id else {
            return []
        }
        let data = try await client.request(
            path: "rest/v1/daily_challenge_results",
            queryItems: [
                URLQueryItem(name: "select", value: "id,user_id,score,profiles(username,display_name,avatar_seed)"),
                URLQueryItem(name: "daily_challenge_id", value: "eq.\(challengeID)"),
                URLQueryItem(name: "order", value: "score.desc"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ])
        struct DailyRow: Decodable {
            let userID: String
            let score: Int
            let profiles: SupabaseLeaderboardProfileDTO?
            enum CodingKeys: String, CodingKey {
                case score, profiles
                case userID = "user_id"
            }
            var entry: LeaderboardEntry {
                LeaderboardEntry(id: userID,
                                 name: profiles?.displayName ?? profiles?.username ?? "Player",
                                 colorName: profiles?.avatarSeed ?? "yellow",
                                 xp: score,
                                 isPlayer: false)
            }
        }
        return try JSONDecoder().decode([DailyRow].self, from: data).map(\.entry)
    }
}

final class SupabaseDailyChallengeRepository: DailyChallengeRepositoryProtocol {
    private let client: SupabaseRESTClient?

    init(client: SupabaseRESTClient?) {
        self.client = client
    }

    func today(userID: String?) async throws -> DailyChallenge {
        guard let client else { throw ServiceError.notConfigured }
        let challengeData = try await client.request(
            path: "rest/v1/daily_challenges",
            queryItems: [
                URLQueryItem(name: "select", value: "id,challenge_date,topic_id,title"),
                URLQueryItem(name: "challenge_date", value: "eq.\(DateKeys.today)"),
                URLQueryItem(name: "status", value: "eq.active"),
                URLQueryItem(name: "limit", value: "1")
            ])
        guard let challenge = try decoder.decode([SupabaseDailyChallengeDTO].self, from: challengeData).first else {
            throw ServiceError.invalidResponse
        }
        let questionRows = try await client.request(
            path: "rest/v1/daily_challenge_questions",
            queryItems: [
                URLQueryItem(name: "select", value: "question_id,question_index"),
                URLQueryItem(name: "daily_challenge_id", value: "eq.\(challenge.id)"),
                URLQueryItem(name: "order", value: "question_index.asc")
            ])
        let questionIDs = try JSONDecoder().decode([SupabaseDailyQuestionDTO].self, from: questionRows).map(\.questionID)
        let questions = try await SupabaseQuestionRepository(client: client).fetchQuestions(questionIDs: questionIDs)
        let completed: DailyChallengeResult?
        if let userID {
            let resultData = try await client.request(
                path: "rest/v1/daily_challenge_results",
                queryItems: [
                    URLQueryItem(name: "select", value: "id,daily_challenge_id,user_id,score,correct_count,xp_gained,completed_at"),
                    URLQueryItem(name: "daily_challenge_id", value: "eq.\(challenge.id)"),
                    URLQueryItem(name: "user_id", value: "eq.\(userID)"),
                    URLQueryItem(name: "limit", value: "1")
                ])
            completed = try decoder.decode([SupabaseDailyResultDTO].self, from: resultData).first?.result
        } else {
            completed = nil
        }
        return DailyChallenge(id: challenge.id,
                              dateKey: challenge.challengeDate,
                              topicID: challenge.topicID,
                              title: challenge.title,
                              questions: questions,
                              completedResult: completed)
    }

    func submit(result: DailyChallengeResult) async throws -> DailyChallengeResult {
        guard let client else { throw ServiceError.notConfigured }
        let payload = DailyResultPayload(dailyChallengeID: result.challengeID,
                                         userID: result.userID,
                                         score: result.score,
                                         correctCount: result.correctCount,
                                         xpGained: result.xpGained)
        let data = try await client.request(
            path: "rest/v1/daily_challenge_results",
            method: "POST",
            queryItems: [
                URLQueryItem(name: "on_conflict", value: "daily_challenge_id,user_id"),
                URLQueryItem(name: "select", value: "id,daily_challenge_id,user_id,score,correct_count,xp_gained,completed_at")
            ],
            body: encoder.encode(payload))
        return try decoder.decode([SupabaseDailyResultDTO].self, from: data).first?.result ?? result
    }

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}

private struct DailyResultPayload: Encodable {
    let dailyChallengeID: String
    let userID: String
    let score: Int
    let correctCount: Int
    let xpGained: Int
}
