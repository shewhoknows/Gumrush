import SwiftUI

struct ActivityView: View {
    @EnvironmentObject private var app: AppState
    var isTab: Bool = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                ScreenHeader(title: "Activity", showBack: !isTab)
                    .padding(.top, 8)

                // Pending friend challenges (mock)
                if !app.pendingChallenges.isEmpty {
                    SectionHeader(title: "Pending challenges")
                    VStack(spacing: 10) {
                        ForEach(app.pendingChallenges) { challenge in
                            PendingChallengeCard(challenge: challenge)
                        }
                    }
                }

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
    }
}

private struct PendingChallengeCard: View {
    @EnvironmentObject private var app: AppState
    let challenge: PendingChallenge

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                AvatarView(colorName: challenge.friendColorName, size: 40, state: .thinking)
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(challenge.friendName) · \(challenge.topicName)")
                        .font(.quib(14, .heavy))
                        .foregroundStyle(Color.ink)
                    Text("Waiting for them to play… (demo)")
                        .font(.quib(11, .bold))
                        .foregroundStyle(Color.mutedText)
                }
                Spacer()
            }
            HStack(spacing: 10) {
                Button {
                    app.removeChallenge(challenge)
                    if let friend = MockData.friends.first(where: { $0.name == challenge.friendName }),
                       let topic = QuestionBank.topic(challenge.topicID) {
                        app.startFriendDuel(friend, topic: topic)
                    }
                } label: {
                    Text("Play it now")
                        .font(.quib(13, .heavy))
                }
                .buttonStyle(NeoButtonStyle(fill: .quibGreen, textColor: .paper))

                Button {
                    Haptics.tap()
                    app.removeChallenge(challenge)
                } label: {
                    Text("Dismiss")
                        .font(.quib(13, .heavy))
                }
                .buttonStyle(NeoButtonStyle(fill: .paper))
                Spacer()
            }
        }
        .padding(13)
        .neoCard(.quibYellow.opacity(0.6), radius: 20, shadow: 3)
    }
}
