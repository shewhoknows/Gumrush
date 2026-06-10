import SwiftUI

struct WelcomeView: View {
    let onContinue: () -> Void

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

            Button {
                Haptics.heavy()
                onContinue()
            } label: {
                HStack {
                    Text("Let’s battle")
                    Image(systemName: "arrow.right")
                }
            }
            .buttonStyle(NeoButtonStyle(fill: .quibYellow, big: true, fullWidth: true))
            .padding(.horizontal, 26)

            Text("No login. No ads. Just trivia.")
                .font(.quib(12, .bold))
                .foregroundStyle(Color.mutedText)
                .padding(.top, 14)
                .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
        .background(Color.cream.ignoresSafeArea())
    }
}
