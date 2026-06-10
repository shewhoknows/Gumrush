import SwiftUI

// MARK: - Blob body

struct BlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(x: rect.minX + x * w, y: rect.minY + y * h)
        }
        var p = Path()
        p.move(to: pt(0.50, 0.04))
        p.addCurve(to: pt(0.93, 0.38), control1: pt(0.72, 0.02), control2: pt(0.92, 0.16))
        p.addCurve(to: pt(0.82, 0.82), control1: pt(0.94, 0.56), control2: pt(0.95, 0.70))
        p.addCurve(to: pt(0.42, 0.96), control1: pt(0.69, 0.94), control2: pt(0.56, 1.01))
        p.addCurve(to: pt(0.06, 0.62), control1: pt(0.23, 0.91), control2: pt(0.08, 0.80))
        p.addCurve(to: pt(0.14, 0.18), control1: pt(0.04, 0.45), control2: pt(0.05, 0.28))
        p.addCurve(to: pt(0.50, 0.04), control1: pt(0.23, 0.07), control2: pt(0.36, 0.06))
        p.closeSubpath()
        return p
    }
}

// MARK: - Mascot view

struct MascotView: View {
    var state: MascotState = .neutral
    var color: Color = .quibYellow
    var size: CGFloat = 96
    var accessory: String? = nil
    var accessoryColor: Color = .paper

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack {
                BlobShape()
                    .fill(Color.ink)
                    .offset(x: size * 0.04, y: size * 0.04)
                BlobShape()
                    .fill(color)
                BlobShape()
                    .stroke(Color.ink, lineWidth: max(2.5, size * 0.034))
                MascotFace(state: state)
            }
            .frame(width: size, height: size)

            if let accessory {
                ZStack {
                    Circle().fill(Color.ink).offset(x: 2, y: 2)
                    Circle().fill(accessoryColor)
                    Circle().stroke(Color.ink, lineWidth: max(2, size * 0.028))
                    Image(systemName: accessory)
                        .font(.system(size: size * 0.16, weight: .black))
                        .foregroundStyle(Color.ink)
                }
                .frame(width: size * 0.34, height: size * 0.34)
                .offset(x: size * 0.06, y: -size * 0.04)
            }
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Face

private struct MascotFace: View {
    let state: MascotState

