import Foundation

final class AppServices {
    let config: RemoteConfigService
    let auth: AuthService
    let matches: MatchService
    let leaderboards: LeaderboardService
    let dailyChallenge: DailyChallengeService

    init(config: RemoteConfigService = RemoteConfigService()) {
        self.config = config
        let client = config.supabaseConfig.map { SupabaseRESTClient(config: $0) }

        let localProfile = LocalProfileRepository()
        let localQuestions = LocalQuestionRepository()
        let localMatches = LocalMatchRepository()
        let localLeaderboards = LocalLeaderboardRepository()
        let localDaily = LocalDailyChallengeRepository()

        let remoteProfile = SupabaseProfileRepository(client: client)
        let remoteQuestions = SupabaseQuestionRepository(client: client)
        let remoteMatches = SupabaseMatchRepository(client: client)
        let remoteLeaderboards = SupabaseLeaderboardRepository(client: client)
        let remoteDaily = SupabaseDailyChallengeRepository(client: client)

        let selectedProfileRepository: ProfileRepositoryProtocol =
            config.supabaseConfig == nil ? localProfile : remoteProfile
        auth = AuthService(profileRepository: selectedProfileRepository, client: client)
        matches = MatchService(remoteMatches: remoteMatches,
                               localMatches: localMatches,
                               remoteQuestions: remoteQuestions,
                               localQuestions: localQuestions)
        leaderboards = LeaderboardService(remote: remoteLeaderboards, local: localLeaderboards)
        dailyChallenge = DailyChallengeService(remote: remoteDaily, local: localDaily)
    }
}
