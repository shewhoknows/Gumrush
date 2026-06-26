import SwiftUI

/// Container for one full duel: matchmaking → countdown → quiz → results → review.
/// "Play again" swaps in a fresh setup; `.id` resets the whole session (and engine).
struct MatchFlowView: View {
    @EnvironmentObject private var app: AppState
    @State private var setup: MatchSetup

    init(initialSetup: MatchSetup) {
        _setup = State(initialValue: initialSetup)
    }

    var body: some View {
        MatchSessionView(
            setup: setup,
            onRematch: { setup = app.rematchSetup(from: setup) },
            onClose: { app.activeMatch = nil })
        .id(setup.id)
    }
}

// MARK: - One session

private struct MatchSessionView: View {
    @EnvironmentObject private var app: AppState

    let setup: MatchSetup
    let onRematch: () -> Void
    let onClose: () -> Void

    @StateObject private var engine: MatchEngine
    @State private var stage: Stage = .matchmaking
    @State private var summary: MatchSummary?

    enum Stage {
        case matchmaking, countdown, quiz, results, review
    }

    init(setup: MatchSetup, onRematch: @escaping () -> Void, onClose: @escaping () -> Void) {
        self.setup = setup
        self.onRematch = onRematch
        self.onClose = onClose
        _engine = StateObject(wrappedValue: MatchEngine(setup: setup))
    }

    var body: some View {
        ZStack {
            Color.cream.ignoresSafeArea()

            switch stage {
            case .matchmaking:
                MatchmakingView(setup: setup, onCancel: onClose) {
                    withAnimation(.spring(duration: 0.3)) { stage = .countdown }
                }
            case .countdown:
                CountdownView {
                    stage = .quiz
                    engine.begin()
                }
            case .quiz:
                QuizView(engine: engine, playerProfile: app.profile, onQuit: onClose)
            case .results:
                if let summary {
                    ResultsView(setup: setup,
                                summary: summary,
                                profile: app.profile,
                                onRematch: onRematch,
                                onReview: { withAnimation { stage = .review } },
                                onDone: {
                                    app.selectedTab = .home
                                    onClose()
                                })
                }
            case .review:
                ReviewAnswersView(answers: summary?.record.answers ?? [],
                                  opponentName: setup.opponent.name,
                                  onBack: { withAnimation { stage = .results } })
            }
        }
        .onChange(of: engine.phase) { _, newPhase in
            guard newPhase == .finished, summary == nil else { return }
            summary = app.recordMatch(setup: setup,
                                      answers: engine.answers,
                                      yourScore: engine.yourScore,
                                      botScore: engine.botScore)
            withAnimation(.spring(duration: 0.4)) { stage = .results }
        }
    }
}

// MARK: - Matchmaking

private struct MatchmakingView: View {
    @EnvironmentObject private var app: AppState
    let setup: MatchSetup
    let onCancel: () -> Void
    let onReady: () -> Void

    @State private var found = false
    @State private var spin = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    Haptics.tap()
                    onCancel()
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(NeoIconButtonStyle())
                Spacer()
                ChipView(text: setup.topicName, icon: "tag.fill", fill: .quibYellow)
            }
            .padding(.horizontal, 18)
            .padding(.top, 10)

            Spacer()

            if !found {
                VStack(spacing: 22) {
                    MascotView(state: .thinking, color: .quibPurple, size: 120)
                        .rotationEffect(.degrees(spin ? 360 : 0))
                        .animation(.easeInOut(duration: 1.1).repeatForever(autoreverses: false),
                                   value: spin)
                    Text("Finding a challenger…")
                        .font(.quib(22))
                        .foregroundStyle(Color.ink)
                    Text("Sniffing out someone your speed.")
                        .font(.quib(13, .bold))
                        .foregroundStyle(Color.mutedText)
                }
                .onAppear { spin = true }
            } else {
                VStack(spacing: 24) {
                    HStack(spacing: 12) {
                        PlayerSlab(name: app.profile.name,
                                   detail: "Level \(app.profile.level)",
                                   colorName: app.profile.colorName,
                                   state: .competitive)
                        Text("VS")
                            .font(.quib(22))
                            .foregroundStyle(Color.ink)
                            .frame(width: 62, height: 62)
                            .background(Circle().fill(Color.quibYellow))
                            .overlay(Circle().stroke(Color.ink, lineWidth: 3))
                        PlayerSlab(name: setup.opponent.name,
                                   detail: setup.opponent.tagline,
                                   colorName: setup.opponent.colorName,
                                   state: setup.opponent.mascot)
                    }
                    .padding(.horizontal, 20)

                    Text("Challenger found!")
                        .font(.quib(22))
                        .foregroundStyle(Color.ink)
                    ChipView(text: "7 questions · 10s each", icon: "bolt.fill", fill: .quibPink)
                }
                .transition(.scale(scale: 0.85).combined(with: .opacity))
            }

            Spacer()
            Spacer()
        }
        .task {
            try? await Task.sleep(nanoseconds: 1_700_000_000)
            guard !Task.isCancelled else { return }
            Haptics.heavy()
            withAnimation(.spring(duration: 0.35)) { found = true }
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            guard !Task.isCancelled else { return }
            onReady()
        }
    }
}

private struct PlayerSlab: View {
    let name: String
    let detail: String
    let colorName: String
    let state: MascotState

    var body: some View {
        VStack(spacing: 8) {
            MascotView(state: state, color: Palette.color(colorName), size: 76)
            Text(name)
                .font(.quib(16))
                .foregroundStyle(Color.ink)
                .lineLimit(1)
            Text(detail)
                .font(.quib(10, .bold))
                .foregroundStyle(Color.mutedText)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .padding(.horizontal, 8)
        .neoCard(.paper, radius: 22, shadow: 4)
    }
}

// MARK: - Countdown

private struct CountdownView: View {
    let onDone: () -> Void
    @State private var count = 3
    @State private var pop = false

    var body: some View {
        VStack(spacing: 26) {
            MascotView(state: .surprised, color: .quibOrange, size: 110)
            Text("\(count)")
                .font(.quib(96))
                .foregroundStyle(Color.ink)
                .scaleEffect(pop ? 1.0 : 0.4)
                .opacity(pop ? 1 : 0)
            Text("Get ready…")
                .font(.quib(16, .heavy))
                .foregroundStyle(Color.mutedText)
        }
        .task {
            for n in stride(from: 3, through: 1, by: -1) {
                count = n
                pop = false
                withAnimation(.spring(duration: 0.3, bounce: 0.5)) { pop = true }
                Haptics.tap()
                try? await Task.sleep(nanoseconds: 800_000_000)
                guard !Task.isCancelled else { return }
            }
            onDone()
        }
    }
}
