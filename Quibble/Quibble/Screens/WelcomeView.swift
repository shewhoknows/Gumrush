import AuthenticationServices
import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject private var app: AppState
    let onContinue: () -> Void
    @State private var authError: String?
    @State private var currentAppleNonce: String?

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            ZStack {
                MascotView(state: .happy, color: .quibPink, size: 64)
                    .offset(x: -110, y: 30)
                    .rotationEffect(.degrees(-10))
                MascotView(state: .competitive, color: .softBlue, size: 56)
                    .offset(x: 112, y: -38)
                    .rotationEffect(.degrees(12))
                MascotView(state: .excited, color: .quibYellow, size: 150)
                    .mascotBob()
            }
            .frame(height: 220)

            Text("QUIBBLE")
                .font(.quib(52))
                .foregroundStyle(Color.ink)
                .padding(.top, 18)

            Text("7 questions. Endless battles.")
                .font(.quib(17, .heavy))
                .foregroundStyle(Color.ink)
                .padding(.vertical, 10)
                .padding(.horizontal, 18)
                .neoCard(.quibPink, radius: 999, shadow: 4)
                .rotationEffect(.degrees(-2))
                .padding(.top, 6)

            Text("Pick a topic. Beat a blob.\nFeel smug. Go again.")
                .font(.quib(15, .bold))
                .foregroundStyle(Color.mutedText)
                .multilineTextAlignment(.center)
                .padding(.top, 22)

            Spacer()

            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
                let nonce = AppleSignInNonce.make()
                currentAppleNonce = nonce
                request.nonce = AppleSignInNonce.sha256(nonce)
            } onCompletion: { result in
                handleSignIn(result)
            }
            .signInWithAppleButtonStyle(.black)
            .frame(height: 54)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.ink, lineWidth: 3)
            )
            .padding(.horizontal, 26)

            Text(authError ?? "Sign in with Apple to save duels, streaks, and leaderboards.")
                .font(.quib(12, .bold))
                .foregroundStyle(authError == nil ? Color.mutedText : Color.quibRed)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.top, 14)
                .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
        .background(Color.cream.ignoresSafeArea())
    }

    private func handleSignIn(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                authError = "Apple sign-in did not return a profile."
                Haptics.error()
                return
            }
            authError = nil
            let nonce = currentAppleNonce
            currentAppleNonce = nil
            Task {
                let success = await app.signInWithApple(credential, rawNonce: nonce)
                await MainActor.run {
                    if success {
                        authError = nil
                        Haptics.success()
                        withAnimation(.spring(duration: 0.4)) {
                            onContinue()
                        }
                    } else if case .failed(let message) = app.serviceStatus {
                        authError = message
                        Haptics.error()
                    } else {
                        authError = "Apple sign-in did not finish. Try again."
                        Haptics.error()
                    }
                }
            }
        case .failure(let error):
            currentAppleNonce = nil
            guard (error as? ASAuthorizationError)?.code != .canceled else { return }
            authError = "Apple sign-in failed. Try again."
            Haptics.error()
        }
    }
}
