import XCTest
@testable import Quibble

final class ScoringServiceTests: XCTestCase {
    func testCorrectAnswerScoreIncludesSpeedBonus() {
        let points = ScoringService.points(isCorrect: true, timeRemaining: 10, streak: 1)

        XCTAssertEqual(points.base, 100)
        XCTAssertEqual(points.speed, 50)
        XCTAssertEqual(points.streak, 0)
        XCTAssertEqual(points.total, 150)
    }

    func testStreakBonusStartsAtThree() {
        let points = ScoringService.points(isCorrect: true, timeRemaining: 5, streak: 3)

        XCTAssertEqual(points.base, 100)
        XCTAssertEqual(points.speed, 25)
        XCTAssertEqual(points.streak, 25)
        XCTAssertEqual(points.total, 150)
    }

    func testWrongAnswerAndTimeoutScoreZero() {
        XCTAssertEqual(ScoringService.points(isCorrect: false, timeRemaining: 10, streak: 5).total, 0)
        XCTAssertEqual(ScoringService.points(isCorrect: false, timeRemaining: 0, streak: 0).total, 0)
    }

    func testXPCalculation() {
        XCTAssertEqual(ScoringService.xp(outcome: .win, isDaily: false, isPerfect: false), 120)
        XCTAssertEqual(ScoringService.xp(outcome: .loss, isDaily: false, isPerfect: false), 60)
        XCTAssertEqual(ScoringService.xp(outcome: .draw, isDaily: false, isPerfect: false), 90)
        XCTAssertEqual(ScoringService.xp(outcome: .win, isDaily: true, isPerfect: true), 220)
    }

    func testMissingSupabaseConfigFallsBackCleanly() {
        XCTAssertNil(SupabaseConfig.load(environment: [:]))
    }

    func testLiveMatchEngineAppliesRemoteAnswerOnce() {
        let topic = QuestionBank.topics[0]
        let questions = Array(QuestionBank.questions(for: topic.id).prefix(7))
        let setup = MatchSetup(id: UUID(),
                               mode: .topic,
                               topic: topic,
                               opponent: Bot(id: "live",
                                             name: "Live rival",
                                             colorName: "softBlue",
                                             mascot: .competitive,
                                             accuracy: 0,
                                             minTime: 10,
                                             maxTime: 10,
                                             tagline: "Testing live."),
                               questions: questions,
                               onlineMatchID: "match-1",
                               onlineMode: .live,
                               onlineCreatedBy: "user-1")
        let engine = MatchEngine(setup: setup)

        engine.applyRemoteAnswer(questionID: questions[0].id, points: 125, score: 125)
        engine.applyRemoteAnswer(questionID: questions[0].id, points: 125, score: 250)

        XCTAssertEqual(engine.botScore, 125)
    }

    // MARK: - Friend code normalization

    func testNormalizedCodeUppercasesAndTrims() {
        XCTAssertEqual("abc123".normalizedCode, "ABC23")
        XCTAssertEqual("  xyz  ".normalizedCode, "XYZ")
        XCTAssertEqual("a-b-c".normalizedCode, "ABC")
    }

    func testNormalizedCodeStripsInvalidCharacters() {
        XCTAssertEqual("O0I1".normalizedCode, "")
        XCTAssertEqual("AB0CD1EF".normalizedCode, "ABCDEF")
        XCTAssertEqual("test-code-789".normalizedCode, "TESTCDE789")
    }

    func testNormalizedCodeHandlesLowercase() {
        XCTAssertEqual("abcdef".normalizedCode, "ABCDEF")
        XCTAssertEqual("ghjk".normalizedCode, "GHJK")
    }

    // MARK: - Local repo blocking errors

