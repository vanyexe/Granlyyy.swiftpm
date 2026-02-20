import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    
    let slides: [OnboardingSlide] = [
        OnboardingSlide(
            title: "Welcome to Granly",
            description: "Your cozy corner for heartwarming stories and grandma's wisdom.",
            icon: "hand.wave.fill",
            color: .themeRose
        ),
        OnboardingSlide(
            title: "Stories for Every Mood",
            description: "Feeling happy, sad, or just need a hug? Granly has a story for you.",
            icon: "book.closed.fill",
            color: .themeGold
        ),
        OnboardingSlide(
            title: "Daily Wisdom",
            description: "Start your day with gentle advice and timeless life lessons.",
            icon: "sparkles",
            color: .themeGreen
        ),
        OnboardingSlide(
            title: "Always Here For You",
            description: "A safe space to feel loved, supported, and understood.",
            icon: "heart.fill",
            color: .themeWarm
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
                                icon: slides[index].icon,
                                color: slides[index].color
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
    let icon: String
    let color: Color
}

// Reusable Animated Icon Cluster
struct AnimatedIconCluster: View {
    let icon: String
    let color: Color
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Glow background
            Circle()
                .fill(color.opacity(0.15))
                .frame(width: 200, height: 200)
                .blur(radius: 30)
                .scaleEffect(isAnimating ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isAnimating)
            
            // Main Icon Center
            Image(systemName: icon)
                .font(.system(size: 100))
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
