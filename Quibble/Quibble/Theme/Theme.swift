import SwiftUI
import UIKit

// MARK: - Palette

extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }

    static let cream      = Color(hex: 0xFDEDD4)
    static let quibRed    = Color(hex: 0xF20815)
    static let quibGreen  = Color(hex: 0x11A253)
    static let quibPink   = Color(hex: 0xFCA4E0)
    static let quibBlue   = Color(hex: 0x155FCC)
    static let ink        = Color(hex: 0x111111)
    static let quibOrange = Color(hex: 0xFE5F0B)
    static let deepGreen  = Color(hex: 0x317653)
    static let peach      = Color(hex: 0xF7AB54)
    static let softPink   = Color(hex: 0xFA97C2)
    static let softBlue   = Color(hex: 0xA3BDF1)
    static let quibYellow = Color(hex: 0xFCCA59)
    static let quibPurple = Color(hex: 0xA78BFA)
    static let paper      = Color(hex: 0xFFF8EC)
    static let mutedText  = Color(hex: 0x5B5347)
}

enum Palette {
    static let names: [String] = [
        "yellow", "pink", "blue", "green", "orange", "purple",
        "softBlue", "softPink", "peach", "deepGreen", "red", "cream"
    ]

    static func color(_ name: String) -> Color {
        switch name {
        case "red":       return .quibRed
        case "green":     return .quibGreen
        case "pink":      return .quibPink
        case "blue":      return .quibBlue
        case "orange":    return .quibOrange
        case "deepGreen": return .deepGreen
        case "peach":     return .peach
        case "softPink":  return .softPink
        case "softBlue":  return .softBlue
        case "yellow":    return .quibYellow
        case "purple":    return .quibPurple
        case "cream":     return .cream
        default:          return .quibYellow
        }
    }
}

// MARK: - Typography

extension Font {
    /// Chunky rounded display type used across the app.
    static func quib(_ size: CGFloat, _ weight: Font.Weight = .black) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }
}

// MARK: - Neo-brutalist card

struct NeoCard: ViewModifier {
    var fill: Color = .paper
    var radius: CGFloat = 22
    var shadow: CGFloat = 5
    var lineWidth: CGFloat = 3

    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: radius, style: .continuous)
                        .fill(Color.ink)
                        .offset(x: shadow, y: shadow)
                    RoundedRectangle(cornerRadius: radius, style: .continuous)
                        .fill(fill)
                    RoundedRectangle(cornerRadius: radius, style: .continuous)
                        .stroke(Color.ink, lineWidth: lineWidth)
                }
            )
    }
}

extension View {
    func neoCard(_ fill: Color = .paper, radius: CGFloat = 22, shadow: CGFloat = 5, lineWidth: CGFloat = 3) -> some View {
        modifier(NeoCard(fill: fill, radius: radius, shadow: shadow, lineWidth: lineWidth))
    }
}

// MARK: - Neo-brutalist button

struct NeoButtonStyle: ButtonStyle {
    var fill: Color = .quibYellow
    var textColor: Color = .ink
    var big: Bool = false
    var fullWidth: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.quib(big ? 20 : 17))
            .foregroundStyle(textColor)
            .padding(.vertical, big ? 18 : 14)
            .padding(.horizontal, big ? 30 : 24)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(
                ZStack {
                    Capsule().fill(Color.ink)
                        .offset(x: configuration.isPressed ? 0 : 4,
                                y: configuration.isPressed ? 0 : 4)
                    Capsule().fill(fill)
                    Capsule().stroke(Color.ink, lineWidth: 3)
                }
            )
            .offset(x: configuration.isPressed ? 3 : 0,
                    y: configuration.isPressed ? 3 : 0)
            .animation(.easeOut(duration: 0.08), value: configuration.isPressed)
    }
}

struct NeoIconButtonStyle: ButtonStyle {
    var fill: Color = .paper
    var size: CGFloat = 44

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.quib(17))
            .foregroundStyle(Color.ink)
            .frame(width: size, height: size)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.ink)
                        .offset(x: configuration.isPressed ? 0 : 3,
                                y: configuration.isPressed ? 0 : 3)
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(fill)
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.ink, lineWidth: 3)
                }
            )
            .offset(x: configuration.isPressed ? 2 : 0,
                    y: configuration.isPressed ? 2 : 0)
            .animation(.easeOut(duration: 0.08), value: configuration.isPressed)
    }
}

/// Press-to-squish style for whole tappable cards.
struct NeoPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .offset(y: configuration.isPressed ? 2 : 0)
            .animation(.easeOut(duration: 0.08), value: configuration.isPressed)
    }
}

// MARK: - Haptics

enum Haptics {
    static var enabled = true

    static func tap() {
        guard enabled else { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    static func success() {
        guard enabled else { return }
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }

    static func error() {
        guard enabled else { return }
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }

    static func heavy() {
        guard enabled else { return }
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
}
