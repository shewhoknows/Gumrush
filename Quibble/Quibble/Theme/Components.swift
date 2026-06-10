import SwiftUI

// MARK: - Back button (screens hide the system nav bar)

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button {
            Haptics.tap()
            dismiss()
        } label: {
            Image(systemName: "arrow.left")
        }
        .buttonStyle(NeoIconButtonStyle())
    }
}

struct ScreenHeader: View {
    let title: String
    var showBack: Bool = true
    var backAction: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 12) {
            if let backAction {
                Button {
                    Haptics.tap()
                    backAction()
                } label: {
                    Image(systemName: "arrow.left")
                }
                .buttonStyle(NeoIconButtonStyle())
            } else if showBack {
                BackButton()
            }
            Text(title)
                .font(.quib(26))
                .foregroundStyle(Color.ink)
            Spacer()
        }
        .padding(.bottom, 6)
    }
}

// MARK: - Small stat box

struct StatBox: View {
    let value: String
    let label: String
    var fill: Color = .paper

    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.quib(22))
                .foregroundStyle(Color.ink)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
            Text(label.uppercased())
                .font(.quib(10, .heavy))
                .foregroundStyle(Color.mutedText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .neoCard(fill, radius: 16, shadow: 3, lineWidth: 2.5)
    }
}

// MARK: - XP bar

struct XPBar: View {
    var progress: Double
    var fill: Color = .quibPurple
    var height: CGFloat = 16

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.paper)
                Capsule()
                    .fill(fill)
                    .frame(width: max(height, geo.size.width * min(1, max(0, progress))))
                Capsule().stroke(Color.ink, lineWidth: 2.5)
            }
        }
        .frame(height: height)
    }
}

// MARK: - Chip

struct ChipView: View {
    let text: String
    var icon: String? = nil
    var fill: Color = .paper

    var body: some View {
        HStack(spacing: 5) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 11, weight: .black))
            }
            Text(text)
                .font(.quib(12, .heavy))
        }
        .foregroundStyle(Color.ink)
        .padding(.vertical, 7)
        .padding(.horizontal, 12)
        .background(
            ZStack {
                Capsule().fill(Color.ink).offset(x: 2, y: 2)
                Capsule().fill(fill)
                Capsule().stroke(Color.ink, lineWidth: 2.5)
            }
        )
    }
}

// MARK: - Section header

struct SectionHeader: View {
    let title: String
    var actionLabel: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.quib(19))
                .foregroundStyle(Color.ink)
            Spacer()
            if let actionLabel, let action {
                Button(action: action) {
                    Text(actionLabel)
                        .font(.quib(13, .heavy))
                        .foregroundStyle(Color.quibBlue)
                }
            }
        }
    }
}

// MARK: - Topic card

struct TopicCardView: View {
    let topic: Topic
    var subtitle: String
    var selected: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                MascotView(state: topic.mascot,
                           color: Palette.color(topic.colorName),
                           size: 62,
                           accessory: topic.symbol)
                Spacer()
                if selected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 13, weight: .black))
                        .foregroundStyle(Color.paper)
                        .frame(width: 26, height: 26)
                        .background(Circle().fill(Color.quibGreen))
                        .overlay(Circle().stroke(Color.ink, lineWidth: 2.5))
                }
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(topic.name)
                    .font(.quib(17))
                    .foregroundStyle(Color.ink)
                Text(subtitle)
                    .font(.quib(11, .bold))
                    .foregroundStyle(Color.mutedText)
                    .lineLimit(1)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .neoCard(selected ? Palette.color(topic.colorName).opacity(0.35) : .paper,
                 radius: 20, shadow: selected ? 2 : 4)
    }
}

// MARK: - Match history row

struct MatchRow: View {
    let record: MatchRecord

    private var outcomeColor: Color {
        switch record.outcome {
        case .win:  return .quibGreen
        case .loss: return .quibRed
        case .draw: return .softBlue
        }
    }

    private var outcomeLabel: String {
        switch record.outcome {
        case .win:  return "W"
        case .loss: return "L"
        case .draw: return "D"
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            Text(outcomeLabel)
                .font(.quib(16))
                .foregroundStyle(record.outcome == .draw ? Color.ink : .paper)
                .frame(width: 36, height: 36)
                .background(RoundedRectangle(cornerRadius: 12).fill(outcomeColor))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.ink, lineWidth: 2.5))

