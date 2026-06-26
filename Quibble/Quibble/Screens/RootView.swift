import SwiftUI

struct RootView: View {
    @EnvironmentObject private var app: AppState

    var body: some View {
        ZStack {
            Color.cream.ignoresSafeArea()
            if app.profile.onboarded {
                MainTabView()
            } else {
                OnboardingFlow()
            }
        }
        .fullScreenCover(item: $app.activeMatch) { setup in
            MatchFlowView(initialSetup: setup)
                .environmentObject(app)
        }
        .overlay(alignment: .bottom) {
            if let toast = app.toast {
                ToastView(message: toast)
                    .padding(.bottom, 100)
            }
        }
    }
}

// MARK: - Onboarding

struct OnboardingFlow: View {
    @State private var showTopicPicker = false

    var body: some View {
        if showTopicPicker {
            ChooseTopicsView()
        } else {
            WelcomeView { withAnimation(.spring(duration: 0.4)) { showTopicPicker = true } }
        }
    }
}

// MARK: - Main tabs

enum MainTab: String, CaseIterable {
    case home, topics, ranks, activity, profile

    var label: String {
        switch self {
        case .home:     return "Home"
        case .topics:   return "Topics"
        case .ranks:    return "Ranks"
        case .activity: return "Activity"
        case .profile:  return "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home:     return "house.fill"
        case .topics:   return "square.grid.2x2.fill"
        case .ranks:    return "trophy.fill"
        case .activity: return "clock.fill"
        case .profile:  return "person.fill"
        }
    }
}

struct MainTabView: View {
    @EnvironmentObject private var app: AppState

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch app.selectedTab {
                case .home:
                    NavigationStack { HomeView() }
                case .topics:
                    NavigationStack { AllTopicsView() }
                case .ranks:
                    NavigationStack { LeaderboardView() }
                case .activity:
                    NavigationStack { ActivityView() }
                case .profile:
                    NavigationStack { ProfileView() }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            QuibTabBar(tab: $app.selectedTab)
        }
    }
}

struct QuibTabBar: View {
    @Binding var tab: MainTab

    var body: some View {
        HStack(spacing: 4) {
            ForEach(MainTab.allCases, id: \.self) { item in
                Button {
                    Haptics.tap()
                    tab = item
                } label: {
                    VStack(spacing: 3) {
                        Image(systemName: item.icon)
                            .font(.system(size: 18, weight: .black))
                        Text(item.label)
                            .font(.quib(9, .heavy))
                    }
                    .foregroundStyle(tab == item ? Color.ink : Color(hex: 0xCFC6B8))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
                    .background(
                        Capsule().fill(tab == item ? Color.quibYellow : Color.clear)
                    )
                }
            }
        }
        .padding(7)
        .background(
            ZStack {
                Capsule().fill(Color.ink).offset(x: 4, y: 4)
                Capsule().fill(Color.ink)
                Capsule().stroke(Color.ink, lineWidth: 3)
            }
        )
        .padding(.horizontal, 18)
        .padding(.bottom, 6)
    }
}
