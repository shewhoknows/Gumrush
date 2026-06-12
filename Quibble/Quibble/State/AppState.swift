import SwiftUI

// MARK: - Match summary handed to the results screen

struct XPLine: Identifiable, Equatable {
    let label: String
    let amount: Int
    var id: String { label }
}

struct MatchSummary: Equatable {
    let record: MatchRecord
    let xpLines: [XPLine]
    let totalXP: Int
    let unlocked: [Achievement]
}

// MARK: - App state

final class AppState: ObservableObject {

    @Published var profile: PlayerProfile {
        didSet { persist() }
    }
    @Published var history: [MatchRecord] {
        didSet { persist() }
    }
    @Published var pendingChallenges: [PendingChallenge] {
        didSet { persist() }
    }
    /// Per-topic IDs of questions already served ("shuffle bag") — no question
    /// repeats until a topic's whole pool has been played through.
    @Published var usedQuestions: [String: [String]] {
        didSet { persist() }
    }

    /// Non-nil while a duel flow (matchmaking → quiz → results) is presented.
    @Published var activeMatch: MatchSetup?
    @Published var toast: String?

    private static let profileKey = "quibble.profile.v1"
    private static let historyKey = "quibble.history.v1"
    private static let challengesKey = "quibble.challenges.v1"
    private static let usedQuestionsKey = "quibble.usedQuestions.v1"
    private var toastWork: DispatchWorkItem?

