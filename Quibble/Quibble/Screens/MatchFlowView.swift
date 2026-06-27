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
    @StateObject private var liveSession = LiveDuelSession()
    @State private var stage: Stage = .matchmaking
    @State private var summary: MatchSummary?
    @State private var liveFinishPending = false
    @State private var sentAnswerCount = 0

    enum Stage {
        case matchmaking, countdown, quiz, waitingLiveResult, results, review
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
                MatchmakingView(setup: setup, liveSession: liveSession, onCancel: onClose) {
                    withAnimation(.spring(duration: 0.3)) { stage = .countdown }
                }
            case .countdown:
                CountdownView {
                    if setup.isLive {
                        liveSession.sendStart()
                    }
                    stage = .quiz
                    engine.begin()
                }
            case .quiz:
                QuizView(engine: engine, playerProfile: app.profile, onQuit: onClose)
            case .waitingLiveResult:
                WaitingForLiveResultView(setup: setup,
                                         yourScore: engine.yourScore,
                                         opponentScore: engine.botScore,
                                         onLeave: onClose)
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
            if newPhase == .feedback, setup.isLive, engine.answers.count > sentAnswerCount,
               let answer = engine.answers.last {
                sentAnswerCount = engine.answers.count
                liveSession.sendAnswer(answer, questionIndex: engine.answers.count - 1, score: engine.yourScore)
            }
            guard newPhase == .finished, summary == nil else { return }
            if setup.isLive {
                liveSession.sendFinish(score: engine.yourScore,
                                       correctCount: engine.answers.filter(\.isCorrect).count)
                if !liveSession.opponentFinished {
                    liveFinishPending = true
                    withAnimation(.spring(duration: 0.35)) { stage = .waitingLiveResult }
                    return
                }
            }
            finishMatch()
        }
        .onChange(of: liveSession.answerEventCount) { _, _ in
            guard let event = liveSession.lastAnswer else { return }
            engine.applyRemoteAnswer(questionID: event.questionID, points: event.points, score: event.score)
        }
        .onChange(of: liveSession.opponentFinished) { _, finished in
            guard setup.isLive, finished else { return }
            engine.applyRemoteFinish(score: liveSession.opponentScore)
            if liveFinishPending, summary == nil {
                finishMatch()
            }
        }
        .task {
            app.connectLiveSession(liveSession, setup: setup)
        }
        .onDisappear {
            if setup.isLive {
                liveSession.disconnect()
            }
        }
    }

    private func finishMatch() {
        liveFinishPending = false
        summary = app.recordMatch(setup: setup,
                                  answers: engine.answers,
                                  yourScore: engine.yourScore,
                                  botScore: setup.isLive ? liveSession.opponentScore : engine.botScore)
        withAnimation(.spring(duration: 0.4)) { stage = .results }
    }
}

private struct WaitingForLiveResultView: View {
    let setup: MatchSetup
    let yourScore: Int
    let opponentScore: Int
    let onLeave: () -> Void

    var body: some View {
        VStack(spacing: 22) {
            HStack {
                Button {
                    Haptics.tap()
                    onLeave()
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(NeoIconButtonStyle())
                Spacer()
                ChipView(text: setup.topicName, icon: "bolt.fill", fill: .quibYellow)
            }
            .padding(.horizontal, 18)
            .padding(.top, 10)

            Spacer()

            MascotView(state: .thinking, color: .quibPurple, size: 118)
                .mascotBob()
            Text("Waiting on your rival…")
                .font(.quib(24))
                .foregroundStyle(Color.ink)
            Text("\(yourScore) — \(opponentScore)")
                .font(.quib(34))
                .foregroundStyle(Color.ink)
                .monospacedDigit()
                .padding(.vertical, 18)
                .frame(maxWidth: .infinity)
                .neoCard(.paper, radius: 24, shadow: 5)
                .padding(.horizontal, 34)
            Text("They’re still answering. Results unlock when both rounds finish.")
                .font(.quib(13, .bold))
                .foregroundStyle(Color.mutedText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()
            Spacer()
        }
    }
}

// MARK: - Matchmaking

private struct MatchmakingView: View {
    @EnvironmentObject private var app: AppState
    let setup: MatchSetup
    @ObservedObject var liveSession: LiveDuelSession
    let onCancel: () -> Void
    let onReady: () -> Void

    @State private var found = false
    @State private var spin = false
    @State private var readyFired = false

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
                    Text(setup.isLive ? "Opening a live room…" : "Finding a challenger…")
                        .font(.quib(22))
                        .foregroundStyle(Color.ink)
                    Text(statusLine)
                        .font(.quib(13, .bold))
                        .foregroundStyle(Color.mutedText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 34)
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

                    Text(setup.isLive ? "Live challenger found!" : "Challenger found!")
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
            guard !setup.isLive else { return }
            try? await Task.sleep(nanoseconds: 1_700_000_000)
            guard !Task.isCancelled else { return }
            markFoundAndReady()
        }
        .onChange(of: liveSession.opponentReady) { _, ready in
            guard setup.isLive, ready else { return }
            markFoundAndReady()
        }
        .onChange(of: liveSession.startSignal) { _, started in
            guard setup.isLive, started else { return }
            markFoundAndReady()
        }
    }

    private var statusLine: String {
        guard setup.isLive else { return "Sniffing out someone your speed." }
        switch liveSession.connectionState {
        case .idle, .connecting:
            return "Connecting to the live duel table."
        case .connected:
            return liveSession.opponentReady
                ? "Both blobs are ready."
                : "Waiting for another player to join this topic."
        case .disconnected:
            return "The room dropped. You can back out and try again."
        case .failed(let message):
            return message
        }
    }

    private func markFoundAndReady() {
        guard !readyFired else { return }
        readyFired = true
        Haptics.heavy()
        withAnimation(.spring(duration: 0.35)) { found = true }
        Task {
            try? await Task.sleep(nanoseconds: 1_300_000_000)
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
