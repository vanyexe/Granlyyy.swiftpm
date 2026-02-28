import SwiftUI

@MainActor
struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @EnvironmentObject var lang: LanguageManager
    @State private var currentPage = 0

    var slides: [OnboardingSlide] {
        [
            OnboardingSlide(title: L10n.t(.onboarding1Title), description: L10n.t(.onboarding1Description), icon: "hand.wave.fill", color: .themeRose),
            OnboardingSlide(title: L10n.t(.onboarding2Title), description: L10n.t(.onboarding2Description), icon: "book.closed.fill", color: .themeGold),
            OnboardingSlide(title: L10n.t(.onboarding3Title), description: L10n.t(.onboarding3Description), icon: "sparkles", color: .themeGreen),
            OnboardingSlide(title: L10n.t(.onboarding4Title), description: L10n.t(.onboarding4Description), icon: "heart.fill", color: .themeWarm)
        ]
    }

    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()

            VStack(spacing: 0) {

                HStack {
                    Spacer()
                    Button(L10n.t(.skip)) {
                        withAnimation { hasCompletedOnboarding = true }
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.themeText.opacity(0.6))
                    .padding()
                }

                Spacer()

                TabView(selection: $currentPage) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        VStack(spacing: 24) {

                            AnimatedIconCluster(
                                icon: slides[index].icon,
                                color: slides[index].color
                            )
                            .frame(height: 180)

                            VStack(spacing: 12) {
                                Text(slides[index].title)
                                    .font(.granlyTitle2)
                                    .foregroundStyle(Color.themeText)
                                    .multilineTextAlignment(.center)

                                Text(slides[index].description)
                                    .font(.granlySubheadline)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(Color.themeText.opacity(0.8))
                                    .padding(.horizontal, 40)
                                    .lineSpacing(4)
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                Spacer()

                VStack(spacing: 24) {

                    HStack(spacing: 6) {
                        ForEach(0..<slides.count, id: \.self) { index in
                            Capsule()
                                .fill(currentPage == index ? Color.themeRose : Color.themeRose.opacity(0.3))
                                .frame(width: currentPage == index ? 20 : 10, height: 5)
                                .shadow(color: currentPage == index ? Color.themeRose.opacity(0.5) : Color.clear, radius: 4, y: 2)
                                .animation(.spring(response: 0.4, dampingFraction: 0.7), value: currentPage)
                        }
                    }

                    Button(action: {
                        if currentPage < slides.count - 1 {
                            withAnimation { currentPage += 1 }
                        } else {
                            withAnimation(.easeInOut) { hasCompletedOnboarding = true }
                        }
                    }) {
                        Text(currentPage == slides.count - 1 ? L10n.t(.getStarted) : L10n.t(.continueAction))
                            .font(.granlyBodyBold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                LinearGradient(colors: [Color.themeRose, Color.themeWarm], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .clipShape(Capsule())
                            .shadow(color: Color.themeRose.opacity(0.4), radius: 10, y: 5)
                            .padding(.horizontal, 40)
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

struct OnboardingSlide {
    let title: String
    let description: String
    let icon: String
    let color: Color
}

struct AnimatedIconCluster: View {
    let icon: String
    let color: Color

    @State private var isAnimating = false

    var body: some View {
        ZStack {

            Circle()
                .fill(color.opacity(0.15))
                .frame(width: 140, height: 140)
                .blur(radius: 20)
                .scaleEffect(isAnimating ? 1.05 : 0.95)
                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isAnimating)

            Image(systemName: icon)
                .font(.system(size: 70))
                .foregroundStyle(color)
                .shadow(color: color.opacity(0.5), radius: 10, y: 5)
                .offset(y: isAnimating ? -10 : 10)
                .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: isAnimating)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}