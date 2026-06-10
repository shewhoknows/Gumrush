import SwiftUI

struct TopicDetailView: View {
    @EnvironmentObject private var app: AppState
    let topic: Topic

    private var stats: (played: Int, wins: Int, best: Int) {
        app.topicStats(topic.id)
    }

    private var lurkingBots: [Bot] {
        var rng = SeededGenerator(seed: topic.id.stableHash)
        return Array(MockData.bots.shuffled(using: &rng).prefix(3))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ScreenHeader(title: topic.name)
                    .padding(.top, 8)

                // Hero
                VStack(spacing: 12) {
                    MascotView(state: topic.mascot,
                               color: Palette.color(topic.colorName),
                               size: 130,
                               accessory: topic.symbol)
                        .mascotBob()
                    Text(topic.blurb)
                        .font(.quib(14, .heavy))
                        .foregroundStyle(Color.ink)
                        .multilineTextAlignment(.center)
                    HStack(spacing: 8) {
                        ChipView(text: "7 questions", icon: "list.number")
                        ChipView(text: "10s each", icon: "timer")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 22)
                .padding(.horizontal, 16)
                .neoCard(Palette.color(topic.colorName).opacity(0.4), radius: 26, shadow: 6)

                // Your record
                SectionHeader(title: "Your record")
                HStack(spacing: 10) {
                    StatBox(value: "\(stats.played)", label: "Played")
                    StatBox(value: "\(stats.wins)", label: "Won")
                    StatBox(value: "\(stats.best)", label: "Best score")
                }

                // Who's beatable
                SectionHeader(title: "Blobs lurking here")
                VStack(spacing: 10) {
                    ForEach(lurkingBots) { bot in
                        HStack(spacing: 12) {
                            AvatarView(colorName: bot.colorName, size: 38, state: bot.mascot)
                            VStack(alignment: .leading, spacing: 1) {
                                Text(bot.name)
                                    .font(.quib(14, .heavy))
                                    .foregroundStyle(Color.ink)
                                Text(bot.tagline)
                                    .font(.quib(11, .bold))
                                    .foregroundStyle(Color.mutedText)
                            }
                            Spacer()
                        }
                        .padding(12)
                        .neoCard(.paper, radius: 16, shadow: 3, lineWidth: 2.5)
                    }
                }

                Button {
                    app.startTopicDuel(topic)
                } label: {
                    HStack {
                        Image(systemName: "bolt.fill")
                        Text("Battle in \(topic.name)")
                    }
                }
                .buttonStyle(NeoButtonStyle(fill: .quibRed, textColor: .paper, big: true, fullWidth: true))
                .padding(.top, 6)
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 110)
        }
        .background(Color.cream.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }
}
