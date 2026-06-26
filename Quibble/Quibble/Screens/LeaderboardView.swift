import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject private var app: AppState
    @State private var board: Board = .week
    @State private var loadedEntries: [LeaderboardEntry] = []
    @State private var isLoading = false

    enum Board: String, CaseIterable {
        case today = "Today"
        case week = "This Week"
        case allTime = "All Time"
        case friends = "Friends"
    }

    private var entries: [LeaderboardEntry] {
        switch board {
        case .today:   return loadedEntries.isEmpty ? app.leaderboard(weekly: true) : loadedEntries
        case .week:    return app.leaderboard(weekly: true)
        case .allTime: return loadedEntries.isEmpty ? app.leaderboard(weekly: false) : loadedEntries
        case .friends: return app.friendLeaderboard()
        }
    }

    private var playerRank: Int {
        (entries.firstIndex { $0.isPlayer } ?? 0) + 1
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                ScreenHeader(title: "Leaderboard", showBack: false)
                    .padding(.top, 8)

                // Board picker
                HStack(spacing: 8) {
                    ForEach(Board.allCases, id: \.self) { option in
                        Button {
                            Haptics.tap()
                            withAnimation(.spring(duration: 0.25)) { board = option }
                        } label: {
                            Text(option.rawValue)
                                .font(.quib(12, .heavy))
                                .foregroundStyle(Color.ink)
                                .padding(.vertical, 9)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Capsule().fill(board == option ? Color.quibYellow : Color.paper)
                                        Capsule().stroke(Color.ink, lineWidth: 2.5)
                                    }
                                )
                        }
                    }
                }

                // Your standing
                HStack(spacing: 12) {
                    MascotView(state: playerRank <= 3 ? .proud : .competitive,
                               color: Palette.color(app.profile.colorName), size: 56)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("You’re #\(playerRank)")
                            .font(.quib(18))
                            .foregroundStyle(Color.ink)
                        Text(playerRank <= 3
                             ? "Podium blob. Defend it."
                             : "Win duels to climb the board.")
                            .font(.quib(12, .bold))
                            .foregroundStyle(Color.mutedText)
                    }
                    Spacer()
                }
                .padding(14)
                .neoCard(.quibPink, radius: 22, shadow: 4)

                // Rows
                VStack(spacing: 10) {
                    if isLoading {
                        EmptyStateView(mascot: .thinking,
                                       color: .quibPurple,
                                       title: "Fetching the board",
                                       message: "Checking the latest scores. Local standings are ready if the server naps.")
                    }
                    ForEach(Array(entries.enumerated()), id: \.element.id) { i, entry in
                        HStack(spacing: 12) {
                            Text("\(i + 1)")
                                .font(.quib(15))
                                .foregroundStyle(Color.ink)
                                .frame(width: 34, height: 34)
                                .background(
                                    RoundedRectangle(cornerRadius: 12).fill(rankColor(i + 1))
                                )
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.ink, lineWidth: 2.5))

                            AvatarView(colorName: entry.colorName, size: 34,
                                       state: i == 0 ? .proud : .neutral)

                            Text(entry.isPlayer ? "\(entry.name) (you)" : entry.name)
                                .font(.quib(15, .heavy))
                                .foregroundStyle(Color.ink)
                                .lineLimit(1)
                            Spacer()
                            Text("\(entry.xp) XP")
                                .font(.quib(13, .heavy))
                                .foregroundStyle(Color.mutedText)
                                .monospacedDigit()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 12)
                        .neoCard(entry.isPlayer ? .quibYellow : .paper,
                                 radius: 18, shadow: 3, lineWidth: 2.5)
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 110)
        }
        .background(Color.cream.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .task { await loadBoard() }
        .onChange(of: board) { _, _ in
            Task { await loadBoard() }
        }
    }

    private func loadBoard() async {
        guard board == .today || board == .allTime else {
            loadedEntries = []
            return
        }
        isLoading = true
        if board == .today {
            loadedEntries = await app.loadDailyLeaderboard()
        } else {
            loadedEntries = await app.loadTopicLeaderboard(topicID: "all")
        }
        isLoading = false
    }

    private func rankColor(_ rank: Int) -> Color {
        switch rank {
        case 1:  return .quibYellow
        case 2:  return .softBlue
        case 3:  return .peach
        default: return .cream
        }
    }
}
