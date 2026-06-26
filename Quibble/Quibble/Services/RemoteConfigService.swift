import Foundation

final class RemoteConfigService {
    let supabaseConfig: SupabaseConfig?

    init(supabaseConfig: SupabaseConfig? = SupabaseConfig.load()) {
        self.supabaseConfig = supabaseConfig
    }

    var onlineMode: OnlineMode {
        supabaseConfig == nil ? .localDemo : .remote
    }
}
