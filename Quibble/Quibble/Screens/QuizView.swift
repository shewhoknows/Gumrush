import SwiftUI

struct QuizView: View {
    @ObservedObject var engine: MatchEngine
    let playerProfile: PlayerProfile
    let onQuit: () -> Void

    private let optionKeys = ["A", "B", "C", "D"]

    var body: some View {
        VStack(spacing: 14) {

            // Scores + quit
            HStack(spacing: 10) {
                Button {
                    Haptics.tap()
                    onQuit()
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(NeoIconButtonStyle(size: 38))

                ScorePill(name: playerProfile.name,
                          score: engine.yourScore,
                          colorName: playerProfile.colorName,
                          state: .competitive,
                          highlight: false)
                Spacer()
                ScorePill(name: engine.setup.opponent.name,
                          score: engine.botScore,
                          colorName: engine.setup.opponent.colorName,
                          state: engine.setup.opponent.mascot,
                          highlight: engine.botHasAnswered)
            }
            .padding(.top, 8)

            // Progress dots
            HStack(spacing: 7) {
                ForEach(0..<engine.questionCount, id: \.self) { i in
                    dot(for: engine.dotState(i))
                }
            }

            // Timer
            VStack(spacing: 4) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.paper)
                        Capsule()
                            .fill(timerColor)
                            .frame(width: max(0, geo.size.width * engine.timeRemaining / MatchEngine.questionTime))
                        Capsule().stroke(Color.ink, lineWidth: 3)
                    }
                }
                .frame(height: 20)
                HStack {
                    Text("Q\(engine.index + 1) of \(engine.questionCount)")
                        .font(.quib(11, .heavy))
                        .foregroundStyle(Color.mutedText)
                    Spacer()
                    if engine.yourStreak >= 3 {
                        ChipView(text: "Streak ×\(engine.yourStreak) · +25",
                                 icon: "flame.fill", fill: .quibOrange)
                    }
                    Spacer()
                    Text(String(format: "%.1fs", engine.timeRemaining))
                        .font(.quib(11, .heavy))
                        .foregroundStyle(Color.mutedText)
                        .monospacedDigit()
                }
            }

            // Question
            Text(engine.currentQuestion.text)
                .font(.quib(20))
                .foregroundStyle(Color.ink)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.7)
                .frame(maxWidth: .infinity, minHeight: 120)
                .padding(.vertical, 18)
                .padding(.horizontal, 16)
                .neoCard(.paper, radius: 24, shadow: 5)

            // Options
            VStack(spacing: 11) {
                ForEach(Array(engine.currentQuestion.options.enumerated()), id: \.offset) { i, option in
                    Button {
                        engine.choose(i)
                    } label: {
                        HStack(spacing: 12) {
                            Text(optionKeys[i])
                                .font(.quib(13))
                                .frame(width: 30, height: 30)
                                .background(RoundedRectangle(cornerRadius: 10).fill(keyFill(i)))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.ink, lineWidth: 2.5))
                            Text(option)
                                .font(.quib(15, .heavy))
                                .multilineTextAlignment(.leading)
                                .minimumScaleFactor(0.8)
                            Spacer(minLength: 0)
                        }
                        .foregroundStyle(textColor(i))
                        .padding(.vertical, 14)
                        .padding(.horizontal, 14)
                        .frame(maxWidth: .infinity)
                        .neoCard(optionFill(i), radius: 18, shadow: 3)
                        .opacity(optionOpacity(i))
                    }
                    .buttonStyle(NeoPressStyle())
                    .disabled(engine.phase != .question)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 18)
        .overlay(alignment: .bottom) {
            if let feedback = engine.feedback {
                FeedbackCard(feedback: feedback, opponentName: engine.setup.opponent.name)
                    .padding(.horizontal, 18)
                    .padding(.bottom, 18)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(duration: 0.3), value: engine.feedback)
    }

    private var timerColor: Color {
        if engine.timeRemaining > 5 { return .quibGreen }
        if engine.timeRemaining > 2.5 { return .quibOrange }
        return .quibRed
    }

    @ViewBuilder
    private func dot(for state: MatchEngine.DotState) -> some View {
        Circle()
            .fill(dotFill(state))
            .frame(width: 13, height: 13)
            .overlay(Circle().stroke(Color.ink, lineWidth: 2.5))
            .scaleEffect(state == .current ? 1.25 : 1)
    }

    private func dotFill(_ state: MatchEngine.DotState) -> Color {
        switch state {
        case .pending: return .paper
        case .current: return .quibYellow
        case .right:   return .quibGreen
        case .wrong:   return .quibRed
        }
    }

    // MARK: - Option styling during feedback

    private func optionFill(_ i: Int) -> Color {
        guard engine.feedback != nil else { return .paper }
        if i == engine.currentQuestion.correctIndex { return .quibGreen }
        if i == engine.chosenIndex { return .quibRed }
        return .paper
    }

    private func textColor(_ i: Int) -> Color {
        guard engine.feedback != nil else { return .ink }
        if i == engine.currentQuestion.correctIndex { return .paper }
        if i == engine.chosenIndex { return .paper }
        return .ink
    }

    private func keyFill(_ i: Int) -> Color {
        guard engine.feedback != nil else { return .cream }
        if i == engine.currentQuestion.correctIndex || i == engine.chosenIndex { return .paper }
        return .cream
    }

    private func optionOpacity(_ i: Int) -> Double {
        guard engine.feedback != nil else { return 1 }
        if i == engine.currentQuestion.correctIndex || i == engine.chosenIndex { return 1 }
        return 0.45
    }
}

