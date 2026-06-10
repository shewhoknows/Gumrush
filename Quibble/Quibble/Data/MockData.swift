import Foundation

enum MockData {

    // MARK: - Bot opponents

    static let bots: [Bot] = [
        Bot(id: "bloop", name: "Bloop", colorName: "purple", mascot: .happy,
            accuracy: 0.52, minTime: 2.5, maxTime: 8.0, tagline: "Wobbles when nervous."),
        Bot(id: "zazu", name: "Zazu", colorName: "pink", mascot: .excited,
            accuracy: 0.62, minTime: 2.0, maxTime: 7.0, tagline: "Talks big. Sometimes delivers."),
        Bot(id: "nimbus", name: "Nimbus", colorName: "softBlue", mascot: .sleepy,
            accuracy: 0.55, minTime: 3.5, maxTime: 9.0, tagline: "Slow start, strong finish."),
        Bot(id: "taco", name: "Taco", colorName: "orange", mascot: .neutral,
            accuracy: 0.48, minTime: 1.5, maxTime: 6.0, tagline: "Answers fast. Thinks later."),
        Bot(id: "fizz", name: "Fizz", colorName: "green", mascot: .competitive,
            accuracy: 0.68, minTime: 2.0, maxTime: 6.5, tagline: "All gas, no brakes."),
        Bot(id: "mango", name: "Mango", colorName: "peach", mascot: .confused,
            accuracy: 0.45, minTime: 3.0, maxTime: 9.5, tagline: "Vibes-based trivia."),
        Bot(id: "disco", name: "Disco", colorName: "softPink", mascot: .proud,
            accuracy: 0.60, minTime: 2.5, maxTime: 7.5, tagline: "Never misses a beat. Usually."),
        Bot(id: "pixel", name: "Pixel", colorName: "blue", mascot: .thinking,
            accuracy: 0.74, minTime: 2.0, maxTime: 5.5, tagline: "Runs the numbers. All of them."),
    ]

    static func randomBot() -> Bot {
        bots.randomElement() ?? bots[0]
    }

    /// The daily challenge always pits you against the same special blob.
    static let dailyBot = Bot(
        id: "quizzle", name: "Quizzle", colorName: "deepGreen", mascot: .competitive,
        accuracy: 0.65, minTime: 2.0, maxTime: 7.0,
        tagline: "Shows up every single day. Do you?")

    static func bot(for friend: Friend) -> Bot {
        Bot(id: "friend-\(friend.id)", name: friend.name, colorName: friend.colorName,
            mascot: .competitive,
            accuracy: min(0.85, 0.45 + Double(friend.level) * 0.03),
            minTime: 2.0, maxTime: 8.0,
            tagline: friend.status)
    }

    // MARK: - Friends (mock)

    static let friends: [Friend] = [
        Friend(id: "maya", name: "Maya", colorName: "softPink", level: 8, status: "Online now"),
        Friend(id: "arjun", name: "Arjun", colorName: "blue", level: 11, status: "Played 1h ago"),
        Friend(id: "tara", name: "Tara", colorName: "yellow", level: 5, status: "Online now"),
        Friend(id: "dev", name: "Dev", colorName: "green", level: 14, status: "Played 3h ago"),
        Friend(id: "zoe", name: "Zoe", colorName: "purple", level: 7, status: "Played yesterday"),
        Friend(id: "kabir", name: "Kabir", colorName: "orange", level: 9, status: "Online now"),
    ]

    // MARK: - Leaderboard (mock)

    struct LeaderboardSeed {
        let name: String
        let colorName: String
        let baseXP: Int
    }

    static let leaderboardSeeds: [LeaderboardSeed] = [
        LeaderboardSeed(name: "Pixel", colorName: "blue", baseXP: 4180),
        LeaderboardSeed(name: "Dev", colorName: "green", baseXP: 3640),
        LeaderboardSeed(name: "Fizz", colorName: "green", baseXP: 3210),
        LeaderboardSeed(name: "Arjun", colorName: "blue", baseXP: 2870),
        LeaderboardSeed(name: "Disco", colorName: "softPink", baseXP: 2350),
        LeaderboardSeed(name: "Maya", colorName: "softPink", baseXP: 1980),
        LeaderboardSeed(name: "Kabir", colorName: "orange", baseXP: 1545),
        LeaderboardSeed(name: "Zazu", colorName: "pink", baseXP: 1230),
        LeaderboardSeed(name: "Zoe", colorName: "purple", baseXP: 960),
        LeaderboardSeed(name: "Nimbus", colorName: "softBlue", baseXP: 720),
        LeaderboardSeed(name: "Tara", colorName: "yellow", baseXP: 540),
        LeaderboardSeed(name: "Bloop", colorName: "purple", baseXP: 310),
        LeaderboardSeed(name: "Mango", colorName: "peach", baseXP: 145),
    ]

    /// Mock weekly XP, seeded by the ISO week so standings shuffle every week.
    static func weeklyXP(for seed: LeaderboardSeed, weekKey: String) -> Int {
        var rng = SeededGenerator(seed: (seed.name + weekKey).stableHash)
        return Int.random(in: 60...880, using: &rng)
    }

    // MARK: - Achievements

    static let achievements: [Achievement] = [
        Achievement(id: "first_win", name: "First W", detail: "Win your first duel", symbol: "trophy.fill"),
        Achievement(id: "perfect7", name: "Perfect 7", detail: "Get all 7 questions right", symbol: "7.circle.fill"),
        Achievement(id: "wins5", name: "High Five", detail: "Win 5 duels", symbol: "hand.raised.fill"),
        Achievement(id: "wins25", name: "Serial Winner", detail: "Win 25 duels", symbol: "crown.fill"),
        Achievement(id: "matches10", name: "Regular", detail: "Play 10 duels", symbol: "gamecontroller.fill"),
        Achievement(id: "speedy", name: "Speed Demon", detail: "Win with avg answer under 4s", symbol: "bolt.fill"),
        Achievement(id: "bigbrain", name: "Big Brain", detail: "Score 900+ in one duel", symbol: "brain.head.profile"),
        Achievement(id: "explorer", name: "Explorer", detail: "Play 5 different topics", symbol: "map.fill"),
        Achievement(id: "daily1", name: "Day One", detail: "Finish your first daily challenge", symbol: "calendar"),
        Achievement(id: "streak3", name: "On a Roll", detail: "3-day daily streak", symbol: "flame.fill"),
        Achievement(id: "streak7", name: "Unstoppable", detail: "7-day daily streak", symbol: "flame.circle.fill"),
        Achievement(id: "instigator", name: "Instigator", detail: "Challenge a friend", symbol: "paperplane.fill"),
    ]

    static func achievement(_ id: String) -> Achievement? {
        achievements.first { $0.id == id }
    }

    // MARK: - Flavor copy

    static let winLines = [
        "Certified menace.", "Too easy. Run it back?", "Your brain is showing off.",
        "Blob is proud. Very proud.", "That was a masterclass.",
    ]

    static let lossLines = [
        "Rigged. Probably.", "Blob demands a rematch.", "So close it hurts.",
        "They got lucky. Prove it.", "Shake it off. Go again.",
    ]

    static let drawLines = [
        "Two big brains, one score.", "A perfectly balanced battle.", "Settle it with a rematch.",
    ]
}
