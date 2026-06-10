import SwiftUI

struct ChooseTopicsView: View {
    @EnvironmentObject private var app: AppState
    @State private var selected: Set<String> = []

    private let minimum = 3
    private let columns = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        MascotView(state: .thinking, color: .quibPurple, size: 64)
                        VStack(alignment: .leading, spacing: 3) {
                            Text("What do you know?")
                                .font(.quib(24))
                                .foregroundStyle(Color.ink)
                            Text("Pick at least \(minimum) topics to battle in.")
                                .font(.quib(13, .bold))
                                .foregroundStyle(Color.mutedText)
                        }
                    }
                    .padding(.top, 16)

                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(QuestionBank.topics) { topic in
                            Button {
                                Haptics.tap()
                                if selected.contains(topic.id) {
                                    selected.remove(topic.id)
                                } else {
                                    selected.insert(topic.id)
                                }
                            } label: {
                                TopicCardView(topic: topic,
                                              subtitle: topic.blurb,
                                              selected: selected.contains(topic.id))
                            }
                            .buttonStyle(NeoPressStyle())
                        }
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 18)
            }

            VStack(spacing: 8) {
                Button {
                    Haptics.heavy()
                    app.profile.favoriteTopicIDs = Array(selected)
                    app.profile.onboarded = true
                } label: {
                    Text(selected.count < minimum
                         ? "Pick \(minimum - selected.count) more"
                         : "Start playing")
                }
                .buttonStyle(NeoButtonStyle(fill: .quibGreen, textColor: .paper, big: true, fullWidth: true))
                .disabled(selected.count < minimum)
                .opacity(selected.count < minimum ? 0.5 : 1)
            }
            .padding(.horizontal, 26)
            .padding(.top, 12)
            .padding(.bottom, 20)
            .background(Color.cream)
        }
        .background(Color.cream.ignoresSafeArea())
    }
}
