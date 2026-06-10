import SwiftUI

struct AllTopicsView: View {
    @EnvironmentObject private var app: AppState
    var isTab: Bool = true

    private let columns = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                ScreenHeader(title: "All Topics", showBack: !isTab)
                    .padding(.top, 8)

                Text("10 worlds. 7 questions each. Pick your battlefield.")
                    .font(.quib(13, .bold))
                    .foregroundStyle(Color.mutedText)

                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(QuestionBank.topics) { topic in
                        NavigationLink {
                            TopicDetailView(topic: topic)
                        } label: {
                            TopicCardView(topic: topic, subtitle: subtitle(for: topic))
                        }
                        .buttonStyle(NeoPressStyle())
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 110)
        }
        .background(Color.cream.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    private func subtitle(for topic: Topic) -> String {
        let stats = app.topicStats(topic.id)
        return stats.played == 0 ? topic.blurb : "Played \(stats.played) · Won \(stats.wins)"
    }
}
