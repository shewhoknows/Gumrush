import SwiftUI

struct ActivityView: View {
    @EnvironmentObject private var app: AppState
    var isTab: Bool = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                ScreenHeader(title: "Activity", showBack: !isTab)
                    .padding(.top, 8)

                // Incoming friend requests
                if !app.incomingFriendRequests.isEmpty {
                    SectionHeader(title: "Incoming friend requests")
                    VStack(spacing: 10) {
                        ForEach(app.incomingFriendRequests) { req in
                            IncomingRequestCard(request: req)
                        }
                    }
                }

                // Outgoing friend requests
                if !app.outgoingFriendRequests.isEmpty {
                    SectionHeader(title: "Outgoing friend requests")
                    VStack(spacing: 10) {
                        ForEach(app.outgoingFriendRequests) { req in
                            OutgoingRequestCard(request: req)
                        }
                    }
                }

                // Active live room
                if let pending = app.pendingLiveRoom {
                    SectionHeader(title: "Live room ready")
                    LiveRoomActivityCard(invite: pending.invite, topicName: pending.topic.name,
                                         invitedFriendName: pending.invitedFriendName)
                }

                if !app.incomingLiveChallenges.isEmpty {
                    SectionHeader(title: "Live challenges")
                    VStack(spacing: 10) {
                        ForEach(app.incomingLiveChallenges) { challenge in
                            IncomingLiveChallengeCard(challenge: challenge)
                        }
                    }
                }

                // Waiting matches
                if !app.waitingMatches.isEmpty {
                    SectionHeader(title: "Waiting for opponent")
                    VStack(spacing: 10) {
                        ForEach(app.waitingMatches) { result in
                            WaitingMatchCard(result: result)
                        }
                    }
                }

                // Match history
                SectionHeader(title: "Match history")
                if app.history.isEmpty {
                    EmptyStateView(mascot: .sleepy, color: .softBlue,
                                   title: "No battles yet",
                                   message: "Your duels will pile up here.\nGo start one — it only takes a minute.")
                } else {
                    VStack(spacing: 10) {
                        ForEach(app.history) { record in
                            NavigationLink {
                                ReviewAnswersView(answers: record.answers,
                                                  opponentName: record.opponentName)
                            } label: {
                                MatchRow(record: record)
                            }
                            .buttonStyle(NeoPressStyle())
                        }
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 110)
        }
        .background(Color.cream.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await app.loadFriends(silent: true)
            await app.loadIncomingLiveChallenges()
        }
    }
}

// MARK: - Waiting match card

private struct WaitingMatchCard: View {
    let result: MatchResult

    var body: some View {
        HStack(spacing: 12) {
            MascotView(state: .thinking, color: .quibPurple, size: 44)
            VStack(alignment: .leading, spacing: 2) {
                Text("Async duel saved")
                    .font(.quib(14, .heavy))
                    .foregroundStyle(Color.ink)
                Text("Your \(result.player.score) points are waiting for another player.")
                    .font(.quib(11, .bold))
                    .foregroundStyle(Color.mutedText)
            }
            Spacer()
            ChipView(text: "Waiting", icon: "hourglass", fill: Palette.pastel("purple"))
        }
        .padding(13)
        .neoCard(.paper, radius: 18, shadow: 3)
    }
}

// MARK: - Incoming friend request card

private struct IncomingRequestCard: View {
    @EnvironmentObject private var app: AppState
    let request: Friendship

    var body: some View {
        HStack(spacing: 12) {
            AvatarView(colorName: request.otherProfile?.avatarSeed ?? "yellow",
                       size: 40, state: .surprised)
            VStack(alignment: .leading, spacing: 2) {
                Text(request.otherProfile?.displayName ?? "Player")
                    .font(.quib(14, .heavy))
                    .foregroundStyle(Color.ink)
                Text("Wants to be friends")
                    .font(.quib(11, .bold))
                    .foregroundStyle(Color.mutedText)
            }
            Spacer()
            Button {
                Haptics.tap()
                Task { await app.acceptFriendRequest(request.id) }
            } label: {
                Text("Accept")
            }
            .buttonStyle(NeoButtonStyle(fill: .quibGreen, textColor: .paper))
            Button {
                Haptics.tap()
                Task { await app.declineFriendRequest(request.id) }
            } label: {
                Text("Decline")
            }
            .buttonStyle(NeoButtonStyle(fill: .paper))
        }
        .padding(13)
        .neoCard(Palette.pastel("yellow"), radius: 18, shadow: 3)
    }
}

// MARK: - Outgoing friend request card

private struct OutgoingRequestCard: View {
    @EnvironmentObject private var app: AppState
    let request: Friendship

