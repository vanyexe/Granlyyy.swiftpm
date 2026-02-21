import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool

    @State private var avatarScale: CGFloat = 0.55
    @State private var avatarOpacity: Double = 0
    @State private var titleOffset: CGFloat = 30
    @State private var titleOpacity: Double = 0
    @State private var glowOpacity: Double = 0
    @State private var glowScale: CGFloat = 0.6
    @State private var dotOpacity: Double = 0

    var body: some View {
        ZStack {
            // ── Warm Parchment Background ──────────────────────────────
            ParchmentBackground()
                .ignoresSafeArea()

            // ── Content positioned in the upper ~50% of the screen ────
            GeometryReader { geo in
                VStack(spacing: 0) {
                    // Push content down from top to ~20% from top
                    Spacer().frame(height: geo.size.height * 0.16)

                    // ── Heart Avatar ───────────────────────────────────
                    ZStack {
                        // Soft golden radial glow behind the heart
                        RadialGradient(
                            colors: [
                                Color(red: 1.0, green: 0.90, blue: 0.55).opacity(0.70),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 10,
                            endRadius: 145
                        )
                        .frame(width: 340, height: 340)
                        .scaleEffect(glowScale)
                        .opacity(glowOpacity)

                        Image("grandma_heart")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 310, height: 310)
                            .scaleEffect(avatarScale)
                            .opacity(avatarOpacity)
                    }
                    .frame(width: 340, height: 340)

                    // ── "Granly" Script Title ──────────────────────────
                    Text("Granly")
                        .font(.custom("Snell Roundhand", size: 82))
                        .foregroundStyle(Color(red: 0.32, green: 0.14, blue: 0.05))
                        // subtle drop-shadow exactly as in the reference
                        .shadow(color: Color(red: 0.32, green: 0.14, blue: 0.05).opacity(0.22), radius: 3, x: 2, y: 3)
                        .offset(y: titleOffset)
                        .opacity(titleOpacity)
                        .padding(.top, -4)

                    // ── Everything below is empty parchment ───────────
                    Spacer()

                    // Subtle loading dots at the very bottom
                    LoadingDots()
                        .opacity(dotOpacity)
                        .padding(.bottom, 48)
                }
                .frame(width: geo.size.width)
            }
        }
        .onAppear {
            // 1. Glow up first
            withAnimation(.easeOut(duration: 0.85).delay(0.1)) {
                glowOpacity = 1
                glowScale = 1.15
            }
            // 2. Avatar springs in
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6).delay(0.2)) {
                avatarScale = 1.0
                avatarOpacity = 1
            }
            // 3. Title slides up
            withAnimation(.easeOut(duration: 0.65).delay(0.65)) {
                titleOffset = 0
                titleOpacity = 1
            }
            // 4. Loading dots fade in
            withAnimation(.easeIn(duration: 0.5).delay(1.4)) {
                dotOpacity = 1
            }
            // 5. Auto-transition
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation(.easeInOut(duration: 0.55)) {
                    isActive = true
                }
            }
        }
    }
}

// MARK: - Animated Loading Dots
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
