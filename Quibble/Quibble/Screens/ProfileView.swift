import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var app: AppState
    @State private var editingName = false
    @State private var draftName = ""
    @State private var confirmReset = false

    private let achievementColumns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ScreenHeader(title: "Profile", showBack: false)
                    .padding(.top, 8)

                // Identity
                VStack(spacing: 14) {
                    MascotView(state: .happy,
                               color: Palette.color(app.profile.colorName),
                               size: 110)
                        .mascotBob()

                    if editingName {
                        HStack(spacing: 8) {
                            TextField("Your name", text: $draftName)
                                .font(.quib(17))
                                .foregroundStyle(Color.ink)
                                .padding(.vertical, 11)
                                .padding(.horizontal, 14)
                                .background(
                                    RoundedRectangle(cornerRadius: 14).fill(Color.paper)
                                )
                                .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.ink, lineWidth: 2.5))
                                .submitLabel(.done)
                                .onSubmit(saveName)
                            Button(action: saveName) {
                                Image(systemName: "checkmark")
                            }
                            .buttonStyle(NeoIconButtonStyle(fill: .quibGreen))
                        }
                    } else {
                        Button {
                            draftName = app.profile.name
                            editingName = true
                        } label: {
                            HStack(spacing: 7) {
                                Text(app.profile.name)
                                    .font(.quib(24))
                                    .foregroundStyle(Color.ink)
                                Image(systemName: "pencil")
                                    .font(.system(size: 14, weight: .black))
                                    .foregroundStyle(Color.mutedText)
                            }
                        }
                    }

                    // Blob color
                    HStack(spacing: 9) {
                        ForEach(["yellow", "pink", "blue", "green", "orange", "purple", "softBlue"], id: \.self) { name in
                            Button {
                                Haptics.tap()
                                app.profile.colorName = name
                            } label: {
                                Circle()
                                    .fill(Palette.color(name))
                                    .frame(width: 34, height: 34)
                                    .overlay(Circle().stroke(Color.ink, lineWidth: 2.5))
                                    .overlay {
                                        if app.profile.colorName == name {
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 12, weight: .black))
                                                .foregroundStyle(Color.ink)
                                        }
                                    }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .neoCard(.paper, radius: 26, shadow: 5)

                // Level
                VStack(spacing: 8) {
                    HStack {
                        Text("Level \(app.profile.level)")
                            .font(.quib(17))
                            .foregroundStyle(Color.ink)
                        Spacer()
                        Text("\(app.profile.xpIntoLevel)/\(PlayerProfile.xpPerLevel) XP")
                            .font(.quib(12, .heavy))
                            .foregroundStyle(Color.mutedText)
                    }
                    XPBar(progress: app.profile.levelProgress)
                    Text("Total \(app.profile.xp) XP · \(app.profile.weeklyXP) XP this week")
                        .font(.quib(11, .bold))
                        .foregroundStyle(Color.mutedText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(16)
                .neoCard(.quibPurple.opacity(0.45), radius: 22, shadow: 4)

                // Stats
                SectionHeader(title: "Stats")
                HStack(spacing: 10) {
                    StatBox(value: "\(app.totalMatches)", label: "Duels")
                    StatBox(value: "\(app.totalWins)", label: "Wins")
                    StatBox(value: "\(app.winRate)%", label: "Win rate")
                }
                HStack(spacing: 10) {
                    StatBox(value: "\(app.bestScore)", label: "Best score")
                    StatBox(value: "\(app.profile.dailyStreak)", label: "Streak")
                    StatBox(value: "\(app.profile.bestDailyStreak)", label: "Best streak")
                }

                // Achievements preview
                SectionHeader(title: "Achievements")
                LazyVGrid(columns: achievementColumns, spacing: 12) {
                    ForEach(MockData.achievements.prefix(4)) { achievement in
                        AchievementCard(achievement: achievement,
                                        unlocked: app.isUnlocked(achievement.id))
                    }
                }
                NavigationLink {
                    StreakAchievementsView()
                } label: {
                    Text("See all achievements")
                }
                .buttonStyle(NeoButtonStyle(fill: .paper, fullWidth: true))

                // Settings
                SectionHeader(title: "Settings")
                VStack(spacing: 0) {
                    Toggle(isOn: Binding(
                        get: { app.profile.hapticsOn },
                        set: { app.profile.hapticsOn = $0 })) {
                        HStack(spacing: 10) {
                            Image(systemName: "iphone.radiowaves.left.and.right")
                                .font(.system(size: 16, weight: .black))
                            Text("Haptics")
                                .font(.quib(15, .heavy))
                        }
                        .foregroundStyle(Color.ink)
                    }
                    .tint(.quibGreen)
                    .padding(16)
                }
                .neoCard(.paper, radius: 20, shadow: 3)

                Button {
                    confirmReset = true
                } label: {
                    HStack {
                        Image(systemName: "trash.fill")
                        Text("Reset all data")
                    }
                }
                .buttonStyle(NeoButtonStyle(fill: .quibRed, textColor: .paper, fullWidth: true))
                .confirmationDialog("Reset everything?",
                                    isPresented: $confirmReset,
                                    titleVisibility: .visible) {
                    Button("Wipe my XP, history and streak", role: .destructive) {
                        app.resetAllData()
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("This clears your local profile, matches and achievements.")
                }

                Text("Quibble MVP · fully local demo · no account needed")
                    .font(.quib(11, .bold))
                    .foregroundStyle(Color.mutedText)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 110)
        }
        .background(Color.cream.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    private func saveName() {
        let trimmed = draftName.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty {
            app.profile.name = String(trimmed.prefix(14))
        }
        editingName = false
    }
}
