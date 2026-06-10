import SwiftUI

@main
struct QuibbleApp: App {
    @StateObject private var app = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(app)
                .preferredColorScheme(.light)
        }
    }
}
