import SwiftUI

struct DailyChallengeView: View {
    @EnvironmentObject private var app: AppState

    private var todaysTopics: [Topic] {
        var rng = SeededGenerator(seed: "\(DateKeys.today)-mix".stableHash)
        let count = Int(rng.next() % 3) + 3
        return Array(QuestionBank.topics.shuffled(using: &rng).prefix(count))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ScreenHeader(title: "Daily Challenge")
                    .padding(.top, 8)

                // Hero
                VStack(spacing: 14) {
                    MascotView(state: app.dailyDoneToday ? .proud : .excited,
                               color: .deepGreen, size: 120,
                               accessory: "calendar")
                        .mascotBob()
                    Text(app.dailyDoneToday ? "Crushed it today!" : "One duel. Every day.")
                        .font(.quib(24))
                        .foregroundStyle(Color.ink)
                    Text(app.dailyDoneToday
                         ? "Quizzle retreats to plot tomorrow’s questions."
                         : "7 mixed questions vs Quizzle.\nFinish it to bank +50 XP and feed your streak.")
                        .font(.quib(13, .heavy))
                        .foregroundStyle(Color.mutedText)
                        .multilineTextAlignment(.center)
                    HStack(spacing: 8) {
                        ChipView(text: "+50 XP", icon: "sparkles", fill: .quibYellow)
                        ChipView(text: "Streak \(app.profile.dailyStreak)", icon: "flame.fill", fill: .quibOrange)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 26)
                .padding(.horizontal, 16)
                .neoCard(.softBlue, radius: 28, shadow: 6)

                // Today's mix
                SectionHeader(title: "In today’s mix")
                FlowChips(topics: todaysTopics)

                // Opponent
                SectionHeader(title: "Your opponent")
                HStack(spacing: 12) {
                    AvatarView(colorName: MockData.dailyBot.colorName, size: 44,
                               state: MockData.dailyBot.mascot)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(MockData.dailyBot.name)
                            .font(.quib(15, .heavy))
                            .foregroundStyle(Color.ink)
                        Text(MockData.dailyBot.tagline)
                            .font(.quib(11, .bold))
                            .foregroundStyle(Color.mutedText)
                    }
                    Spacer()
                }
                .padding(13)
                .neoCard(.paper, radius: 18, shadow: 3)

                if app.dailyDoneToday {
                    Button {
                        app.startDailyChallenge()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Replay for fun (no bonus)")
                        }
                    }
                    .buttonStyle(NeoButtonStyle(fill: .paper, fullWidth: true))
                } else {
                    Button {
                        app.startDailyChallenge()
                    } label: {
                        HStack {
                            Image(systemName: "bolt.fill")
                            Text("Play today’s challenge")
                        }
                    }
                    .buttonStyle(NeoButtonStyle(fill: .quibOrange, textColor: .paper, big: true, fullWidth: true))
                }

                NavigationLink {
                    StreakAchievementsView()
                } label: {
                    Text("View streak & badges")
                }
                .buttonStyle(NeoButtonStyle(fill: .paper, fullWidth: true))
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 110)
        }
        .background(Color.cream.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }
}

/// Simple two-row chip layout for today's topic mix.
private struct FlowChips: View {
    let topics: [Topic]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 8) {
                    ForEach(row, id: \.self) { topicID in
                        if let topic = QuestionBank.topic(topicID) {
                            ChipView(text: topic.name, icon: topic.symbol,
                                     fill: Palette.pastel(topic.colorName))
                        }
                    }
                }
            }
        }
    }

    private var rows: [[String]] {
        let ids = topics.map(\.id)
        let firstRowCount = Int(ceil(Double(ids.count) / 2.0))
        return [
            Array(ids.prefix(firstRowCount)),
            Array(ids.dropFirst(firstRowCount))
        ].filter { !$0.isEmpty }
    }
}
