import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool

    @State private var avatarScale: CGFloat = 0.55
    @State private var avatarOpacity: Double = 0
    @State private var titleOffset: CGFloat = 30
    @State private var titleOpacity: Double = 0
    @State private var sparkleOpacity: Double = 0
    @State private var sparkleScale: CGFloat = 0.6

    var body: some View {
        ZStack {
            // ── Warm Parchment Background ──────────────────────────────
            ParchmentBackground()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer(minLength: 0)
                    .frame(maxHeight: .infinity, alignment: .center)

                // ── Heart Avatar ───────────────────────────────────────
                ZStack {
                    // Soft golden glow under avatar
                    RadialGradient(
                        colors: [
                            Color(red: 1.0, green: 0.88, blue: 0.5).opacity(0.55),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 20,
                        endRadius: 130
                    )
                    .frame(width: 260, height: 260)
                    .scaleEffect(sparkleScale)
                    .opacity(sparkleOpacity)

                    // Grandma in heart frame image
                    Image("grandma_heart")
                        .resizable()
                        .interpolation(.high)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 280, height: 280)
                        .scaleEffect(avatarScale)
                        .opacity(avatarOpacity)
                }

                // ── "Granly" Script Title ──────────────────────────────
                Text("Granly")
                    .font(.custom("Snell Roundhand", size: 80))
                    .foregroundStyle(Color(red: 0.32, green: 0.14, blue: 0.05))
                    .shadow(color: Color(red: 0.32, green: 0.14, blue: 0.05).opacity(0.18), radius: 4, x: 2, y: 3)
                    .offset(y: titleOffset)
                    .opacity(titleOpacity)
                    .padding(.top, -12)

                Spacer(minLength: 0)
                    .frame(maxHeight: .infinity)
            }
        }
        .onAppear {
            // Sparkle glow pulses in
            withAnimation(.easeOut(duration: 0.9).delay(0.1)) {
                sparkleOpacity = 1
                sparkleScale = 1.15
            }

            // Avatar pops in with spring
            withAnimation(.spring(response: 0.65, dampingFraction: 0.62).delay(0.15)) {
                avatarScale = 1.0
                avatarOpacity = 1
            }

            // Title slides up
            withAnimation(.easeOut(duration: 0.7).delay(0.6)) {
                titleOffset = 0
                titleOpacity = 1
            }

            // Auto-dismiss after 3.2 s
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                withAnimation(.easeInOut(duration: 0.55)) {
                    isActive = true
                }
            }
        }
    }
}

// MARK: - Parchment / Paper Texture Background
struct ParchmentBackground: View {
    var body: some View {
        ZStack {
            // Base warm cream
            Color(red: 0.96, green: 0.91, blue: 0.82)

            // Subtle noise overlay using Canvas
            Canvas { ctx, size in
                for _ in 0..<6000 {
                    let x = CGFloat.random(in: 0..<size.width)
                    let y = CGFloat.random(in: 0..<size.height)
                    let alpha = CGFloat.random(in: 0.01...0.045)
                    ctx.fill(
                        Path(ellipseIn: CGRect(x: x, y: y, width: 1.4, height: 1.4)),
                        with: .color(Color(white: 0.45, opacity: alpha))
                    )
                }
            }
            .blendMode(.multiply)

            // Subtle vignette at edges
            RadialGradient(
                colors: [Color.clear, Color(red: 0.72, green: 0.58, blue: 0.40).opacity(0.22)],
                center: .center,
                startRadius: UIScreen.main.bounds.height * 0.3,
                endRadius: UIScreen.main.bounds.height * 0.72
            )
        }
    }
}
