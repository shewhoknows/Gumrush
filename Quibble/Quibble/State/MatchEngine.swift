import Foundation
import Combine

/// Runs one 7-question duel: the 10-second clock, scoring, and the bot opponent.
///
/// Scoring per question:
/// - correct answer: 100 points
/// - speed bonus: up to +50, proportional to time left on the clock
/// - streak bonus: +25 on every correct answer once you have 3+ in a row
/// - wrong answer or timeout: 0
final class MatchEngine: ObservableObject {

    enum Phase: Equatable {
        case ready, question, feedback, finished
    }

    enum DotState {
        case pending, current, right, wrong
    }

    struct Feedback: Equatable {
        let correct: Bool
        let timedOut: Bool
        let basePoints: Int
        let speedBonus: Int
        let streakBonus: Int
        let botCorrect: Bool
        var total: Int { basePoints + speedBonus + streakBonus }
    }

    static let questionTime: Double = 10
    static let feedbackTime: Double = 1.7

    let setup: MatchSetup

    @Published private(set) var phase: Phase = .ready
    @Published private(set) var index = 0
    @Published private(set) var timeRemaining: Double = MatchEngine.questionTime
    @Published private(set) var yourScore = 0
    @Published private(set) var botScore = 0
    @Published private(set) var botHasAnswered = false
    @Published private(set) var feedback: Feedback?
    @Published private(set) var chosenIndex: Int?

    private(set) var answers: [AnswerRecord] = []

    private var streak = 0
    private var botStreak = 0
    private var botPlan: [(correct: Bool, time: Double)] = []
    private var timer: Timer?

    var currentQuestion: Question { setup.questions[index] }
    var questionCount: Int { setup.questions.count }
    var yourStreak: Int { streak }

    init(setup: MatchSetup) {
        self.setup = setup
        // The bot's whole match is rolled up front; it plays out against the clock.
        botPlan = setup.questions.map { _ in
            (correct: Double.random(in: 0...1) < setup.opponent.accuracy,
             time: Double.random(in: setup.opponent.minTime...setup.opponent.maxTime))
        }
    }

    deinit {
        timer?.invalidate()
    }

    func begin() {
        guard phase == .ready else { return }
        startQuestion()
    }

    func dotState(_ i: Int) -> DotState {
        if i < answers.count {
            return answers[i].isCorrect ? .right : .wrong
        }
        return i == index && phase != .finished ? .current : .pending
    }

    // MARK: - Question lifecycle

    private func startQuestion() {
        timeRemaining = Self.questionTime
        botHasAnswered = false
        chosenIndex = nil
        feedback = nil
        phase = .question

        timer?.invalidate()
        let t = Timer(timeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.tick()
        }
        RunLoop.main.add(t, forMode: .common)
        timer = t
    }

    private func tick() {
        guard phase == .question else { return }
        timeRemaining = max(0, timeRemaining - 0.05)

        let elapsed = Self.questionTime - timeRemaining
        if !botHasAnswered && elapsed >= botPlan[index].time {
            botHasAnswered = true
        }
        if timeRemaining <= 0 {
            choose(nil)
        }
    }

    /// Answer the current question; `nil` means the clock ran out.
    func choose(_ option: Int?) {
        guard phase == .question else { return }
        timer?.invalidate()

        let question = currentQuestion
        let timeTaken = option == nil ? Self.questionTime : Self.questionTime - timeRemaining
        let correct = option == question.correctIndex

        if correct {
            streak += 1
        } else {
            streak = 0
        }
        let base = correct ? 100 : 0
        let speedBonus = correct ? Int((timeRemaining / Self.questionTime * 50).rounded(.down)) : 0
        let streakBonus = (correct && streak >= 3) ? 25 : 0
        let points = base + speedBonus + streakBonus
        yourScore += points

        // The bot's turn for this question resolves now.
        let plan = botPlan[index]
        if plan.correct {
            botStreak += 1
        } else {
            botStreak = 0
        }
        var botPoints = 0
        if plan.correct {
            let botRemaining = max(0, Self.questionTime - plan.time)
            botPoints = 100
                + Int((botRemaining / Self.questionTime * 50).rounded(.down))
                + (botStreak >= 3 ? 25 : 0)
        }
        botScore += botPoints

        answers.append(AnswerRecord(
            questionID: question.id,
            questionText: question.text,
            options: question.options,
            correctIndex: question.correctIndex,
            chosenIndex: option,
            timeTaken: timeTaken,
            points: points,
            speedBonus: speedBonus,
            streakBonus: streakBonus,
            botCorrect: plan.correct,
            botPoints: botPoints))

        chosenIndex = option
        feedback = Feedback(correct: correct, timedOut: option == nil,
                            basePoints: base, speedBonus: speedBonus,
                            streakBonus: streakBonus, botCorrect: plan.correct)
        phase = .feedback

        if correct {
            Haptics.success()
        } else {
            Haptics.error()
        }

        let answeredIndex = index
        DispatchQueue.main.asyncAfter(deadline: .now() + Self.feedbackTime) { [weak self] in
            guard let self, self.phase == .feedback, self.index == answeredIndex else { return }
            self.advance()
        }
    }

    private func advance() {
        if index >= questionCount - 1 {
            phase = .finished
        } else {
            index += 1
            startQuestion()
        }
    }
}