    init() {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: Self.profileKey),
           let saved = try? JSONDecoder().decode(PlayerProfile.self, from: data) {
            profile = saved
        } else {
            profile = PlayerProfile()
        }
        if let data = defaults.data(forKey: Self.historyKey),
           let saved = try? JSONDecoder().decode([MatchRecord].self, from: data) {
            history = saved
        } else {
            history = []
        }
        if let data = defaults.data(forKey: Self.challengesKey),
           let saved = try? JSONDecoder().decode([PendingChallenge].self, from: data) {
            pendingChallenges = saved
        } else {
            pendingChallenges = []
        }
        if let data = defaults.data(forKey: Self.usedQuestionsKey),
           let saved = try? JSONDecoder().decode([String: [String]].self, from: data) {
            usedQuestions = saved
        } else {
            usedQuestions = [:]
        }
        Haptics.enabled = profile.hapticsOn
    }

    private func persist() {
        let defaults = UserDefaults.standard
        if let data = try? JSONEncoder().encode(profile) {
            defaults.set(data, forKey: Self.profileKey)
        }
        if let data = try? JSONEncoder().encode(history) {
            defaults.set(data, forKey: Self.historyKey)
        }
        if let data = try? JSONEncoder().encode(pendingChallenges) {
            defaults.set(data, forKey: Self.challengesKey)
        }
        if let data = try? JSONEncoder().encode(usedQuestions) {
            defaults.set(data, forKey: Self.usedQuestionsKey)
        }
        Haptics.enabled = profile.hapticsOn
    }

    func resetAllData() {
        profile = PlayerProfile()
        history = []
        pendingChallenges = []
        usedQuestions = [:]
    }

    // MARK: - Toasts

    func showToast(_ message: String) {
        toastWork?.cancel()
        withAnimation(.spring(duration: 0.3)) { toast = message }
        let work = DispatchWorkItem { [weak self] in
            withAnimation(.easeOut(duration: 0.25)) { self?.toast = nil }
        }
        toastWork = work
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4, execute: work)
    }

    // MARK: - Question drawing (no repeats until a topic's pool is exhausted)

    func drawQuestions(topicID: String, count: Int = 7) -> [Question] {
        let pool = QuestionBank.questions(for: topicID)
        guard pool.count > count else { return pool.shuffled() }

        let used = Set(usedQuestions[topicID] ?? [])
        var picks = Array(pool.filter { !used.contains($0.id) }.shuffled().prefix(count))

        if picks.count < count {
            // Cycle complete — start a fresh bag, avoiding repeats within this match.
            let alreadyPicked = Set(picks.map(\.id))
            let refill = pool.filter { !alreadyPicked.contains($0.id) }.shuffled()
            picks += refill.prefix(count - picks.count)
            usedQuestions[topicID] = picks.map(\.id)
        } else {
            usedQuestions[topicID] = Array(used) + picks.map(\.id)
        }
        return picks.shuffled()
    }

    func drawMixedSet(count: Int = 7) -> [Question] {
        QuestionBank.topics.shuffled().prefix(count).compactMap { topic in
            drawQuestions(topicID: topic.id, count: 1).first
        }
    }

    // MARK: - Starting matches

    func startQuickDuel() {
        let pool = profile.favoriteTopicIDs.compactMap { QuestionBank.topic($0) }
        let topic = pool.randomElement() ?? QuestionBank.topics.randomElement()!
        start(setup: MatchSetup(id: UUID(), mode: .quick, topic: topic,
                                opponent: MockData.randomBot(),
                                questions: drawQuestions(topicID: topic.id)))
    }

    func startTopicDuel(_ topic: Topic) {
        start(setup: MatchSetup(id: UUID(), mode: .topic, topic: topic,
                                opponent: MockData.randomBot(),
                                questions: drawQuestions(topicID: topic.id)))
    }

    func startDailyChallenge() {
        start(setup: MatchSetup(id: UUID(), mode: .daily, topic: nil,
                                opponent: MockData.dailyBot,
                                questions: QuestionBank.dailySet(dateKey: DateKeys.today)))
    }

    func startFriendDuel(_ friend: Friend, topic: Topic) {
        start(setup: MatchSetup(id: UUID(), mode: .friend, topic: topic,
                                opponent: MockData.bot(for: friend),
                                questions: drawQuestions(topicID: topic.id)))
    }

    private func start(setup: MatchSetup) {
        Haptics.heavy()
        activeMatch = setup
    }

    /// Fresh questions, same opponent — the "one more round" button.
    func rematchSetup(from setup: MatchSetup) -> MatchSetup {
        let questions: [Question]
        if let topic = setup.topic {
            questions = drawQuestions(topicID: topic.id)
        } else {
            // Mixed rematch: one unseen question each from 7 random topics.
            questions = drawMixedSet()
        }
        return MatchSetup(id: UUID(), mode: setup.mode, topic: setup.topic,
                          opponent: setup.opponent, questions: questions)
    }

    // MARK: - Recording a finished match

    func recordMatch(setup: MatchSetup, answers: [AnswerRecord],
                     yourScore: Int, botScore: Int) -> MatchSummary {
        let outcome: MatchOutcome =
            yourScore > botScore ? .win : (yourScore < botScore ? .loss : .draw)

        var lines: [XPLine] = []
        switch outcome {
        case .win:  lines.append(XPLine(label: "Victory", amount: 120))
        case .loss: lines.append(XPLine(label: "Good fight", amount: 60))
        case .draw: lines.append(XPLine(label: "Dead heat", amount: 90))
        }

        let correctCount = answers.filter(\.isCorrect).count
        if correctCount == answers.count && !answers.isEmpty {
            lines.append(XPLine(label: "Perfect 7", amount: 50))
        }

        let today = DateKeys.today
        if setup.mode == .daily && profile.lastDailyDate != today {
            lines.append(XPLine(label: "Daily challenge", amount: 50))
            if profile.lastDailyDate == DateKeys.yesterday {
                profile.dailyStreak += 1
            } else {
                profile.dailyStreak = 1
            }
            profile.bestDailyStreak = max(profile.bestDailyStreak, profile.dailyStreak)
            profile.lastDailyDate = today
        }

        let totalXP = lines.map(\.amount).reduce(0, +)

        let weekKey = DateKeys.weekKey
        if profile.weekKey != weekKey {
            profile.weekKey = weekKey
            profile.weeklyXP = 0
        }
        profile.xp += totalXP
        profile.weeklyXP += totalXP

        let record = MatchRecord(
            id: UUID(), date: Date(), mode: setup.mode,
            topicID: setup.topicID, topicName: setup.topicName,
            opponentName: setup.opponent.name,
            opponentColorName: setup.opponent.colorName,
            yourScore: yourScore, opponentScore: botScore,
            outcome: outcome, xpEarned: totalXP, answers: answers)
        history.insert(record, at: 0)

        let unlocked = evaluateAchievements()
        return MatchSummary(record: record, xpLines: lines, totalXP: totalXP, unlocked: unlocked)
    }

    // MARK: - Derived stats

    var totalMatches: Int { history.count }
    var totalWins: Int { history.filter { $0.outcome == .win }.count }
    var winRate: Int {
        totalMatches == 0 ? 0 : Int((Double(totalWins) / Double(totalMatches) * 100).rounded())
    }
    var bestScore: Int { history.map(\.yourScore).max() ?? 0 }
    var distinctTopicsPlayed: Int { Set(history.map(\.topicID)).count }
    var dailyDoneToday: Bool { profile.lastDailyDate == DateKeys.today }

    func topicStats(_ topicID: String) -> (played: Int, wins: Int, best: Int) {
        let games = history.filter { $0.topicID == topicID }
        return (games.count,
                games.filter { $0.outcome == .win }.count,
                games.map(\.yourScore).max() ?? 0)
    }

    /// Days (as "yyyy-MM-dd") on which a daily challenge was completed.
    var dailyCompletionDays: Set<String> {
        Set(history.filter { $0.mode == .daily }.map { DateKeys.key(for: $0.date) })
    }

    // MARK: - Leaderboards

    func leaderboard(weekly: Bool) -> [LeaderboardEntry] {
        let weekKey = DateKeys.weekKey
        var entries = MockData.leaderboardSeeds.map { seed in
            LeaderboardEntry(id: seed.name, name: seed.name, colorName: seed.colorName,
                             xp: weekly ? MockData.weeklyXP(for: seed, weekKey: weekKey) : seed.baseXP,
                             isPlayer: false)
        }
        entries.append(LeaderboardEntry(id: "player", name: profile.name,
                                        colorName: profile.colorName,
                                        xp: weekly ? profile.weeklyXP : profile.xp,
                                        isPlayer: true))
        return entries.sorted { $0.xp > $1.xp }
    }

    func friendLeaderboard() -> [LeaderboardEntry] {
        var entries = MockData.friends.map { friend in
            LeaderboardEntry(id: friend.id, name: friend.name, colorName: friend.colorName,
                             xp: friend.level * PlayerProfile.xpPerLevel - 180,
                             isPlayer: false)
        }
        entries.append(LeaderboardEntry(id: "player", name: profile.name,
                                        colorName: profile.colorName,
                                        xp: profile.xp, isPlayer: true))
        return entries.sorted { $0.xp > $1.xp }
    }

    // MARK: - Friend challenges (mock)

    func sendChallenge(to friend: Friend, topic: Topic) {
        pendingChallenges.insert(
            PendingChallenge(id: UUID(), friendName: friend.name,
                             friendColorName: friend.colorName,
                             topicID: topic.id, topicName: topic.name, date: Date()),
            at: 0)
        profile.challengesSent += 1
        let unlocked = evaluateAchievements()
        showToast("Challenge sent to \(friend.name)! (demo)")
        if let first = unlocked.first {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) { [weak self] in
                self?.showToast("Achievement unlocked: \(first.name)!")
            }
        }
    }

    func removeChallenge(_ challenge: PendingChallenge) {
        pendingChallenges.removeAll { $0.id == challenge.id }
    }

    // MARK: - Achievements

    func isUnlocked(_ id: String) -> Bool {
        profile.unlockedAchievements.contains(id)
    }

    @discardableResult
    func evaluateAchievements() -> [Achievement] {
        var newly: [Achievement] = []
        func unlock(_ id: String, when condition: Bool) {
            guard condition, !profile.unlockedAchievements.contains(id) else { return }
            profile.unlockedAchievements.append(id)
            if let achievement = MockData.achievement(id) {
                newly.append(achievement)
            }
        }

        unlock("first_win", when: totalWins >= 1)
        unlock("perfect7", when: history.contains { $0.isPerfect })
        unlock("wins5", when: totalWins >= 5)
        unlock("wins25", when: totalWins >= 25)
        unlock("matches10", when: totalMatches >= 10)
        unlock("speedy", when: history.contains {
            $0.outcome == .win && $0.averageAnswerTime > 0 && $0.averageAnswerTime < 4
        })
        unlock("bigbrain", when: bestScore >= 900)
        unlock("explorer", when: distinctTopicsPlayed >= 5)
        unlock("daily1", when: !profile.lastDailyDate.isEmpty)
        unlock("streak3", when: profile.bestDailyStreak >= 3)
        unlock("streak7", when: profile.bestDailyStreak >= 7)
        unlock("instigator", when: profile.challengesSent >= 1)
        return newly
    }
}
