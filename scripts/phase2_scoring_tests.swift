import Foundation

@main
struct Phase2ScoringTests {
    static func main() {
        let perfectFast = ScoringService.points(isCorrect: true, timeRemaining: 10, streak: 1)
        expect(perfectFast.base == 100, "correct answer has 100 base points")
        expect(perfectFast.speed == 50, "full time remaining gives 50 speed bonus")
        expect(perfectFast.streak == 0, "streak bonus does not apply before 3")
        expect(perfectFast.total == 150, "correct + max speed totals 150")

        let streak = ScoringService.points(isCorrect: true, timeRemaining: 5, streak: 3)
        expect(streak.base == 100, "streak answer has 100 base points")
        expect(streak.speed == 25, "half time remaining gives 25 speed bonus")
        expect(streak.streak == 25, "third correct answer gets streak bonus")
        expect(streak.total == 150, "correct + half speed + streak totals 150")

        let wrong = ScoringService.points(isCorrect: false, timeRemaining: 10, streak: 5)
        expect(wrong.total == 0, "wrong answer gets zero points")

        let timeout = ScoringService.points(isCorrect: false, timeRemaining: 0, streak: 0)
        expect(timeout.total == 0, "timeout gets zero points")

        expect(ScoringService.xp(outcome: .win, isDaily: false, isPerfect: false) == 120, "win XP")
        expect(ScoringService.xp(outcome: .loss, isDaily: false, isPerfect: false) == 60, "loss XP")
        expect(ScoringService.xp(outcome: .draw, isDaily: false, isPerfect: false) == 90, "draw XP")
        expect(ScoringService.xp(outcome: .win, isDaily: true, isPerfect: true) == 220, "daily perfect win XP")

        let missingConfig = SupabaseConfig.load(environment: [:])
        expect(missingConfig == nil, "missing Supabase config returns nil")

        print("Phase 2 scoring/config checks passed.")
    }

    static func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
        if !condition() {
            FileHandle.standardError.write("FAIL: \(message)\n".data(using: .utf8)!)
            exit(1)
        }
    }
}
