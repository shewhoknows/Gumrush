import Foundation

enum ScoringService {
    static let questionTime: Double = 10

    static func points(isCorrect: Bool, timeRemaining: Double, streak: Int) -> (base: Int, speed: Int, streak: Int, total: Int) {
        guard isCorrect else { return (0, 0, 0, 0) }
        let speed = Int((max(0, timeRemaining) / questionTime * 50).rounded(.down))
        let streakBonus = streak >= 3 ? 25 : 0
        let total = 100 + speed + streakBonus
        return (100, speed, streakBonus, total)
    }

    static func xp(outcome: MatchOutcome, isDaily: Bool, isPerfect: Bool) -> Int {
        var total: Int
        switch outcome {
        case .win: total = 120
        case .loss: total = 60
        case .draw: total = 90
        }
        if isDaily { total += 50 }
        if isPerfect { total += 50 }
        return total
    }
}
