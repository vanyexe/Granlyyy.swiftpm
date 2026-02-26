import SwiftUI

@MainActor
struct SplashView: View {
    @Binding var isActive: Bool

    @State private var avatarScale: CGFloat = 0.85
    @State private var avatarOpacity: Double = 0
    @State private var titleOffset: CGFloat = 20
    @State private var titleOpacity: Double = 0
    @State private var glowOpacity: Double = 0
    @State private var glowScale: CGFloat = 0.8
    @State private var dotOpacity: Double = 0

    var body: some View {
        ZStack {
            // ── Warm Parchment Background ──────────────────────────────
            ParchmentBackground()
                .ignoresSafeArea()

            // ── Centered Content ───────────────────────────────────────
            VStack(spacing: 28) {
                Spacer()

                // ── Grandma Image with Glow ────────────────────────────
                ZStack {
                    // Soft glow behind the image
                    Circle()
                        .fill(Color(red: 1.0, green: 0.85, blue: 0.50).opacity(0.5))
                        .frame(width: 180, height: 180)
                        .blur(radius: 40)
                        .scaleEffect(glowScale)
                        .opacity(glowOpacity)

                    Image("grandma_heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210, height: 210)
                        .shadow(color: .black.opacity(0.18), radius: 20, x: 0, y: 10)
                        .scaleEffect(avatarScale)
                        .opacity(avatarOpacity)
                }

                // ── "Granly" Script Title ──────────────────────────────
                Text("Granly")
                    .font(.custom("Snell Roundhand", size: 62))
                    .foregroundStyle(Color(red: 0.35, green: 0.18, blue: 0.08))
                    .shadow(color: Color(red: 0.35, green: 0.18, blue: 0.08).opacity(0.20), radius: 4, x: 0, y: 3)
                    .offset(y: titleOffset)
                    .opacity(titleOpacity)

                Spacer()

                // ── Subtle Loading Dots ────────────────────────────────
                LoadingDots()
                    .opacity(dotOpacity)
                    .padding(.bottom, 50)
            }
        }
        .onAppear {
            // 1. Glow up first
            withAnimation(.easeOut(duration: 1.2)) {
                glowOpacity = 1
                glowScale = 1.1
            }
            // 2. Avatar fades & scales in softly
            withAnimation(.easeOut(duration: 1.0).delay(0.2)) {
                avatarScale = 1.0
                avatarOpacity = 1
            }
            // 3. Title slides up and fades in
            withAnimation(.easeOut(duration: 0.8).delay(0.6)) {
                titleOffset = 0
                titleOpacity = 1
            }
            // 4. Loading dots fade in gracefully
            withAnimation(.easeIn(duration: 0.6).delay(1.2)) {
                dotOpacity = 1
            }
            // 5. Auto-transition to next screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    isActive = true
                }
            }
        }
    }
}

// MARK: - Animated Loading Dots
@MainActor
struct LoadingDots: View {
    @State private var animate = false

    var body: some View {
        HStack(spacing: 7) {
            ForEach(0..<3) { i in
                Circle()
                    .fill(Color(red: 0.55, green: 0.30, blue: 0.12).opacity(0.55))
                    .frame(width: 7, height: 7)
                    .scaleEffect(animate ? 1.0 : 0.5)
                    .animation(
                        .easeInOut(duration: 0.55)
                        .repeatForever()
                        .delay(Double(i) * 0.18),
                        value: animate
                    )
            }
        }
        .onAppear { animate = true }
    }
}

// MARK: - Parchment / Paper Texture Background
@MainActor
struct ParchmentBackground: View {
    var body: some View {
        ZStack {
            // Base warm cream
            Color(red: 0.965, green: 0.915, blue: 0.835)

            // Subtle noise grain overlay
            Canvas { ctx, size in
                for _ in 0..<7000 {
                    let x = CGFloat.random(in: 0..<size.width)
                    let y = CGFloat.random(in: 0..<size.height)
                    let alpha = CGFloat.random(in: 0.008...0.038)
                    ctx.fill(
                        Path(ellipseIn: CGRect(x: x, y: y, width: 1.5, height: 1.5)),
                        with: .color(Color(white: 0.40, opacity: alpha))
                    )
                }
            }
            .blendMode(.multiply)

            // Edge vignette
            RadialGradient(
                colors: [
                    Color.clear,
                    Color(red: 0.68, green: 0.52, blue: 0.36).opacity(0.20)
                ],
                center: .center,
                startRadius: UIScreen.main.bounds.height * 0.28,
                endRadius: UIScreen.main.bounds.height * 0.70
            )
        }
    }
}
