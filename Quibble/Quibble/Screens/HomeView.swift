import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var app: AppState

    private var favoriteTopics: [Topic] {
        let favs = app.profile.favoriteTopicIDs.compactMap { QuestionBank.topic($0) }
        return favs.isEmpty ? Array(QuestionBank.topics.prefix(4)) : favs
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {

                // Header
                HStack(spacing: 12) {
                    AvatarView(colorName: app.profile.colorName, size: 46, state: .happy)
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Hey, \(app.profile.name)!")
                            .font(.quib(22))
                            .foregroundStyle(Color.ink)
                        Text("Level \(app.profile.level) · \(app.profile.xp) XP")
                            .font(.quib(12, .heavy))
                            .foregroundStyle(Color.mutedText)
                    }
                    Spacer()
                    NavigationLink {
                        StreakAchievementsView()
                    } label: {
                        ChipView(text: "\(app.profile.dailyStreak)",
                                 icon: "flame.fill",
                                 fill: .quibOrange)
                    }
                }
                .padding(.top, 8)

                // Hero: quick duel
                VStack(spacing: 14) {
                    HStack(spacing: 16) {
                        MascotView(state: .competitive, color: .quibYellow, size: 92)
                            .mascotBob()
                        VStack(alignment: .leading, spacing: 4) {
                            Text("7 questions.\nEndless battles.")
                                .font(.quib(21))
                                .foregroundStyle(Color.ink)
                            Text("10 seconds a question. No mercy.")
                                .font(.quib(12, .bold))
                                .foregroundStyle(Color.mutedText)
                        }
                        Spacer(minLength: 0)
                    }
                    Button {
                        app.startQuickDuel()
                    } label: {
                        HStack {
                            Image(systemName: "bolt.fill")
                            Text("Quick Duel")
                        }
                    }
                    .buttonStyle(NeoButtonStyle(fill: .quibRed, textColor: .paper, big: true, fullWidth: true))
                }
                .padding(18)
                .neoCard(.quibPink, radius: 26, shadow: 6)

                // Daily challenge
                NavigationLink {
                    DailyChallengeView()
                } label: {
                    HStack(spacing: 14) {
                        MascotView(state: app.dailyDoneToday ? .proud : .excited,
                                   color: .deepGreen, size: 60,
                                   accessory: "calendar")
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Daily Challenge")
                                .font(.quib(17))
                                .foregroundStyle(Color.ink)
                            Text(app.dailyDoneToday
                                 ? "Done for today! Come back tomorrow."
                                 : "7 mixed questions vs Quizzle · +50 XP")
                                .font(.quib(12, .bold))
                                .foregroundStyle(Color.mutedText)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        Image(systemName: app.dailyDoneToday ? "checkmark.circle.fill" : "chevron.right")
                            .font(.system(size: 18, weight: .black))
                            .foregroundStyle(app.dailyDoneToday ? Color.quibGreen : Color.ink)
                    }
                    .padding(14)
                    .neoCard(app.dailyDoneToday ? .paper : .quibYellow, radius: 22, shadow: 4)
                }
                .buttonStyle(NeoPressStyle())

                // Favorite topics
                SectionHeader(title: "Your topics")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(favoriteTopics) { topic in
                            NavigationLink {
                                TopicDetailView(topic: topic)
                            } label: {
                                TopicCardView(topic: topic, subtitle: subtitle(for: topic))
                                    .frame(width: 160)
                            }
                            .buttonStyle(NeoPressStyle())
                        }
                        NavigationLink {
                            AllTopicsView(isTab: false)
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: "square.grid.2x2.fill")
                                    .font(.system(size: 22, weight: .black))
                                    .foregroundStyle(Color.ink)
                                Text("All topics")
                                    .font(.quib(13, .heavy))
                                    .foregroundStyle(Color.ink)
                            }
                            .frame(width: 110, height: 132)
                            .neoCard(.softBlue, radius: 20, shadow: 4)
                        }
                        .buttonStyle(NeoPressStyle())
                    }
                    .padding(4)
                }

                // Challenge a friend
                NavigationLink {
                    ChallengeFriendView()
                } label: {
                    HStack(spacing: 14) {
                        ZStack {
                            AvatarView(colorName: "softPink", size: 40, state: .surprised)
                                .offset(x: -14)
                            AvatarView(colorName: "blue", size: 40, state: .competitive)
                                .offset(x: 14)
                        }
                        .frame(width: 70)
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Challenge a friend")
                                .font(.quib(17))
                                .foregroundStyle(Color.ink)
                            Text("Pick a topic, talk trash, win.")
                                .font(.quib(12, .bold))
                                .foregroundStyle(Color.mutedText)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .black))
                            .foregroundStyle(Color.ink)
                    }
                    .padding(14)
                    .neoCard(.paper, radius: 22, shadow: 4)
                }
                .buttonStyle(NeoPressStyle())

                // Recent duels
                if !app.history.isEmpty {
                    SectionHeader(title: "Recent duels")
                    VStack(spacing: 10) {
                        ForEach(app.history.prefix(3)) { record in
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

    private func subtitle(for topic: Topic) -> String {
        let stats = app.topicStats(topic.id)
        return stats.played == 0 ? topic.blurb : "Played \(stats.played) · Won \(stats.wins)"
    }
}
