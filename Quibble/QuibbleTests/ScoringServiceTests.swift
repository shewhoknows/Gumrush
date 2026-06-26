import XCTest
@testable import Quibble

final class ScoringServiceTests: XCTestCase {
    func testCorrectAnswerScoreIncludesSpeedBonus() {
        let points = ScoringService.points(isCorrect: true, timeRemaining: 10, streak: 1)

        XCTAssertEqual(points.base, 100)
        XCTAssertEqual(points.speed, 50)
        XCTAssertEqual(points.streak, 0)
        XCTAssertEqual(points.total, 150)
    }

    func testStreakBonusStartsAtThree() {
        let points = ScoringService.points(isCorrect: true, timeRemaining: 5, streak: 3)

        XCTAssertEqual(points.base, 100)
        XCTAssertEqual(points.speed, 25)
        XCTAssertEqual(points.streak, 25)
        XCTAssertEqual(points.total, 150)
    }

    func testWrongAnswerAndTimeoutScoreZero() {
        XCTAssertEqual(ScoringService.points(isCorrect: false, timeRemaining: 10, streak: 5).total, 0)
        XCTAssertEqual(ScoringService.points(isCorrect: false, timeRemaining: 0, streak: 0).total, 0)
    }

    func testXPCalculation() {
        XCTAssertEqual(ScoringService.xp(outcome: .win, isDaily: false, isPerfect: false), 120)
        XCTAssertEqual(ScoringService.xp(outcome: .loss, isDaily: false, isPerfect: false), 60)
        XCTAssertEqual(ScoringService.xp(outcome: .draw, isDaily: false, isPerfect: false), 90)
        XCTAssertEqual(ScoringService.xp(outcome: .win, isDaily: true, isPerfect: true), 220)
    }

    func testMissingSupabaseConfigFallsBackCleanly() {
        XCTAssertNil(SupabaseConfig.load(environment: [:]))
    }
}
