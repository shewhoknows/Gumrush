import SwiftUI

struct ResultsView: View {
    let setup: MatchSetup
    let summary: MatchSummary
    let profile: PlayerProfile
    let onRematch: () -> Void
    let onReview: () -> Void
    let onDone: () -> Void

    private var record: MatchRecord { summary.record }

    private var bestStreakInMatch: Int {
        var best = 0, run = 0
        for answer in record.answers {
            run = answer.isCorrect ? run + 1 : 0
            best = max(best, run)
        }
        return best
    }

    private var fastestCorrect: String {
        let times = record.answers.filter(\.isCorrect).map(\.timeTaken)
        guard let fastest = times.min() else { return "—" }
        return String(format: "%.1fs", fastest)
    }

    private var flavorLine: String {
        let lines: [String]
        switch record.outcome {
        case .win:  lines = MockData.winLines
        case .loss: lines = MockData.lossLines
        case .draw: lines = MockData.drawLines
        }
        return lines[Int(record.id.uuidString.stableHash % UInt64(lines.count))]
    }

    private var bannerTitle: String {
        switch record.outcome {
        case .win:  return "You win!"
        case .loss: return "Bested!"
        case .draw: return "Dead heat!"
        }
    }

    private var bannerColor: Color {
        switch record.outcome {
        case .win:  return Palette.pastel("green")
        case .loss: return Palette.pastel("red")
        case .draw: return .softBlue
        }
    }

    private var yourMascot: MascotState {
        switch record.outcome {
        case .win:  return .proud
        case .loss: return .confused
        case .draw: return .surprised
        }
    }

    private var theirMascot: MascotState {
        switch record.outcome {
        case .win:  return .sleepy
        case .loss: return .proud
        case .draw: return .surprised
        }
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        Button {
                            Haptics.tap()
                            onDone()
                        } label: {
                            Image(systemName: "house.fill")
                        }
                        .buttonStyle(NeoIconButtonStyle())

                        Spacer()
                    }
                    .padding(.top, 10)

                    // Banner
                    VStack(spacing: 12) {
                        HStack(spacing: 26) {
                            VStack(spacing: 6) {
                                MascotView(state: yourMascot,
                                           color: Palette.color(profile.colorName), size: 86)
                                    .mascotBob()
                                Text(profile.name)
                                    .font(.quib(13, .heavy))
                            }
                            Text("\(record.yourScore)\n—\n\(record.opponentScore)")
                                .font(.quib(20))
                                .multilineTextAlignment(.center)
                            VStack(spacing: 6) {
                                MascotView(state: theirMascot,
                                           color: Palette.color(record.opponentColorName), size: 86)
                                Text(record.opponentName)
                                    .font(.quib(13, .heavy))
                            }
                        }
                        Text(bannerTitle)
                            .font(.quib(34))
                        Text(flavorLine)
                            .font(.quib(13, .heavy))
                            .opacity(0.85)
                    }
                    .foregroundStyle(Color.ink)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .padding(.horizontal, 14)
                    .neoCard(bannerColor, radius: 28, shadow: 6)

                    // Actions
                    VStack(spacing: 12) {
                        Button {
                            Haptics.heavy()
                            onRematch()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                Text("Play again")
                            }
                        }
                        .buttonStyle(NeoButtonStyle(fill: .quibRed, textColor: .paper, big: true, fullWidth: true))

                        Button {
                            Haptics.tap()
                            onReview()
                        } label: {
                            Text("Review answers")
                        }
                        .buttonStyle(NeoButtonStyle(fill: .paper, fullWidth: true))

                        Button {
                            Haptics.tap()
                            onDone()
                        } label: {
                            Text("Back to home")
                                .font(.quib(14, .heavy))
                                .foregroundStyle(Color.mutedText)
                        }
                    }

                    // Question dots
                    HStack(spacing: 8) {
                        ForEach(record.answers) { answer in
                            Circle()
                                .fill(answer.isCorrect ? Color.quibGreen : Color.quibRed)
                                .frame(width: 15, height: 15)
                                .overlay(Circle().stroke(Color.ink, lineWidth: 2.5))
                        }
                    }

                    // Match stats
                    HStack(spacing: 10) {
                        StatBox(value: "\(record.correctCount)/\(record.answers.count)", label: "Correct")
                        StatBox(value: "×\(bestStreakInMatch)", label: "Best streak")
                        StatBox(value: fastestCorrect, label: "Fastest")
                    }

                    // XP
                    VStack(spacing: 10) {
                        ForEach(summary.xpLines) { line in
                            HStack {
                                Text(line.label)
                                    .font(.quib(14, .heavy))
                                    .foregroundStyle(Color.ink)
                                Spacer()
                                Text("+\(line.amount) XP")
                                    .font(.quib(14))
                                    .foregroundStyle(Color.deepGreen)
                            }
                        }
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 2)
                            .overlay(Rectangle().stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                                .foregroundStyle(Color(hex: 0xD8CDB8)))
                        HStack {
                            Text("Total")
                                .font(.quib(16))
                                .foregroundStyle(Color.ink)
                            Spacer()
                            Text("+\(summary.totalXP) XP")
                                .font(.quib(18))
                                .foregroundStyle(Color.deepGreen)
                        }
                        HStack(spacing: 10) {
                            Text("LV \(profile.level)")
                                .font(.quib(12, .heavy))
                                .foregroundStyle(Color.mutedText)
                            XPBar(progress: profile.levelProgress)
                            Text("\(profile.xpIntoLevel)/\(PlayerProfile.xpPerLevel)")
                                .font(.quib(11, .heavy))
                                .foregroundStyle(Color.mutedText)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .neoCard(.paper, radius: 22, shadow: 4)

                    // New achievements
                    if !summary.unlocked.isEmpty {
                        VStack(spacing: 10) {
                            ForEach(summary.unlocked) { achievement in
                                HStack(spacing: 12) {
                                    Image(systemName: achievement.symbol)
                                        .font(.system(size: 18, weight: .black))
                                        .foregroundStyle(Color.ink)
                                        .frame(width: 40, height: 40)
                                        .background(Circle().fill(Color.quibYellow))
                                        .overlay(Circle().stroke(Color.ink, lineWidth: 2.5))
                                    VStack(alignment: .leading, spacing: 1) {
                                        Text("Achievement unlocked!")
                                            .font(.quib(11, .heavy))
                                            .foregroundStyle(Color.mutedText)
                                        Text("\(achievement.name) — \(achievement.detail)")
                                            .font(.quib(13, .heavy))
                                            .foregroundStyle(Color.ink)
                                    }
                                    Spacer()
                                }
                                .padding(12)
                                .neoCard(.quibYellow, radius: 18, shadow: 3)
                            }
                        }
                    }
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 24)
            }

            if record.outcome == .win {
                ConfettiView()
            }
        }
        .onAppear {
            if record.outcome == .win {
                Haptics.success()
            }
        }
    }
}
