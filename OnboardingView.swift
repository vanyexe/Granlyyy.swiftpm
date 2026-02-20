import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    
    let slides: [OnboardingSlide] = [
        OnboardingSlide(
            title: "Welcome to Granly",
            description: "Your cozy corner for heartwarming stories and grandma's wisdom.",
            icons: ["hand.wave.fill", "sparkles", "heart.fill"],
            colors: [.themeRose, .yellow, .pink]
        ),
        OnboardingSlide(
            title: "Stories for Every Mood",
            description: "Feeling happy, sad, or just need a hug? Granly has a story for you.",
            icons: ["book.fill", "moon.stars.fill", "cloud.sun.fill"],
            colors: [.blue, .purple, .orange]
        ),
        OnboardingSlide(
            title: "Daily Wisdom",
            description: "Start your day with gentle advice and timeless life lessons.",
            icons: ["lightbulb.fill", "sparkles", "heart.text.square.fill"],
            colors: [.yellow, .themeGold, .themeRose]
        ),
        OnboardingSlide(
            title: "Always Here For You",
            description: "A safe space to feel loved, supported, and understood.",
            icons: ["heart.fill", "rainbow", "sparkle"],
            colors: [.red, .purple, .themeWarm]
        )
    ]
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header (Skip button)
                HStack {
                    Spacer()
                    Button("Skip") {
                        withAnimation { hasCompletedOnboarding = true }
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.themeText.opacity(0.6))
                    .padding()
                }
                
                Spacer()
                
                // Content Carousel
                TabView(selection: $currentPage) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        VStack(spacing: 40) {
                            // Animated Icons
                            AnimatedIconCluster(
                                icons: slides[index].icons,
                                colors: slides[index].colors
                            )
                            .frame(height: 250)
                            
                            // Text Content
                            VStack(spacing: 16) {
                                Text(slides[index].title)
                                    .font(.system(size: 32, weight: .bold, design: .serif))
                                    .foregroundStyle(Color.themeText)
                                    .multilineTextAlignment(.center)
                                
                                Text(slides[index].description)
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(Color.themeText.opacity(0.8))
                                    .padding(.horizontal, 32)
                                    .lineSpacing(6)
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Spacer()
                
                // Bottom Controls (Centered)
                VStack(spacing: 30) {
                    // Glossy Rectangular Page Indicators
                    HStack(spacing: 8) {
                        ForEach(0..<slides.count, id: \.self) { index in
                            Capsule()
                                .fill(currentPage == index ? Color.themeRose : Color.themeRose.opacity(0.3))
                                .frame(width: currentPage == index ? 24 : 12, height: 6)
                                .shadow(color: currentPage == index ? Color.themeRose.opacity(0.5) : Color.clear, radius: 4, y: 2)
                                .animation(.spring(response: 0.4, dampingFraction: 0.7), value: currentPage)
                        }
                    }
                    
                    // Continue/Done Button
                    Button(action: {
                        if currentPage < slides.count - 1 {
                            withAnimation { currentPage += 1 }
                        } else {
                            withAnimation(.easeInOut) { hasCompletedOnboarding = true }
                        }
                    }) {
                        Text(currentPage == slides.count - 1 ? "Get Started" : "Continue")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
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

// Model for Slide Data
struct OnboardingSlide {
    let title: String
    let description: String
    let icons: [String]
    let colors: [Color]
}

// Reusable Animated Icon Cluster
struct AnimatedIconCluster: View {
    let icons: [String]
    let colors: [Color]
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Glow background
            Circle()
                .fill(colors[0].opacity(0.15))
                .frame(width: 200, height: 200)
                .blur(radius: 30)
                .scaleEffect(isAnimating ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isAnimating)
            
            // Main Icon Center
            if icons.count > 0 {
                Image(systemName: icons[0])
                    .font(.system(size: 80))
                    .foregroundStyle(colors[0])
                    .shadow(color: colors[0].opacity(0.5), radius: 10, y: 5)
                    .offset(y: isAnimating ? -10 : 10)
                    .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: isAnimating)
            }
            
            // Secondary Icon Left
            if icons.count > 1 {
                Image(systemName: icons[1])
                    .font(.system(size: 40))
                    .foregroundStyle(colors[1])
                    .offset(x: -70, y: isAnimating ? 20 : 0)
                    .rotationEffect(.degrees(isAnimating ? -10 : 10))
                    .animation(.easeInOut(duration: 3.5).delay(0.5).repeatForever(autoreverses: true), value: isAnimating)
            }
            
            // Tertiary Icon Right
            if icons.count > 2 {
                Image(systemName: icons[2])
                    .font(.system(size: 50))
                    .foregroundStyle(colors[2])
                    .offset(x: 70, y: isAnimating ? -20 : -40)
                    .rotationEffect(.degrees(isAnimating ? 15 : -5))
                    .animation(.easeInOut(duration: 4.5).delay(1).repeatForever(autoreverses: true), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}