    var body: some View {
        Canvas { ctx, canvasSize in
            let s = min(canvasSize.width, canvasSize.height)
            let line = max(2.0, s * 0.035)
            let stroke = StrokeStyle(lineWidth: line, lineCap: .round, lineJoin: .round)

            func P(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
                CGPoint(x: x * s, y: y * s)
            }
            func ellipse(_ cx: CGFloat, _ cy: CGFloat, _ rx: CGFloat, _ ry: CGFloat) -> Path {
                Path(ellipseIn: CGRect(x: (cx - rx) * s, y: (cy - ry) * s,
                                       width: rx * 2 * s, height: ry * 2 * s))
            }
            func lineSeg(_ a: CGPoint, _ b: CGPoint) -> Path {
                var p = Path(); p.move(to: a); p.addLine(to: b); return p
            }
            func arc(_ from: CGPoint, _ to: CGPoint, _ control: CGPoint) -> Path {
                var p = Path(); p.move(to: from); p.addQuadCurve(to: to, control: control); return p
            }

            let ink = GraphicsContext.Shading.color(.ink)

            switch state {
            case .neutral:
                ctx.fill(ellipse(0.38, 0.42, 0.035, 0.05), with: ink)
                ctx.fill(ellipse(0.62, 0.42, 0.035, 0.05), with: ink)
                ctx.stroke(arc(P(0.42, 0.58), P(0.58, 0.58), P(0.50, 0.65)), with: ink, style: stroke)

            case .happy:
                ctx.stroke(arc(P(0.33, 0.44), P(0.43, 0.44), P(0.38, 0.35)), with: ink, style: stroke)
                ctx.stroke(arc(P(0.57, 0.44), P(0.67, 0.44), P(0.62, 0.35)), with: ink, style: stroke)
                var mouth = Path()
                mouth.move(to: P(0.38, 0.56))
                mouth.addQuadCurve(to: P(0.62, 0.56), control: P(0.50, 0.74))
                mouth.closeSubpath()
                ctx.fill(mouth, with: ink)

            case .thinking:
                ctx.fill(ellipse(0.40, 0.40, 0.028, 0.038), with: ink)
                ctx.fill(ellipse(0.63, 0.38, 0.028, 0.038), with: ink)
                ctx.stroke(lineSeg(P(0.33, 0.31), P(0.44, 0.29)), with: ink, style: stroke)
                ctx.stroke(lineSeg(P(0.44, 0.61), P(0.56, 0.61)), with: ink, style: stroke)
                ctx.fill(ellipse(0.76, 0.27, 0.018, 0.018), with: ink)
                ctx.fill(ellipse(0.82, 0.20, 0.014, 0.014), with: ink)

            case .surprised:
                ctx.fill(ellipse(0.38, 0.42, 0.06, 0.06), with: .color(.paper))
                ctx.stroke(ellipse(0.38, 0.42, 0.06, 0.06), with: ink, style: stroke)
                ctx.fill(ellipse(0.38, 0.42, 0.022, 0.022), with: ink)
                ctx.fill(ellipse(0.62, 0.42, 0.06, 0.06), with: .color(.paper))
                ctx.stroke(ellipse(0.62, 0.42, 0.06, 0.06), with: ink, style: stroke)
                ctx.fill(ellipse(0.62, 0.42, 0.022, 0.022), with: ink)
                ctx.fill(ellipse(0.50, 0.63, 0.045, 0.055), with: ink)

            case .competitive:
                ctx.stroke(lineSeg(P(0.30, 0.33), P(0.44, 0.38)), with: ink, style: stroke)
                ctx.stroke(lineSeg(P(0.70, 0.33), P(0.56, 0.38)), with: ink, style: stroke)
                ctx.fill(ellipse(0.39, 0.44, 0.032, 0.038), with: ink)
                ctx.fill(ellipse(0.61, 0.44, 0.032, 0.038), with: ink)
                ctx.stroke(arc(P(0.40, 0.60), P(0.62, 0.56), P(0.52, 0.66)), with: ink, style: stroke)

            case .proud:
                ctx.stroke(arc(P(0.33, 0.42), P(0.43, 0.42), P(0.38, 0.48)), with: ink, style: stroke)
                ctx.stroke(arc(P(0.57, 0.42), P(0.67, 0.42), P(0.62, 0.48)), with: ink, style: stroke)
                ctx.stroke(arc(P(0.36, 0.56), P(0.64, 0.56), P(0.50, 0.71)), with: ink, style: stroke)
                ctx.fill(ellipse(0.27, 0.53, 0.04, 0.025), with: .color(.softPink))
                ctx.fill(ellipse(0.73, 0.53, 0.04, 0.025), with: .color(.softPink))

            case .confused:
                ctx.fill(ellipse(0.38, 0.43, 0.032, 0.045), with: ink)
                ctx.fill(ellipse(0.63, 0.41, 0.05, 0.05), with: .color(.paper))
                ctx.stroke(ellipse(0.63, 0.41, 0.05, 0.05), with: ink, style: stroke)
                ctx.fill(ellipse(0.63, 0.41, 0.02, 0.02), with: ink)
                ctx.stroke(lineSeg(P(0.56, 0.30), P(0.69, 0.27)), with: ink, style: stroke)
                var squiggle = Path()
                squiggle.move(to: P(0.40, 0.61))
                squiggle.addQuadCurve(to: P(0.50, 0.61), control: P(0.45, 0.56))
                squiggle.addQuadCurve(to: P(0.60, 0.61), control: P(0.55, 0.66))
                ctx.stroke(squiggle, with: ink, style: stroke)

            case .sleepy:
                ctx.stroke(lineSeg(P(0.33, 0.43), P(0.43, 0.43)), with: ink, style: stroke)
                ctx.stroke(lineSeg(P(0.57, 0.43), P(0.67, 0.43)), with: ink, style: stroke)
                ctx.stroke(ellipse(0.50, 0.62, 0.03, 0.035), with: ink, style: stroke)
                var z1 = Path()
                z1.move(to: P(0.74, 0.16)); z1.addLine(to: P(0.84, 0.16))
                z1.addLine(to: P(0.74, 0.26)); z1.addLine(to: P(0.84, 0.26))
                ctx.stroke(z1, with: ink, style: StrokeStyle(lineWidth: line * 0.9, lineCap: .round, lineJoin: .round))
                var z2 = Path()
                z2.move(to: P(0.87, 0.05)); z2.addLine(to: P(0.94, 0.05))
                z2.addLine(to: P(0.87, 0.12)); z2.addLine(to: P(0.94, 0.12))
                ctx.stroke(z2, with: ink, style: StrokeStyle(lineWidth: line * 0.7, lineCap: .round, lineJoin: .round))

            case .excited:
                ctx.fill(ellipse(0.37, 0.41, 0.045, 0.055), with: ink)
                ctx.fill(ellipse(0.63, 0.41, 0.045, 0.055), with: ink)
                ctx.fill(ellipse(0.355, 0.395, 0.013, 0.016), with: .color(.paper))
                ctx.fill(ellipse(0.615, 0.395, 0.013, 0.016), with: .color(.paper))
                var mouth = Path()
                mouth.move(to: P(0.36, 0.54))
                mouth.addQuadCurve(to: P(0.64, 0.54), control: P(0.50, 0.78))
                mouth.closeSubpath()
                ctx.fill(mouth, with: ink)
                let sparkle = StrokeStyle(lineWidth: line * 0.8, lineCap: .round)
                ctx.stroke(lineSeg(P(0.12, 0.12), P(0.12, 0.20)), with: ink, style: sparkle)
                ctx.stroke(lineSeg(P(0.08, 0.16), P(0.16, 0.16)), with: ink, style: sparkle)
                ctx.stroke(lineSeg(P(0.88, 0.16), P(0.88, 0.24)), with: ink, style: sparkle)
                ctx.stroke(lineSeg(P(0.84, 0.20), P(0.92, 0.20)), with: ink, style: sparkle)
            }
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Idle animations

struct BobModifier: ViewModifier {
    @State private var up = false

    func body(content: Content) -> some View {
        content
            .offset(y: up ? -7 : 0)
            .rotationEffect(.degrees(up ? 2 : -2))
            .onAppear {
                withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                    up = true
                }
            }
    }
}

struct WiggleModifier: ViewModifier {
    @State private var tilt = false

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(tilt ? 5 : -5))
            .onAppear {
                withAnimation(.easeInOut(duration: 0.35).repeatForever(autoreverses: true)) {
                    tilt = true
                }
            }
    }
}

extension View {
    func mascotBob() -> some View { modifier(BobModifier()) }
    func mascotWiggle() -> some View { modifier(WiggleModifier()) }
}

// MARK: - Tiny blob avatar (player / bots / friends)

struct AvatarView: View {
    var colorName: String
    var size: CGFloat = 36
    var state: MascotState = .neutral

    var body: some View {
        ZStack {
            BlobShape().fill(Palette.color(colorName))
            BlobShape().stroke(Color.ink, lineWidth: max(2, size * 0.06))
            MascotFace(state: state)
        }
        .frame(width: size, height: size)
    }
}
