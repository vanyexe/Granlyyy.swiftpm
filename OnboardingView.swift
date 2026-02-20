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
                        VStack(spacing: 24) { // Reduced from 40 for tighter layout
                            // Animated Icons
                            AnimatedIconCluster(
                                icon: slides[index].icon,
                                color: slides[index].color
                            )
                            .frame(height: 180) // Drastically reduced from 250
                            
                            // Text Content
                            VStack(spacing: 12) { // Tighter spacing
                                Text(slides[index].title)
                                    .font(.granlyTitle2) // Reduced from large Title to Title2
                                    .foregroundStyle(Color.themeText)
                                    .multilineTextAlignment(.center)
                                
                                Text(slides[index].description)
                                    .font(.granlySubheadline) // Reduced from Body to Subheadline
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(Color.themeText.opacity(0.8))
                                    .padding(.horizontal, 40) // Tighter wrap margin
                                    .lineSpacing(4) // Tighter line spacing
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Spacer()
                
                // Bottom Controls (Centered)
                VStack(spacing: 24) { // Tighter spacing from 30
                    // Glossy Rectangular Page Indicators
                    HStack(spacing: 6) { // Tighter spacing
                        ForEach(0..<slides.count, id: \.self) { index in
                            Capsule()
                                .fill(currentPage == index ? Color.themeRose : Color.themeRose.opacity(0.3))
                                .frame(width: currentPage == index ? 20 : 10, height: 5) // Slightly smaller indicators
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
                            .font(.granlyBodyBold) // Reduced from Headline to BodyBold
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50) // Reduced from 56 for sleeker button
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
                .frame(width: 140, height: 140) // Reduced from 200
                .blur(radius: 20) // Tighten blur
                .scaleEffect(isAnimating ? 1.05 : 0.95) // Smoother scale
                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isAnimating)
            
            // Main Icon Center
            Image(systemName: icon)
                .font(.system(size: 70)) // Reduced from 100
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
