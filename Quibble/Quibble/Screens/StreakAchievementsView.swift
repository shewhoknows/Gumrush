import SwiftUI

struct StreakAchievementsView: View {
    @EnvironmentObject private var app: AppState

    private let achievementColumns = [GridItem(.flexible(), spacing: 12),
                                      GridItem(.flexible(), spacing: 12)]

    private var weekDays: [(label: String, dayNumber: String, key: String, isToday: Bool)] {
        let cal = Calendar.current
        let today = Date()
        guard let interval = cal.dateInterval(of: .weekOfYear, for: today) else { return [] }
        let labels = ["S", "M", "T", "W", "T", "F", "S"]
        return (0..<7).compactMap { offset in
            guard let date = cal.date(byAdding: .day, value: offset, to: interval.start) else { return nil }
            let weekdayIndex = cal.component(.weekday, from: date) - 1
            return (labels[weekdayIndex],
                    "\(cal.component(.day, from: date))",
                    DateKeys.key(for: date),
                    cal.isDateInToday(date))
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ScreenHeader(title: "Streak & Badges")
                    .padding(.top, 8)

                // Streak hero
                VStack(spacing: 10) {
                    HStack(spacing: 16) {
                        MascotView(state: app.profile.dailyStreak > 0 ? .excited : .sleepy,
                                   color: .quibOrange, size: 90,
                                   accessory: "flame.fill")
                            .mascotBob()
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(app.profile.dailyStreak) day\(app.profile.dailyStreak == 1 ? "" : "s")")
                                .font(.quib(34))
                                .foregroundStyle(Color.ink)
                            Text("Daily streak · best \(app.profile.bestDailyStreak)")
                                .font(.quib(13, .heavy))
                                .foregroundStyle(Color.mutedText)
                        }
                        Spacer()
                    }
                    Text(app.dailyDoneToday
                         ? "Today is banked. See you tomorrow."
                         : "Play today’s daily challenge to keep the flame alive.")
                        .font(.quib(12, .bold))
                        .foregroundStyle(Color.mutedText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(16)
                .neoCard(.quibYellow, radius: 24, shadow: 5)

                // Week calendar
                SectionHeader(title: "This week")
                HStack(spacing: 8) {
                    ForEach(weekDays, id: \.key) { day in
                        let hit = app.dailyCompletionDays.contains(day.key)
                        VStack(spacing: 5) {
                            Text(day.label)
                                .font(.quib(10, .heavy))
                                .foregroundStyle(Color.mutedText)
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(hit ? Color.quibOrange : Color.paper)
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.ink, lineWidth: day.isToday ? 3.5 : 2.5)
                                if hit {
                                    Image(systemName: "flame.fill")
                                        .font(.system(size: 14, weight: .black))
                                        .foregroundStyle(Color.paper)
                                } else {
                                    Text(day.dayNumber)
                                        .font(.quib(12, .heavy))
                                        .foregroundStyle(Color.mutedText)
                                }
                            }
                            .frame(height: 42)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(14)
                .neoCard(.paper, radius: 20, shadow: 3)

                // All achievements
                SectionHeader(title: "Badges (\(app.profile.unlockedAchievements.count)/\(MockData.achievements.count))")
                LazyVGrid(columns: achievementColumns, spacing: 12) {
                    ForEach(MockData.achievements) { achievement in
                        AchievementCard(achievement: achievement,
                                        unlocked: app.isUnlocked(achievement.id))
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
