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

            ParchmentBackground()
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer()

                ZStack {

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

                Text(L10n.t(.appName))
                    .font(.custom("Snell Roundhand", size: 70))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color(red: 0.35, green: 0.18, blue: 0.08))
                    .shadow(color: Color(red: 0.35, green: 0.18, blue: 0.08).opacity(0.20), radius: 8, x: 0, y: 3)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .offset(y: titleOffset)
                    .opacity(titleOpacity)

                Spacer()

                LoadingDots()
                    .opacity(dotOpacity)
                    .padding(.bottom, 50)
            }
        }
        .onAppear {

            withAnimation(.easeOut(duration: 1.2)) {
                glowOpacity = 1
                glowScale = 1.1
            }

            withAnimation(.easeOut(duration: 1.0).delay(0.2)) {
                avatarScale = 1.0
                avatarOpacity = 1
            }

            withAnimation(.easeOut(duration: 0.8).delay(0.6)) {
                titleOffset = 0
                titleOpacity = 1
            }

            withAnimation(.easeIn(duration: 0.6).delay(1.2)) {
                dotOpacity = 1
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    isActive = true
                }
            }
        }
    }
}

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

@MainActor
struct ParchmentBackground: View {
    var body: some View {
        ZStack {

            Color(red: 0.965, green: 0.915, blue: 0.835)

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