    func testLocalFriendRepositoryThrowsBlockingError() async {
        let repo = LocalFriendRepository()
        do {
            _ = try await repo.ensureFriendCode()
            XCTFail("Expected error, got success")
        } catch let error as ServiceError {
            XCTAssertTrue(error.userMessage.contains("Sign in"))
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    func testLocalLiveDuelInviteRepositoryThrowsBlockingError() async {
        let repo = LocalLiveDuelInviteRepository()
        do {
            _ = try await repo.createInvite(topicID: "cricket", guestID: "guest-1")
            XCTFail("Expected error, got success")
        } catch let error as ServiceError {
            XCTAssertTrue(error.userMessage.contains("Sign in"))
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    // MARK: - Friendship model

    func testFriendshipOtherUserID() {
        let friendship = Friendship(id: "f1",
                                    requesterID: "user-a",
                                    addresseeID: "user-b",
                                    status: .pending,
                                    createdAt: nil,
                                    respondedAt: nil,
                                    otherProfile: nil)
        XCTAssertEqual(friendship.otherUserID(for: "user-a"), "user-b")
        XCTAssertEqual(friendship.otherUserID(for: "user-b"), "user-a")
    }

    func testPublicFriendProfileDecoding() throws {
        let json = """
        {"id":"abc","username":"player1","display_name":"Player One","avatar_seed":"yellow"}
        """
        let dto = try JSONDecoder().decode(SupabasePublicProfileDTO.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(dto.profile.id, "abc")
        XCTAssertEqual(dto.profile.username, "player1")
        XCTAssertEqual(dto.profile.displayName, "Player One")
    }

    func testLiveDuelInviteDTODecoding() throws {
        let json = """
        {"invite_id":"inv-1","match_id":"m-1","join_code":"ABCD","topic_id":"t-1","expires_at":"2026-07-01T12:00:00Z"}
        """
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let dto = try decoder.decode(SupabaseLiveDuelInviteDTO.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(dto.invite.inviteID, "inv-1")
        XCTAssertEqual(dto.invite.joinCode, "ABCD")
    }

    // MARK: - SupabasePublicProfileDTO nullability

    func testPublicProfileDTODefaultsNullFields() throws {
        let json = """
        {"id":"abc","username":"player1"}
        """
        let dto = try JSONDecoder().decode(SupabasePublicProfileDTO.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(dto.profile.id, "abc")
        XCTAssertEqual(dto.profile.username, "player1")
        XCTAssertEqual(dto.profile.displayName, "player1")
        XCTAssertEqual(dto.profile.avatarSeed, "yellow")
    }

    func testPublicProfileDTODefaultsAllNulls() throws {
        let json = """
        {"id":"xyz"}
        """
        let dto = try JSONDecoder().decode(SupabasePublicProfileDTO.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(dto.profile.id, "xyz")
        XCTAssertEqual(dto.profile.username, "player")
        XCTAssertEqual(dto.profile.displayName, "Player")
        XCTAssertEqual(dto.profile.avatarSeed, "yellow")
    }

    // MARK: - Question ordering

    func testQuestionFetchPreservesInputOrder() {
        let all = QuestionBank.all
        let shuffled = all.shuffled()
        let ids = shuffled.map(\.id)
        let byID = Dictionary(uniqueKeysWithValues: all.map { ($0.id, $0) })
        let ordered = ids.compactMap { byID[$0] }

        XCTAssertEqual(ordered.count, ids.count)
        for (index, question) in ordered.enumerated() {
            XCTAssertEqual(question.id, ids[index],
                           "Question at index \(index) should match input order")
        }
    }

    func testQuestionFetchDropsNotFoundIDs() {
        let all = QuestionBank.all
        let ids = ["nonexistent-1", all[0].id, "nonexistent-2", all[1].id]
        let byID = Dictionary(uniqueKeysWithValues: all.map { ($0.id, $0) })
        let ordered = ids.compactMap { byID[$0] }

        XCTAssertEqual(ordered.count, 2)
        XCTAssertEqual(ordered[0].id, all[0].id)
        XCTAssertEqual(ordered[1].id, all[1].id)
    }

    // MARK: - Refresh token persistence

    func testAuthSessionStoreSavesAndLoadsRefreshToken() {
        let store = AuthSessionStore()
        store.save(accessToken: "tok", refreshToken: "ref", userID: "user")
        let loaded = store.load()
        XCTAssertEqual(loaded?.accessToken, "tok")
        XCTAssertEqual(loaded?.refreshToken, "ref")
        XCTAssertEqual(loaded?.userID, "user")
    }

    func testAuthSessionStoreLoadsWithoutRefreshToken() {
        let store = AuthSessionStore()
        store.save(accessToken: "tok", refreshToken: nil, userID: "user")
        let loaded = store.load()
        XCTAssertEqual(loaded?.accessToken, "tok")
        XCTAssertNil(loaded?.refreshToken)
        XCTAssertEqual(loaded?.userID, "user")
    }

    func testAuthSessionStoreClearRemovesRefreshToken() {
        let store = AuthSessionStore()
        store.save(accessToken: "tok", refreshToken: "ref", userID: "user")
        store.clear()
        XCTAssertNil(store.load())
    }

    // MARK: - Live room readiness DTO

    func testLiveDuelInviteReadinessDTOAccepted() throws {
        let json = """
        {"id":"inv-1","match_id":"m-1","guest_id":"guest-1","status":"accepted"}
        """
        let dto = try JSONDecoder().decode(SupabaseLiveDuelInviteReadinessDTO.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(dto.readiness.inviteID, "inv-1")
        XCTAssertEqual(dto.readiness.matchID, "m-1")
        XCTAssertEqual(dto.readiness.guestID, "guest-1")
        XCTAssertTrue(dto.readiness.isReady)
    }

    func testLiveDuelInviteReadinessDTOPending() throws {
        let json = """
        {"id":"inv-2","match_id":"m-2","guest_id":null,"status":"pending"}
        """
        let dto = try JSONDecoder().decode(SupabaseLiveDuelInviteReadinessDTO.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(dto.readiness.inviteID, "inv-2")
        XCTAssertFalse(dto.readiness.isReady)
        XCTAssertNil(dto.readiness.guestID)
    }

    func testLiveDuelInviteReadinessDTOAcceptedWithoutGuest() throws {
        let json = """
        {"id":"inv-3","match_id":"m-3","guest_id":null,"status":"accepted"}
        """
        let dto = try JSONDecoder().decode(SupabaseLiveDuelInviteReadinessDTO.self, from: json.data(using: .utf8)!)
        XCTAssertFalse(dto.readiness.isReady)
    }

    // MARK: - SupabaseRESTClient timeout

    func testSupabaseRESTClientDefaultSessionConfigurationHasTimeout() {
        let config = SupabaseRESTClient.makeDefaultSessionConfiguration()
        XCTAssertEqual(config.timeoutIntervalForRequest, 20)
        XCTAssertEqual(config.timeoutIntervalForResource, 30)
    }

    // MARK: - SupabaseConfig.load edge cases

    func testSupabaseConfigLoadWithValidEnvironmentSucceeds() {
        let env = [
            "SUPABASE_URL": "https://test.supabase.co",
            "SUPABASE_ANON_KEY": "test-key"
        ]
        let config = SupabaseConfig.load(environment: env)
        XCTAssertNotNil(config)
        XCTAssertEqual(config?.url.absoluteString, "https://test.supabase.co")
        XCTAssertEqual(config?.anonKey, "test-key")
    }

    func testSupabaseConfigLoadWithEmptyKeyFails() {
        let env = [
            "SUPABASE_URL": "https://test.supabase.co",
            "SUPABASE_ANON_KEY": ""
        ]
        XCTAssertNil(SupabaseConfig.load(environment: env))
    }

    func testSupabaseConfigLoadWithMissingKeyFails() {
        let env = [
            "SUPABASE_URL": "https://test.supabase.co"
        ]
        XCTAssertNil(SupabaseConfig.load(environment: env))
    }

    func testSupabaseConfigLoadWithMissingURLFails() {
        let env = [
            "SUPABASE_ANON_KEY": "test-key"
        ]
        XCTAssertNil(SupabaseConfig.load(environment: env))
    }

    // MARK: - Friend code normalize edge cases

    func testNormalizedCodeHandlesWhitespaceOnly() {
        XCTAssertEqual("   ".normalizedCode, "")
        XCTAssertEqual("".normalizedCode, "")
    }

    func testNormalizedCodeHandlesMixedAmbiguousCharacters() {
        XCTAssertEqual("AB01CD".normalizedCode, "ABCD")
        XCTAssertEqual("O0-I1-L2".normalizedCode, "L2")
    }

    // MARK: - JWT safe diagnostics

    func testSafeJWTClaimsExtractsStandardFields() {
        let header = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
        let payload = "eyJpc3MiOiJodHRwczovL2FwcGxlaWQuYXBwbGUuY29tIiwiYXVkIjoiY29tLmVzaGFiaG9vbi5xdWliYmxlIiwic3ViIjoiMDAxMjM0LmFiY2RlZiIsImV4cCI6MjAwMDAwMDAwMH0"
        let token = "\(header).\(payload).fakesig"

        let claims = AuthService.safeJWTClaims(from: token)

        XCTAssertEqual(claims["iss"], "https://appleid.apple.com")
        XCTAssertEqual(claims["aud"], "com.eshabhoon.quibble")
        XCTAssertEqual(claims["sub_hash"], "238e9a9c70e8")
        XCTAssertEqual(claims["expected"], "com.eshabhoon.quibble")
        XCTAssertNotNil(claims["exp"])
    }

    func testSafeJWTClaimsHandlesMalformedInput() {
        XCTAssertTrue(AuthService.safeJWTClaims(from: "").isEmpty)
        XCTAssertTrue(AuthService.safeJWTClaims(from: "not.a.jwt").isEmpty)
        XCTAssertTrue(AuthService.safeJWTClaims(from: ".").isEmpty)
    }

    func testSafeJWTClaimsHandlesMismatchedAudience() {
        let payload = "eyJhdWQiOiJ3cm9uZy5idW5kbGUuaWQiLCJpc3MiOiJodHRwczovL2FwcGxlaWQuYXBwbGUuY29tIn0"
        let token = "e30.\(payload).fakesig"

        let claims = AuthService.safeJWTClaims(from: token)

        XCTAssertEqual(claims["aud"], "wrong.bundle.id")
        XCTAssertEqual(claims["expected"], "com.eshabhoon.quibble")
        XCTAssertNotEqual(claims["aud"], claims["expected"])
    }

    func testExpectedBundleIDMatchesCanonical() {
        XCTAssertEqual(AuthService.expectedBundleID, "com.eshabhoon.quibble")
    }

    // MARK: - Friend code finite state (regression: infinite spinner)

    @MainActor
    func testFriendCodeDisplayStateSignedOutWhenNotSignedIn() {
        let app = AppState()

        XCTAssertEqual(app.friendCodeDisplayState(isSignedIn: false), .signedOut)
    }

    @MainActor
    func testFriendCodeDisplayStateFetchActionWhenSignedInNoCode() {
        let app = AppState()

        XCTAssertEqual(app.friendCodeDisplayState(isSignedIn: true), .fetchAction)
    }

    @MainActor
    func testFriendCodeDisplayStateLoadingTakesPriority() {
        let app = AppState()
        app.isLoadingFriendCode = true
        app.friendCodeError = "Some error"

        XCTAssertEqual(app.friendCodeDisplayState(isSignedIn: true), .loading)
    }

    @MainActor
    func testFriendCodeDisplayStateErrorWhenSignedIn() {
        let app = AppState()
        app.friendCodeError = "Network unavailable"

        XCTAssertEqual(app.friendCodeDisplayState(isSignedIn: true), .error("Network unavailable"))
    }

    @MainActor
    func testFriendCodeDisplayStateErrorHiddenWhenSignedOut() {
        let app = AppState()
        app.friendCodeError = "Network unavailable"

        XCTAssertEqual(app.friendCodeDisplayState(isSignedIn: false), .signedOut)
    }

    @MainActor
    func testFriendCodeDisplayStateDisplayWinsOverAll() {
        let app = AppState()
        app.friendCode = "ABCDEF"
        app.isLoadingFriendCode = true
        app.friendCodeError = "Some error"

        XCTAssertEqual(app.friendCodeDisplayState(isSignedIn: true), .display("ABCDEF"))
    }

    @MainActor
    func testFriendCodeDisplayStateFetchActionAfterSilentFailure() {
        let app = AppState()
        app.friendCodeError = "Offline"
        XCTAssertEqual(app.friendCodeDisplayState(isSignedIn: true), .error("Offline"))

        app.friendCodeError = nil
        XCTAssertEqual(app.friendCodeDisplayState(isSignedIn: true), .fetchAction)
    }

    // MARK: - Self friend request guard

    @MainActor
    func testIsSelfFriendSearchResultTrueWhenRemoteIDsMatch() {
        let app = AppState()
        let user = UserProfile(id: "user-abc", username: "me", displayName: "Me",
                               avatarSeed: "yellow", totalXP: 100, currentStreak: 0)
        app.authSession = .remote(user)

        let result = PublicFriendProfile(id: "user-abc", username: "me",
                                         displayName: "Me", avatarSeed: "yellow")
        XCTAssertTrue(app.isSelfFriendSearchResult(result))
    }

    @MainActor
    func testIsSelfFriendSearchResultFalseWhenRemoteIDsDiffer() {
        let app = AppState()
        let user = UserProfile(id: "user-abc", username: "me", displayName: "Me",
                               avatarSeed: "yellow", totalXP: 100, currentStreak: 0)
        app.authSession = .remote(user)

        let result = PublicFriendProfile(id: "user-xyz", username: "other",
                                         displayName: "Other", avatarSeed: "blue")
        XCTAssertFalse(app.isSelfFriendSearchResult(result))
    }

    @MainActor
    func testIsSelfFriendSearchResultFalseForGuestSession() {
        let app = AppState()
        let user = UserProfile(id: "guest", username: "guest", displayName: "Guest",
                               avatarSeed: "yellow", totalXP: 0, currentStreak: 0)
        app.authSession = .guest(user)

        let result = PublicFriendProfile(id: "guest", username: "guest",
                                         displayName: "Guest", avatarSeed: "yellow")
        XCTAssertFalse(app.isSelfFriendSearchResult(result))
    }

    @MainActor
    func testIsSelfFriendSearchResultFalseForNilSession() {
        let app = AppState()
        app.authSession = nil

        let result = PublicFriendProfile(id: "user-abc", username: "me",
                                         displayName: "Me", avatarSeed: "yellow")
        XCTAssertFalse(app.isSelfFriendSearchResult(result))
    }

    // MARK: - Incoming live challenge DTO

    func testIncomingLiveInviteDTODecoding() throws {
        let json = """
        {"id":"inv-1","match_id":"m-1","join_code":"ABCD","topic_id":"t-1","host_id":"h-1","expires_at":"2026-07-01T12:00:00Z"}
        """
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let dto = try decoder.decode(SupabaseIncomingLiveInviteDTO.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(dto.id, "inv-1")
        XCTAssertEqual(dto.matchID, "m-1")
        XCTAssertEqual(dto.joinCode, "ABCD")
        XCTAssertEqual(dto.topicID, "t-1")
        XCTAssertEqual(dto.hostID, "h-1")
    }

    // MARK: - Local repo blocking for incoming invites

    func testLocalLiveDuelInviteRepositoryFetchIncomingInvitesThrowsBlockingError() async {
        let repo = LocalLiveDuelInviteRepository()
        do {
            _ = try await repo.fetchIncomingInvites()
            XCTFail("Expected error, got success")
        } catch let error as ServiceError {
            XCTAssertTrue(error.userMessage.contains("Sign in"))
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    // MARK: - IncomingLiveChallenge model

    func testIncomingLiveChallengeHasExpiredWhenPastExpiry() {
        let challenge = IncomingLiveChallenge(inviteID: "i1", matchID: "m1",
                                              joinCode: "ABC", topicID: "t1",
                                              hostID: "h1",
                                              expiresAt: Date().addingTimeInterval(-60))
        XCTAssertTrue(challenge.hasExpired)
    }

    func testIncomingLiveChallengeNotExpiredWhenFutureExpiry() {
        let challenge = IncomingLiveChallenge(inviteID: "i1", matchID: "m1",
                                              joinCode: "ABC", topicID: "t1",
                                              hostID: "h1",
                                              expiresAt: Date().addingTimeInterval(300))
        XCTAssertFalse(challenge.hasExpired)
    }

    func testIncomingLiveChallengeIDIsInviteID() {
        let challenge = IncomingLiveChallenge(inviteID: "inv-42", matchID: "m1",
                                              joinCode: "ABC", topicID: "t1",
                                              hostID: "h1",
                                              expiresAt: Date())
        XCTAssertEqual(challenge.id, "inv-42")
    }

    // MARK: - Presence parser

    func testParsePresenceStateExtractsUserIDs() {
        let payload: [String: Any] = [
            "user-alice": ["online_at": 1234567890],
            "user-bob": NSNull(),
            "user-charlie": ["online_at": 1234567891]
        ]
        let ids = FriendPresenceParser.userIDs(from: payload)
        XCTAssertEqual(ids, ["user-alice", "user-bob", "user-charlie"])
    }

    func testParsePresenceStateEmptyPayload() {
        let ids = FriendPresenceParser.userIDs(from: [:])
        XCTAssertTrue(ids.isEmpty)
    }

    func testParsePresenceDiffJoinsAddsUsers() {
        let diff: [String: Any] = [
            "joins": ["user-dave": ["online_at": 1000]]
        ]
        var current: Set<String> = ["user-alice"]
        current = FriendPresenceParser.apply(diff: diff, to: current)
        XCTAssertEqual(current, ["user-alice", "user-dave"])
    }

    func testParsePresenceDiffLeavesRemovesUsers() {
        let diff: [String: Any] = [
            "leaves": ["user-alice": NSNull()]
        ]
        var current: Set<String> = ["user-alice", "user-bob"]
        current = FriendPresenceParser.apply(diff: diff, to: current)
        XCTAssertEqual(current, ["user-bob"])
    }

    func testParsePresenceDiffCombinedJoinsAndLeaves() {
        let diff: [String: Any] = [
            "joins": ["user-dave": NSNull()],
            "leaves": ["user-alice": NSNull()]
        ]
        var current: Set<String> = ["user-alice", "user-bob"]
        current = FriendPresenceParser.apply(diff: diff, to: current)
        XCTAssertEqual(current, ["user-bob", "user-dave"])
    }

    func testParsePresenceDiffEmptyPayloadPreservesCurrent() {
        let current: Set<String> = ["user-alice", "user-bob"]
        let updated = FriendPresenceParser.apply(diff: [:], to: current)
        XCTAssertEqual(updated, current)
    }

    func testFilterToFriendsKeepsOnlyAcceptedFriendIDs() {
        let onlineIDs: Set<String> = ["user-a", "user-b", "user-c"]
        let friends: [Friendship] = [
            Friendship(id: "f1", requesterID: "me", addresseeID: "user-a",
                       status: .accepted, createdAt: nil, respondedAt: nil, otherProfile: nil),
            Friendship(id: "f2", requesterID: "user-b", addresseeID: "me",
                       status: .pending, createdAt: nil, respondedAt: nil, otherProfile: nil),
            Friendship(id: "f3", requesterID: "me", addresseeID: "user-c",
                       status: .declined, createdAt: nil, respondedAt: nil, otherProfile: nil)
        ]
        let accepted = friends.filter { $0.status == .accepted }
        let filtered = FriendPresenceParser.filterToFriends(onlineIDs, acceptedFriends: accepted, currentUserID: "me")
        XCTAssertEqual(filtered, ["user-a"])
    }

    func testFilterToFriendsHandlesNonAcceptedStatuses() {
        let onlineIDs: Set<String> = ["user-x"]
        let friends: [Friendship] = [
            Friendship(id: "f1", requesterID: "me", addresseeID: "user-x",
                       status: .cancelled, createdAt: nil, respondedAt: nil, otherProfile: nil)
        ]
        let accepted = friends.filter { $0.status == .accepted }
        let filtered = FriendPresenceParser.filterToFriends(onlineIDs, acceptedFriends: accepted, currentUserID: "me")
        XCTAssertTrue(filtered.isEmpty)
    }

    func testFilterToFriendsSkipsSelfAsFriend() {
        let onlineIDs: Set<String> = ["me"]
        let friends: [Friendship] = [
            Friendship(id: "f1", requesterID: "me", addresseeID: "you",
                       status: .accepted, createdAt: nil, respondedAt: nil, otherProfile: nil)
        ]
        let filtered = FriendPresenceParser.filterToFriends(onlineIDs, acceptedFriends: friends, currentUserID: "me")
        XCTAssertTrue(filtered.isEmpty)
    }
}