    var body: some View {
        HStack(spacing: 12) {
            AvatarView(colorName: request.otherProfile?.avatarSeed ?? "yellow",
                       size: 40, state: .thinking)
            VStack(alignment: .leading, spacing: 2) {
                Text(request.otherProfile?.displayName ?? "Player")
                    .font(.quib(14, .heavy))
                    .foregroundStyle(Color.ink)
                Text("Request sent — waiting")
                    .font(.quib(11, .bold))
                    .foregroundStyle(Color.mutedText)
            }
            Spacer()
            Button {
                Haptics.tap()
                Task { await app.cancelFriendRequest(request.id) }
            } label: {
                Text("Cancel")
            }
            .buttonStyle(NeoButtonStyle(fill: .paper))
        }
        .padding(13)
        .neoCard(Palette.pastel("blue"), radius: 18, shadow: 3)
    }
}

// MARK: - Live room activity card

private struct LiveRoomActivityCard: View {
    @EnvironmentObject private var app: AppState
    let invite: LiveDuelInvite
    let topicName: String
    let invitedFriendName: String?

    @State private var readiness: LiveDuelInviteReadiness?

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                MascotView(state: readiness?.isReady == true ? .excited : .thinking,
                           color: .quibRed, size: 44)
                VStack(alignment: .leading, spacing: 2) {
                    if let friend = invitedFriendName {
                        HStack(spacing: 4) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 10, weight: .black))
                            Text(friend)
                                .font(.quib(13, .heavy))
                                .foregroundStyle(Color.ink)
                        }
                    }
                    Text(topicName)
                        .font(.quib(14, .heavy))
                        .foregroundStyle(Color.ink)
                    Text("Code: \(invite.joinCode)")
                        .font(.quib(12, .bold))
                        .foregroundStyle(Color.mutedText)
                        .tracking(3)
                        .monospaced()
                }
                Spacer()
                if readiness?.isReady == true {
                    ChipView(text: "Ready", icon: "checkmark.seal.fill", fill: Palette.pastel("green"))
                } else {
                    ChipView(text: "Waiting", icon: "hourglass", fill: Palette.pastel("red"))
                }
            }
            Button {
                Haptics.heavy()
                Task {
                    let started = await app.startHostLiveRoomIfReady()
                    if !started {
                        readiness = await app.checkLiveRoomReadiness()
                    }
                }
            } label: {
                HStack {
                    Image(systemName: readiness?.isReady == true ? "play.fill" : "hourglass")
                    Text(readiness?.isReady == true ? "Start as host" : "Check readiness")
                }
            }
            .buttonStyle(NeoButtonStyle(fill: readiness?.isReady == true ? .quibGreen : .quibBlue,
                                        textColor: .paper, fullWidth: true))
        }
        .padding(13)
        .neoCard(Palette.pastel("red"), radius: 20, shadow: 3)
        .task(id: invite.inviteID) {
            while !Task.isCancelled {
                readiness = await app.checkLiveRoomReadiness()
                if readiness?.isReady == true { return }
                try? await Task.sleep(nanoseconds: 3_000_000_000)
            }
        }
    }
}

// MARK: - Incoming live challenge card

private struct IncomingLiveChallengeCard: View {
    @EnvironmentObject private var app: AppState
    let challenge: IncomingLiveChallenge

    var body: some View {
        HStack(spacing: 12) {
            MascotView(state: .excited, color: .quibRed, size: 44)
            VStack(alignment: .leading, spacing: 2) {
                Text(challenge.hostName ?? "A friend")
                    .font(.quib(14, .heavy))
                    .foregroundStyle(Color.ink)
                HStack(spacing: 6) {
                    if let topic = challenge.topicName {
                        Text(topic)
                            .font(.quib(12, .bold))
                            .foregroundStyle(Color.mutedText)
                    }
                    Text("Code: \(challenge.joinCode)")
                        .font(.quib(12, .bold))
                        .foregroundStyle(Color.mutedText)
                        .tracking(2)
                        .monospaced()
                }
            }
            Spacer()
            if challenge.hasExpired {
                ChipView(text: "Expired", icon: "clock.badge.exclamationmark", fill: Palette.pastel("red"))
            } else {
                Button {
                    Haptics.heavy()
                    Task { await app.joinLiveRoom(code: challenge.joinCode) }
                } label: {
                    Text("Accept")
                }
                .buttonStyle(NeoButtonStyle(fill: .quibGreen, textColor: .paper))
            }
        }
        .padding(13)
        .neoCard(Palette.pastel("red"), radius: 20, shadow: 3)
    }
}