            VStack(alignment: .leading, spacing: 2) {
                Text("\(record.topicName) vs \(record.opponentName)")
                    .font(.quib(14, .heavy))
                    .foregroundStyle(Color.ink)
                    .lineLimit(1)
                Text("\(record.yourScore) – \(record.opponentScore) · \(record.correctCount)/\(record.answers.count) correct")
                    .font(.quib(11, .bold))
                    .foregroundStyle(Color.mutedText)
            }
            Spacer()
            Text("+\(record.xpEarned) XP")
                .font(.quib(12, .heavy))
                .foregroundStyle(Color.deepGreen)
        }
        .padding(12)
        .neoCard(.paper, radius: 18, shadow: 3, lineWidth: 2.5)
    }
}

// MARK: - Empty state

struct EmptyStateView: View {
    var mascot: MascotState = .sleepy
    var color: Color = .softBlue
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 12) {
            MascotView(state: mascot, color: color, size: 90)
                .mascotBob()
            Text(title)
                .font(.quib(18))
                .foregroundStyle(Color.ink)
            Text(message)
                .font(.quib(13, .bold))
                .foregroundStyle(Color.mutedText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .padding(.horizontal, 20)
        .neoCard(.paper, radius: 22, shadow: 4)
    }
}

// MARK: - Achievement card

struct AchievementCard: View {
    let achievement: Achievement
    let unlocked: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: achievement.symbol)
                .font(.system(size: 20, weight: .black))
                .foregroundStyle(unlocked ? Color.ink : Color.mutedText)
                .frame(width: 42, height: 42)
                .background(Circle().fill(unlocked ? Color.quibYellow : Color.cream))
                .overlay(Circle().stroke(Color.ink, lineWidth: 2.5))
            Text(achievement.name)
                .font(.quib(14))
                .foregroundStyle(Color.ink)
            Text(achievement.detail)
                .font(.quib(10, .bold))
                .foregroundStyle(Color.mutedText)
                .lineLimit(2)
        }
        .padding(13)
        .frame(maxWidth: .infinity, alignment: .leading)
        .neoCard(unlocked ? .paper : Color(hex: 0xEFE5D2), radius: 18, shadow: 3, lineWidth: 2.5)
        .opacity(unlocked ? 1 : 0.55)
    }
}

// MARK: - Toast

struct ToastView: View {
    let message: String

    var body: some View {
        Text(message)
            .font(.quib(14, .heavy))
            .foregroundStyle(Color.cream)
            .padding(.vertical, 13)
            .padding(.horizontal, 22)
            .background(
                ZStack {
                    Capsule().fill(Color.ink)
                    Capsule().stroke(Color.ink, lineWidth: 3)
                }
            )
            .padding(.horizontal, 30)
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

// MARK: - Confetti

struct ConfettiView: View {
    @State private var go = false

    private struct Piece: Identifiable {
        let id: Int
        let x: CGFloat        // 0...1 across the width
        let delay: Double
        let duration: Double
        let color: Color
        let spin: Double
        let size: CGFloat
    }

    private let pieces: [Piece] = {
        let palette: [Color] = [.quibYellow, .quibPink, .quibGreen, .quibBlue,
                                .quibOrange, .quibPurple, .softBlue, .quibRed]
        return (0..<26).map { i in
            Piece(id: i,
                  x: CGFloat.random(in: 0.02...0.98),
                  delay: Double.random(in: 0...0.5),
                  duration: Double.random(in: 1.6...2.8),
                  color: palette[i % palette.count],
                  spin: Double.random(in: 360...1080),
                  size: CGFloat.random(in: 9...15))
        }
    }()

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(pieces) { piece in
                    Rectangle()
                        .fill(piece.color)
                        .border(Color.ink, width: 1.5)
                        .frame(width: piece.size, height: piece.size)
                        .rotationEffect(.degrees(go ? piece.spin : 0))
                        .position(x: piece.x * geo.size.width,
                                  y: go ? geo.size.height + 30 : -30)
                        .animation(.easeIn(duration: piece.duration).delay(piece.delay),
                                   value: go)
                }
            }
        }
        .allowsHitTesting(false)
        .onAppear { go = true }
    }
}
