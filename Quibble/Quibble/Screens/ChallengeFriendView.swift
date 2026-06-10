import SwiftUI

struct ChallengeFriendView: View {
    @EnvironmentObject private var app: AppState
    @State private var selectedFriend: Friend?
    @State private var selectedTopic: Topic?

    private let topicColumns = [GridItem(.flexible(), spacing: 10),
                                GridItem(.flexible(), spacing: 10)]

    private var ready: Bool { selectedFriend != nil && selectedTopic != nil }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                ScreenHeader(title: "Challenge a Friend")
                    .padding(.top, 8)

                Text("All friends here are friendly mock blobs — no real messages are sent.")
                    .font(.quib(12, .bold))
                    .foregroundStyle(Color.mutedText)

                SectionHeader(title: "Pick a rival")
                VStack(spacing: 10) {
                    ForEach(MockData.friends) { friend in
                        Button {
                            Haptics.tap()
                            selectedFriend = friend
                        } label: {
                            HStack(spacing: 12) {
                                AvatarView(colorName: friend.colorName, size: 40,
                                           state: selectedFriend?.id == friend.id ? .competitive : .neutral)
                                VStack(alignment: .leading, spacing: 1) {
                                    Text(friend.name)
                                        .font(.quib(15, .heavy))
                                        .foregroundStyle(Color.ink)
                                    Text("Level \(friend.level) · \(friend.status)")
                                        .font(.quib(11, .bold))
                                        .foregroundStyle(Color.mutedText)
                                }
                                Spacer()
                                if selectedFriend?.id == friend.id {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 20, weight: .black))
                                        .foregroundStyle(Color.quibGreen)
                                }
                            }
                            .padding(12)
                            .neoCard(selectedFriend?.id == friend.id ? .quibPink : .paper,
                                     radius: 18, shadow: 3, lineWidth: 2.5)
                        }
                        .buttonStyle(NeoPressStyle())
                    }
                }

                SectionHeader(title: "Pick a topic")
                LazyVGrid(columns: topicColumns, spacing: 10) {
                    ForEach(QuestionBank.topics) { topic in
                        Button {
                            Haptics.tap()
                            selectedTopic = topic
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: topic.symbol)
                                    .font(.system(size: 13, weight: .black))
                                Text(topic.name)
                                    .font(.quib(13, .heavy))
                                    .lineLimit(1)
                                Spacer(minLength: 0)
                            }
                            .foregroundStyle(Color.ink)
                            .padding(.vertical, 11)
                            .padding(.horizontal, 12)
                            .neoCard(selectedTopic?.id == topic.id
                                     ? Palette.color(topic.colorName).opacity(0.55)
                                     : .paper,
                                     radius: 14, shadow: selectedTopic?.id == topic.id ? 1 : 3,
                                     lineWidth: 2.5)
                        }
                        .buttonStyle(NeoPressStyle())
                    }
                }

                VStack(spacing: 10) {
                    Button {
                        if let friend = selectedFriend, let topic = selectedTopic {
                            app.sendChallenge(to: friend, topic: topic)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text("Send challenge")
                        }
                    }
                    .buttonStyle(NeoButtonStyle(fill: .quibBlue, textColor: .paper, big: true, fullWidth: true))
                    .disabled(!ready)
                    .opacity(ready ? 1 : 0.5)

                    Button {
                        if let friend = selectedFriend, let topic = selectedTopic {
                            app.startFriendDuel(friend, topic: topic)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "bolt.fill")
                            Text("Battle them right now")
                        }
                    }
                    .buttonStyle(NeoButtonStyle(fill: .quibRed, textColor: .paper, fullWidth: true))
                    .disabled(!ready)
                    .opacity(ready ? 1 : 0.5)
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 110)
        }
        .background(Color.cream.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }
}
