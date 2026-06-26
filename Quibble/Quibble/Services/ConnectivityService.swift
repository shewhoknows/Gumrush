import Foundation

final class ConnectivityService {
    var isBackendConfigured: Bool {
        SupabaseConfig.load() != nil
    }
}
