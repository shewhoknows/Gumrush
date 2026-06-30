import AuthenticationServices
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

// MARK: - Friend code display state

/// Finite-state derivation for friend-code UI.
/// Both ChallengeFriendView and ProfileView use the same ordering:
/// display → loading → error → fetchAction → signedOut.
enum FriendCodeDisplayState: Equatable {
    case display(String)
    case loading
    case error(String)
    case fetchAction
    case signedOut
}

// MARK: - App state

@MainActor
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
    @Published var selectedTab: MainTab = .home
    @Published var authSession: AuthSession?
    @Published var onlineMode: OnlineMode
    @Published var serviceStatus: ServiceStatus = .idle
    @Published var waitingMatches: [MatchResult] = []
    @Published var toast: String?

    /// Friend-code + live room state (Phase 2).
    @Published var friendCode: String?
    @Published var isLoadingFriendCode = false
    @Published var friendCodeError: String?
    @Published var friendSearchResult: PublicFriendProfile?
    @Published var friends: [Friendship] = []
    @Published var incomingFriendRequests: [Friendship] = []
    @Published var outgoingFriendRequests: [Friendship] = []
    @Published var liveRoomInvite: LiveDuelInvite?
    @Published var pendingLiveRoom: PendingLiveRoom?
    @Published var incomingLiveChallenges: [IncomingLiveChallenge] = []
    @Published var onlineFriendIDs: Set<String> = []

    private static let profileKey = "quibble.profile.v1"
    private static let historyKey = "quibble.history.v1"
    private static let challengesKey = "quibble.challenges.v1"
    private static let usedQuestionsKey = "quibble.usedQuestions.v1"
    private let services: AppServices
    private var toastWork: DispatchWorkItem?
    private var friendPresenceSession: FriendPresenceSession?

    init(services: AppServices = AppServices()) {
        self.services = services
        onlineMode = services.config.onlineMode
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
        Task { await establishGuestSession() }
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
        waitingMatches = []
        friendCode = nil
        isLoadingFriendCode = false
        friendCodeError = nil
        friendSearchResult = nil
        friends = []
        incomingFriendRequests = []
        outgoingFriendRequests = []
        liveRoomInvite = nil
        pendingLiveRoom = nil
        incomingLiveChallenges = []
        onlineFriendIDs = []
        stopFriendPresence()
        Task { await establishGuestSession() }
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

    // MARK: - Apple sign-in

    func signInWithApple(_ credential: ASAuthorizationAppleIDCredential, rawNonce: String?) async -> Bool {
        profile.appleUserID = credential.user
        profile.appleEmail = credential.email

        let parts = [
            credential.fullName?.givenName,
            credential.fullName?.familyName
        ].compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        if !parts.isEmpty {
            profile.name = String(parts.joined(separator: " ").prefix(14))
        }

        serviceStatus = .loading
        do {
            authSession = try await services.auth.appleSession(credential: credential,
                                                               rawNonce: rawNonce,
                                                               fallback: profile)
            onlineMode = .remote
            startFriendPresence()
            serviceStatus = .ready
            showToast("Signed in with Apple")
            Task { await ensureFriendCode(silent: true) }
            return true
        } catch let error as ServiceError {
            logError("signInWithApple failed",
                     error: error,
                     metadata: ["function": "signInWithApple"])
            // Credential verification failures: Apple did not give us enough
            // to sign in at all. Surface the error instead of falling back.
            let appleCredentialFailures = [
                "Apple did not return a sign-in token.",
                "Apple sign-in could not verify securely. Try again."
            ]
            if let desc = error.errorDescription,
               appleCredentialFailures.contains(desc) {
                serviceStatus = .failed(error.userMessage)
                showToast(error.userMessage)
                return false
            }
            let fallback = UserProfile(id: credential.user,
                                       username: profile.name.lowercased().replacingOccurrences(of: " ", with: "_"),
                                       displayName: profile.name,
                                       avatarSeed: profile.colorName,
                                       totalXP: profile.xp,
                                       currentStreak: profile.dailyStreak,
                                       createdAt: nil,
                                       updatedAt: nil)
            authSession = .apple(fallback)
            onlineMode = .offlineFallback
            serviceStatus = .failed(error.userMessage)
            showToast("Signed in with Apple. Online play is taking a breather.")
            return true
        } catch {
            logError("signInWithApple failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "signInWithApple"])
            let fallback = UserProfile(id: credential.user,
                                       username: profile.name.lowercased().replacingOccurrences(of: " ", with: "_"),
                                       displayName: profile.name,
                                       avatarSeed: profile.colorName,
                                       totalXP: profile.xp,
                                       currentStreak: profile.dailyStreak,
                                       createdAt: nil,
                                       updatedAt: nil)
            authSession = .apple(fallback)
            onlineMode = .offlineFallback
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast("Signed in with Apple. Online play is taking a breather.")
            return true
        }
    }

    func signOutOfApple() {
        stopFriendPresence()
        services.auth.signOut()
        profile.appleUserID = nil
        profile.appleEmail = nil
        authSession = nil
        showToast("Signed out")
        Task { await establishGuestSession() }
    }

    func establishGuestSession(autoProvisionFriendCode: Bool = true) async {
        if let restored = await services.auth.restoreRemoteSession(localProfile: profile) {
            authSession = restored
            onlineMode = .remote
            startFriendPresence()
            if autoProvisionFriendCode {
                await ensureFriendCode(silent: true)
            }
        } else {
            authSession = await services.auth.guestSession(from: profile)
            onlineMode = services.config.onlineMode
            stopFriendPresence()
        }
    }

    func signInWithEmail(email: String, password: String) async -> Bool {
        serviceStatus = .loading
        do {
            authSession = try await services.auth.signIn(email: email, password: password, fallback: profile)
            onlineMode = .remote
            startFriendPresence()
            serviceStatus = .ready
            showToast("Signed in")
            return true
        } catch let error as ServiceError {
            logError("signInWithEmail failed",
                     error: error,
                     metadata: ["function": "signInWithEmail"])
            serviceStatus = .failed(error.userMessage)
            showToast(error.userMessage)
            return false
        } catch {
            logError("signInWithEmail failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "signInWithEmail"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast(ServiceError.offline.userMessage)
            return false
        }
    }

    func createAccount(email: String, password: String, username: String) async -> Bool {
        serviceStatus = .loading
        do {
            authSession = try await services.auth.signUp(email: email,
                                                         password: password,
                                                         username: username,
                                                         displayName: profile.name,
                                                         avatarSeed: profile.colorName)
            onlineMode = .remote
            startFriendPresence()
            serviceStatus = .ready
            showToast("Account created")
            return true
        } catch let error as ServiceError {
            logError("createAccount failed",
                     error: error,
                     metadata: ["function": "createAccount"])
            serviceStatus = .failed(error.userMessage)
            showToast(error.userMessage)
            return false
        } catch {
            logError("createAccount failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "createAccount"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast(ServiceError.offline.userMessage)
            return false
        }
    }

    func signOutRemoteAccount() {
        stopFriendPresence()
        services.auth.signOut()
        profile.appleUserID = nil
        profile.appleEmail = nil
        authSession = nil
        showToast("Signed out")
        Task { await establishGuestSession() }
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

    // MARK: - Starting matches

    func startQuickDuel() {
        let pool = profile.favoriteTopicIDs.compactMap { QuestionBank.topic($0) }
        let topic = pool.randomElement() ?? QuestionBank.topics.randomElement()!
        start(setup: MatchSetup(id: UUID(), mode: .quick, topic: topic,
                                opponent: MockData.randomBot(),
                                questions: drawQuestions(topicID: topic.id)))
    }

    func startTopicDuel(_ topic: Topic) {
        serviceStatus = .loading
        Task {
            let userID = authSession?.profile.id ?? "guest"
            let draft = await services.matches.prepareAsyncDuel(topic: topic, userID: userID)
            onlineMode = draft.mode
            serviceStatus = .ready
            if draft.mode != .remote {
                showToast("No online duel yet. Playing a bot.")
            } else if draft.match?.status == .waiting {
                showToast("Async duel created. Your result will wait for an opponent.")
            }
            start(setup: MatchSetup(id: UUID(),
                                    mode: .topic,
                                    topic: topic,
                                    opponent: draft.opponent ?? MockData.randomBot(),
                                    questions: draft.questions,
                                    onlineMatchID: draft.match?.id,
                                    onlineMode: draft.mode,
                                    onlineCreatedBy: draft.match?.createdBy))
        }
    }

    func startLiveDuel(_ topic: Topic) {
        serviceStatus = .loading
        Task {
            let userID = authSession?.profile.id ?? "guest"
            let draft = await services.matches.prepareLiveDuel(topic: topic, userID: userID)
            onlineMode = draft.mode
            serviceStatus = .ready
            if draft.mode == .live {
                if draft.match?.status == .waiting {
                    showToast("Live room created. Waiting for a challenger.")
                } else {
                    showToast("Live challenger found.")
                }
            } else {
                showToast("Live room unavailable. Playing a bot.")
            }
            start(setup: MatchSetup(id: UUID(),
                                    mode: .topic,
                                    topic: topic,
                                    opponent: draft.opponent ?? Bot(id: "live-rival",
                                                                    name: "Live rival",
                                                                    colorName: "softBlue",
                                                                    mascot: .competitive,
                                                                    accuracy: 0,
                                                                    minTime: 10,
                                                                    maxTime: 10,
                                                                    tagline: "Answering right now."),
                                    questions: draft.questions,
                                    onlineMatchID: draft.match?.id,
                                    onlineMode: draft.mode,
                                    onlineCreatedBy: draft.match?.createdBy))
        }
    }

    func startDailyChallenge() {
        serviceStatus = .loading
        Task {
            let userID = authSession?.profile.id
            let challenge = await services.dailyChallenge.today(userID: userID)
            serviceStatus = .ready
            start(setup: MatchSetup(id: UUID(),
                                    mode: .daily,
                                    topic: challenge.topicID.flatMap { QuestionBank.topic($0) },
                                    opponent: MockData.dailyBot,
                                    questions: challenge.questions,
                                    onlineMatchID: challenge.id,
                                    onlineMode: onlineMode))
        }
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
                          opponent: setup.opponent, questions: questions,
                          onlineMatchID: setup.onlineMatchID,
                          onlineMode: setup.onlineMode,
                          onlineCreatedBy: setup.onlineCreatedBy)
    }

    func connectLiveSession(_ session: LiveDuelSession, setup: MatchSetup) {
        guard setup.isLive, let matchID = setup.onlineMatchID else { return }
        let userID = authSession?.profile.id ?? "guest"
        session.connect(client: services.liveDuels.makeClient(matchID: matchID),
                        userID: userID,
                        displayName: profile.name,
                        colorName: profile.colorName)
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

        if let matchID = setup.onlineMatchID {
            let userID = authSession?.profile.id ?? "guest"
            Task {
                if let result = await services.matches.submitResult(matchID: matchID,
                                                                     userID: userID,
                                                                     answers: answers,
                                                                     topicID: setup.topicID),
                   result.isWaitingForOpponent {
                    waitingMatches.insert(result, at: 0)
                    showToast("Result saved. Waiting for opponent.")
                }
            }
        }

        if setup.mode == .daily {
            let userID = authSession?.profile.id ?? "guest"
            let result = DailyChallengeResult(id: UUID().uuidString,
                                              challengeID: setup.onlineMatchID ?? DateKeys.today,
                                              userID: userID,
                                              score: yourScore,
                                              correctCount: correctCount,
                                              xpGained: totalXP,
                                              completedAt: Date())
            Task { _ = await services.dailyChallenge.submit(result: result) }
        }

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
        let acceptedFriends = friends.filter { $0.status == .accepted && $0.otherProfile != nil }
        var entries = acceptedFriends.map { friendship in
            let p = friendship.otherProfile!
            let name = p.displayName.isEmpty ? p.username : p.displayName
            return LeaderboardEntry(id: p.id, name: name, colorName: p.avatarSeed,
                                    xp: 0, isPlayer: false)
        }
        entries.append(LeaderboardEntry(id: "player", name: profile.name,
                                        colorName: profile.colorName,
                                        xp: profile.xp, isPlayer: true))
        return entries.sorted { $0.xp > $1.xp }
    }

    func loadTopicLeaderboard(topicID: String, limit: Int = 20) async -> [LeaderboardEntry] {
        await services.leaderboards.topicLeaderboard(topicID: topicID, limit: limit)
    }

    func loadDailyLeaderboard(limit: Int = 20) async -> [LeaderboardEntry] {
        await services.leaderboards.dailyLeaderboard(dateKey: DateKeys.today, limit: limit)
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

    // MARK: - Friend codes & live rooms

    private func ensureRemoteSession(silent: Bool = false) async -> Bool {
        if case .remote = authSession { return true }
        await establishGuestSession(autoProvisionFriendCode: false)
        if case .remote = authSession { return true }
        if !silent {
            showToast("Sign in with Apple to use friend codes.")
        }
        return false
    }

    /// Finite-state decision shared by ChallengeFriendView and ProfileView.
    /// Both views use the same ordering: display → loading → error → fetchAction → signedOut.
    func friendCodeDisplayState(isSignedIn: Bool) -> FriendCodeDisplayState {
        if let code = friendCode { return .display(code) }
        if isLoadingFriendCode { return .loading }
        if let error = friendCodeError, isSignedIn { return .error(error) }
        if isSignedIn { return .fetchAction }
        return .signedOut
    }

    func ensureFriendCode(silent: Bool = false) async {
        guard await ensureRemoteSession(silent: silent) else { return }
        guard friendCode == nil, !isLoadingFriendCode else { return }
        isLoadingFriendCode = true
        friendCodeError = nil
        do {
            friendCode = try await services.friends.ensureFriendCode()
            serviceStatus = .ready
        } catch let error as ServiceError {
            logError("ensureFriendCode failed",
                     error: error,
                     metadata: ["silent": "\(silent)"])
            serviceStatus = .failed(error.userMessage)
            friendCodeError = error.userMessage
            if !silent { showToast(error.userMessage) }
        } catch {
            logError("ensureFriendCode failed (non-ServiceError)",
                     error: error,
                     metadata: ["silent": "\(silent)"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            friendCodeError = ServiceError.offline.userMessage
            if !silent { showToast(ServiceError.offline.userMessage) }
        }
        isLoadingFriendCode = false
    }

    func isSelfFriendSearchResult(_ result: PublicFriendProfile) -> Bool {
        guard case .remote(let user) = authSession else { return false }
        return result.id == user.id
    }

    func lookupFriendCode(_ code: String) async {
        guard await ensureRemoteSession() else { return }
        serviceStatus = .loading
        do {
            friendSearchResult = try await services.friends.lookupFriend(code: code)
            serviceStatus = .ready
        } catch let error as ServiceError {
            logError("lookupFriendCode failed",
                     error: error,
                     metadata: ["function": "lookupFriendCode"])
            serviceStatus = .failed(error.userMessage)
            showToast(error.userMessage)
        } catch {
            logError("lookupFriendCode failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "lookupFriendCode"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast(ServiceError.offline.userMessage)
        }
    }

    func sendFriendRequest(to code: String) async {
        guard await ensureRemoteSession() else { return }
        serviceStatus = .loading
        do {
            _ = try await services.friends.sendRequest(code: code)
            serviceStatus = .ready
            showToast("Friend request sent.")
        } catch let error as ServiceError {
            logError("sendFriendRequest failed",
                     error: error,
                     metadata: ["function": "sendFriendRequest"])
            serviceStatus = .failed(error.userMessage)
            showToast(error.userMessage)
        } catch {
            logError("sendFriendRequest failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "sendFriendRequest"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast(ServiceError.offline.userMessage)
        }
    }

    func loadFriends(silent: Bool = false) async {
        guard await ensureRemoteSession(silent: silent) else { return }
        serviceStatus = .loading
        do {
            async let accepted = services.friends.acceptedFriends()
            async let incoming = services.friends.incomingRequests()
            async let outgoing = services.friends.outgoingRequests()
            friends = try await accepted
            incomingFriendRequests = try await incoming
            outgoingFriendRequests = try await outgoing
            updateOnlineFriendIDs()
            serviceStatus = .ready
        } catch let error as ServiceError {
            logError("loadFriends failed",
                     error: error,
                     metadata: ["function": "loadFriends", "silent": "\(silent)"])
            serviceStatus = .failed(error.userMessage)
            if !silent { showToast(error.userMessage) }
        } catch {
            logError("loadFriends failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "loadFriends", "silent": "\(silent)"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            if !silent { showToast(ServiceError.offline.userMessage) }
        }
    }

    // MARK: - Friend presence

    private func startFriendPresence() {
        guard friendPresenceSession == nil,
              let userID = authSession?.profile.id,
              let client = services.friendPresence.makeClient() else { return }
        let session = FriendPresenceSession()
        session.onOnlineUserIDsChange = { [weak self] _ in
            self?.updateOnlineFriendIDs()
        }
        friendPresenceSession = session
        session.connect(client: client, userID: userID)
    }

    private func stopFriendPresence() {
        friendPresenceSession?.disconnect()
        friendPresenceSession = nil
        onlineFriendIDs = []
    }

    private func updateOnlineFriendIDs() {
        guard let session = friendPresenceSession,
              let currentUserID = authSession?.profile.id else {
            onlineFriendIDs = []
            return
        }
        let acceptedFriends = friends.filter { $0.status == .accepted }
        onlineFriendIDs = FriendPresenceParser.filterToFriends(
            session.onlineUserIDs,
            acceptedFriends: acceptedFriends,
            currentUserID: currentUserID
        )
    }

    func loadIncomingLiveChallenges() async {
        guard await ensureRemoteSession(silent: true) else { return }
        do {
            incomingLiveChallenges = try await services.liveInvites.fetchIncomingInvites()
        } catch {
            logError("loadIncomingLiveChallenges failed (silent)",
                     error: error,
                     metadata: ["function": "loadIncomingLiveChallenges", "silent": "true"])
        }
    }

    func acceptFriendRequest(_ friendshipID: String) async {
        guard await ensureRemoteSession() else { return }
        serviceStatus = .loading
        do {
            _ = try await services.friends.acceptRequest(friendshipID)
            serviceStatus = .ready
            showToast("Friend request accepted.")
            await loadFriends()
        } catch let error as ServiceError {
            logError("acceptFriendRequest failed",
                     error: error,
                     metadata: ["function": "acceptFriendRequest"])
            serviceStatus = .failed(error.userMessage)
            showToast(error.userMessage)
        } catch {
            logError("acceptFriendRequest failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "acceptFriendRequest"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast(ServiceError.offline.userMessage)
        }
    }

    func declineFriendRequest(_ friendshipID: String) async {
        guard await ensureRemoteSession() else { return }
        serviceStatus = .loading
        do {
            _ = try await services.friends.declineRequest(friendshipID)
            serviceStatus = .ready
            showToast("Friend request declined.")
            await loadFriends()
        } catch let error as ServiceError {
            logError("declineFriendRequest failed",
                     error: error,
                     metadata: ["function": "declineFriendRequest"])
            serviceStatus = .failed(error.userMessage)
            showToast(error.userMessage)
        } catch {
            logError("declineFriendRequest failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "declineFriendRequest"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast(ServiceError.offline.userMessage)
        }
    }

    func cancelFriendRequest(_ friendshipID: String) async {
        guard await ensureRemoteSession() else { return }
        serviceStatus = .loading
        do {
            _ = try await services.friends.cancelRequest(friendshipID)
            serviceStatus = .ready
            showToast("Friend request cancelled.")
            await loadFriends()
        } catch let error as ServiceError {
            logError("cancelFriendRequest failed",
                     error: error,
                     metadata: ["function": "cancelFriendRequest"])
            serviceStatus = .failed(error.userMessage)
            showToast(error.userMessage)
        } catch {
            logError("cancelFriendRequest failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "cancelFriendRequest"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast(ServiceError.offline.userMessage)
        }
    }

    func createLiveChallenge(friendship: Friendship, topic: Topic) async {
        guard await ensureRemoteSession() else { return }
        guard friendship.status == .accepted,
              let currentUserID = authSession?.profile.id else {
            showToast("Add this player as a friend first.")
            return
        }

        let guestID = friendship.otherUserID(for: currentUserID)
        serviceStatus = .loading
        do {
            let invite = try await services.liveInvites.createRoom(topicID: topic.id, guestID: guestID)
            liveRoomInvite = invite
            let questionIDs = try await services.liveInvites.questionIDs(for: invite.matchID)
            let questions = try await services.liveInvites.fetchQuestions(questionIDs: questionIDs)
            guard questions.count == 7 else { throw ServiceError.invalidResponse }
            serviceStatus = .ready
            let name = friendship.otherProfile?.displayName ?? "your friend"
            showToast("Challenge sent to \(name). Share the code: \(invite.joinCode)")
            pendingLiveRoom = PendingLiveRoom(invite: invite, questions: questions, topic: topic, invitedFriendName: name)
        } catch let error as ServiceError {
            logError("createLiveChallenge failed",
                     error: error,
                     metadata: ["function": "createLiveChallenge"])
            serviceStatus = .failed(error.userMessage)
            showToast(error.userMessage)
        } catch {
            logError("createLiveChallenge failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "createLiveChallenge"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast(ServiceError.offline.userMessage)
        }
    }

    private func startHostLiveRoom() {
        guard let pending = pendingLiveRoom else { return }
        pendingLiveRoom = nil
        let opponent = Bot(id: "live-host",
                           name: "Live challenger",
                           colorName: "softBlue",
                           mascot: .competitive,
                           accuracy: 0, minTime: 10, maxTime: 10,
                           tagline: "Waiting in the room.")
        start(setup: MatchSetup(id: UUID(),
                                mode: .friend,
                                topic: pending.topic,
                                opponent: opponent,
                                questions: pending.questions,
                                onlineMatchID: pending.invite.matchID,
                                onlineMode: .live))
    }

    func startHostLiveRoomIfReady() async -> Bool {
        guard let pending = pendingLiveRoom else { return false }
        guard await ensureRemoteSession(silent: false) else { return false }

        serviceStatus = .loading
        do {
            let readiness = try await services.liveInvites.checkReadiness(inviteID: pending.invite.inviteID)
            serviceStatus = .ready
            guard readiness.isReady else {
                showToast("Waiting for a challenger to join.")
                return false
            }
            pendingLiveRoom = nil
            let opponent = Bot(id: "live-host",
                               name: "Live challenger",
                               colorName: "softBlue",
                               mascot: .competitive,
                               accuracy: 0, minTime: 10, maxTime: 10,
                               tagline: "Joined the room.")
            start(setup: MatchSetup(id: UUID(),
                                    mode: .friend,
                                    topic: pending.topic,
                                    opponent: opponent,
                                    questions: pending.questions,
                                    onlineMatchID: pending.invite.matchID,
                                    onlineMode: .live))
            return true
        } catch let error as ServiceError {
            logError("startHostLiveRoomIfReady failed",
                     error: error,
                     metadata: ["function": "startHostLiveRoomIfReady"])
            serviceStatus = .failed(error.userMessage)
            showToast(error.userMessage)
            return false
        } catch {
            logError("startHostLiveRoomIfReady failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "startHostLiveRoomIfReady"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast(ServiceError.offline.userMessage)
            return false
        }
    }

    func checkLiveRoomReadiness() async -> LiveDuelInviteReadiness? {
        guard let pending = pendingLiveRoom,
              await ensureRemoteSession(silent: true) else { return nil }
        do {
            return try await services.liveInvites.checkReadiness(inviteID: pending.invite.inviteID)
        } catch {
            logError("checkLiveRoomReadiness failed",
                     error: error,
                     metadata: ["function": "checkLiveRoomReadiness", "silent": "true"])
            return nil
        }
    }

    func joinLiveRoom(code: String) async {
        guard await ensureRemoteSession() else { return }
        serviceStatus = .loading
        do {
            let joined = try await services.liveInvites.joinRoom(code: code)
            let questionIDs = try await services.liveInvites.questionIDs(for: joined.matchID)
            let questions = try await services.liveInvites.fetchQuestions(questionIDs: questionIDs)
            guard questions.count == 7 else { throw ServiceError.invalidResponse }
            let topic = try await services.liveInvites.resolveTopic(fromUUID: joined.topicID)
            serviceStatus = .ready
            showToast("Joined live room.")
            incomingLiveChallenges.removeAll { $0.matchID == joined.matchID }
            let opponent = Bot(id: "live-guest",
                               name: "Live opponent",
                               colorName: "softBlue",
                               mascot: .competitive,
                               accuracy: 0, minTime: 10, maxTime: 10,
                               tagline: "Facing off now.")
            start(setup: MatchSetup(id: UUID(),
                                    mode: .friend,
                                    topic: topic,
                                    opponent: opponent,
                                    questions: questions,
                                    onlineMatchID: joined.matchID,
                                    onlineMode: .live))
        } catch let error as ServiceError {
            logError("joinLiveRoom failed",
                     error: error,
                     metadata: ["function": "joinLiveRoom"])
            serviceStatus = .failed(error.userMessage)
            showToast(error.userMessage)
        } catch {
            logError("joinLiveRoom failed (non-ServiceError)",
                     error: error,
                     metadata: ["function": "joinLiveRoom"])
            serviceStatus = .failed(ServiceError.offline.userMessage)
            showToast(ServiceError.offline.userMessage)
        }
    }
}
