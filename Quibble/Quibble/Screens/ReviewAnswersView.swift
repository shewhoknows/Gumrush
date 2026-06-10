import SwiftUI

struct ReviewAnswersView: View {
    let answers: [AnswerRecord]
    let opponentName: String
    var onBack: (() -> Void)? = nil

    private var correctCount: Int { answers.filter(\.isCorrect).count }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                ScreenHeader(title: "Review Answers", backAction: onBack)
                    .padding(.top, 8)

                HStack(spacing: 8) {
                    ChipView(text: "\(correctCount)/\(answers.count) correct",
                             icon: "checkmark.seal.fill", fill: .quibGreen)
                    ChipView(text: "+\(answers.map(\.points).reduce(0, +)) pts",
                             icon: "sum", fill: .quibYellow)
                }

                ForEach(Array(answers.enumerated()), id: \.element.id) { i, answer in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .top, spacing: 10) {
                            Text("\(i + 1)")
                                .font(.quib(13))
                                .foregroundStyle(Color.paper)
                                .frame(width: 26, height: 26)
                                .background(Circle().fill(answer.isCorrect ? Color.quibGreen : Color.quibRed))
                                .overlay(Circle().stroke(Color.ink, lineWidth: 2.5))
                            Text(answer.questionText)
                                .font(.quib(15, .heavy))
                                .foregroundStyle(Color.ink)
                                .multilineTextAlignment(.leading)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            HStack(spacing: 6) {
                                Text("You:")
                                    .font(.quib(11, .heavy))
                                    .foregroundStyle(Color.mutedText)
                                AnswerPill(
                                    text: answer.chosenIndex.map { answer.options[$0] } ?? "No answer",
                                    kind: answer.timedOut ? .neutral : (answer.isCorrect ? .good : .bad))
                            }
                            if !answer.isCorrect {
                                HStack(spacing: 6) {
                                    Text("Right:")
                                        .font(.quib(11, .heavy))
                                        .foregroundStyle(Color.mutedText)
                                    AnswerPill(text: answer.options[answer.correctIndex], kind: .good)
                                }
                            }
                        }

                        HStack {
                            HStack(spacing: 4) {
                                Image(systemName: answer.botCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .font(.system(size: 11, weight: .black))
                                    .foregroundStyle(answer.botCorrect ? Color.quibGreen : Color.quibRed)
                                Text("\(opponentName) \(answer.botCorrect ? "+\(answer.botPoints)" : "missed")")
                                    .font(.quib(11, .bold))
                                    .foregroundStyle(Color.mutedText)
                            }
                            Spacer()
                            Text(String(format: "%.1fs · +%d pts", answer.timeTaken, answer.points))
                                .font(.quib(11, .heavy))
                                .foregroundStyle(answer.points > 0 ? Color.deepGreen : Color.mutedText)
                        }
                    }
                    .padding(14)
                    .neoCard(.paper, radius: 20, shadow: 3, lineWidth: 2.5)
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 110)
        }
        .background(Color.cream.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }
}

private struct AnswerPill: View {
    enum Kind { case good, bad, neutral }
    let text: String
    let kind: Kind

    private var fill: Color {
        switch kind {
        case .good:    return .quibGreen
        case .bad:     return .quibRed
        case .neutral: return .cream
        }
    }

    var body: some View {
        Text(text)
            .font(.quib(12, .heavy))
            .foregroundStyle(kind == .neutral ? Color.ink : Color.paper)
            .padding(.vertical, 5)
            .padding(.horizontal, 12)
            .background(Capsule().fill(fill))
            .overlay(Capsule().stroke(Color.ink, lineWidth: 2.5))
    }
}