// MARK: - Score pill

private struct ScorePill: View {
    let name: String
    let score: Int
    let colorName: String
    let state: MascotState
    let highlight: Bool

    var body: some View {
        HStack(spacing: 7) {
            AvatarView(colorName: colorName, size: 27, state: state)
            VStack(alignment: .leading, spacing: 0) {
                Text(name)
                    .font(.quib(9, .heavy))
                    .foregroundStyle(Color.mutedText)
                    .lineLimit(1)
                Text("\(score)")
                    .font(.quib(15))
                    .foregroundStyle(Color.ink)
                    .monospacedDigit()
                    .contentTransition(.numericText())
            }
        }
        .padding(.vertical, 5)
        .padding(.leading, 6)
        .padding(.trailing, 12)
        .background(
            ZStack {
                Capsule().fill(Color.ink).offset(x: 2, y: 2)
                Capsule().fill(highlight ? Color.quibYellow : Color.paper)
                Capsule().stroke(Color.ink, lineWidth: 2.5)
            }
        )
        .scaleEffect(highlight ? 1.06 : 1)
        .animation(.spring(duration: 0.25), value: highlight)
        .animation(.spring(duration: 0.3), value: score)
    }
}

// MARK: - Answer feedback card

private struct FeedbackCard: View {
    let feedback: MatchEngine.Feedback
    let opponentName: String

    private var mascotState: MascotState {
        if feedback.correct {
            return feedback.streakBonus > 0 ? .excited : .happy
        }
        return feedback.timedOut ? .sleepy : .confused
    }

    private var title: String {
        if feedback.correct { return "+\(feedback.total)" }
        return feedback.timedOut ? "Time’s up!" : "Nope!"
    }

    private var detail: String {
        if feedback.correct {
            var parts = ["100 base"]
            if feedback.speedBonus > 0 { parts.append("+\(feedback.speedBonus) speed") }
            if feedback.streakBonus > 0 { parts.append("+\(feedback.streakBonus) streak") }
            return parts.joined(separator: "  ·  ")
        }
        return feedback.timedOut ? "The clock shows no mercy." : "It happens to the best blobs."
    }

    private var botLine: String {
        feedback.botCorrect ? "\(opponentName) got it right" : "\(opponentName) missed it"
    }

    var body: some View {
        HStack(spacing: 14) {
            MascotView(state: mascotState,
                       color: feedback.correct ? .quibGreen : .quibRed,
                       size: 64)
                .mascotWiggle()
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.quib(26))
                    .foregroundStyle(feedback.correct ? Color.quibGreen : Color.quibRed)
                Text(detail)
                    .font(.quib(12, .heavy))
                    .foregroundStyle(Color.ink)
                HStack(spacing: 5) {
                    Image(systemName: feedback.botCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.system(size: 11, weight: .black))
                        .foregroundStyle(feedback.botCorrect ? Color.quibGreen : Color.quibRed)
                    Text(botLine)
                        .font(.quib(11, .bold))
                        .foregroundStyle(Color.mutedText)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .neoCard(.paper, radius: 24, shadow: 6)
    }
}
