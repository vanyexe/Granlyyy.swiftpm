import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    @StateObject private var settings = GrandmaSettings() // Use default or saved settings
    
    // 3D State
    @State private var action: GrandmaAction = .wave
    @State private var expression: GrandmaExpression = .happy
    @State private var isSpeaking = false
    
    let slides: [OnboardingSlide] = [
        OnboardingSlide(
            title: "Welcome to Granly",
            description: "Your cozy corner for heartwarming stories and grandma's wisdom.",
            icon: "hand.wave.fill", // Fallback / Icon for text
            action: .wave,
            expression: .happy
        ),
        OnboardingSlide(
            title: "Stories for Every Mood",
            description: "Feeling happy, sad, or just need a hug? Granly has a story for you.",
            icon: "book.fill",
            action: .tellStory,
            expression: .neutral
        ),
        OnboardingSlide(
            title: "Daily Wisdom",
            description: "Start your day with gentle advice and timeless life lessons.",
            icon: "sun.max.fill",
            action: .listen, // Or think
            expression: .neutral
        ),
        OnboardingSlide(
            title: "Always Here For You",
            description: "A safe space to feel loved, supported, and understood.",
            icon: "heart.fill",
            action: .love,
            expression: .happy
        )
    ]
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Spacer()
                    Button("Skip") {
                        withAnimation { hasCompletedOnboarding = true }
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.themeText.opacity(0.6))
                    .padding(.horizontal)
                }
                .padding(.top, 20)
                
                Spacer()
                
                // 3D GRANDMA CAROUSEL
                TabView(selection: $currentPage) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        VStack(spacing: 30) {
                            // 3D Model Container
                            ZStack {
                                Circle()
                                    .fill(Color.themeRose.opacity(0.1))
                                    .frame(width: 280, height: 280)
                                    .blur(radius: 20)
                                
                                GrandmaSceneView(
                                    action: $action,
                                    expression: $expression,
                                    isSpeaking: $isSpeaking,
                                    settings: settings
                                )
                                .frame(width: 300, height: 350)
                                // Prevent interaction interruption
                                .allowsHitTesting(false) 
                            }
                            .tag(index)
                            
                            // Text Content
                            VStack(spacing: 16) {
                                Text(slides[index].title)
                                    .font(.system(size: 28, weight: .bold, design: .serif))
                                    .foregroundStyle(Color.themeText)
                                
                                Text(slides[index].description)
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(Color.themeText.opacity(0.8))
                                    .padding(.horizontal, 30)
                                    .lineSpacing(4)
                            }
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 550)
                .onChange(of: currentPage) { newValue in
                    updateGrandmaState(for: newValue)
                }
                
                Spacer()
                
                // Bottom Controls
                HStack {
                    // Page Indicator
                    HStack(spacing: 8) {
                        ForEach(0..<slides.count, id: \.self) { index in
                            Circle()
                                .fill(currentPage == index ? Color.themeRose : Color.themeRose.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .scaleEffect(currentPage == index ? 1.2 : 1.0)
                                .animation(.spring(), value: currentPage)
                        }
                    }
                    
                    Spacer()
                    
                    // Next/Done Button
                    Button(action: {
                        if currentPage < slides.count - 1 {
                            withAnimation { currentPage += 1 }
                        } else {
                            withAnimation { hasCompletedOnboarding = true }
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.themeRose)
                                .frame(width: 60, height: 60)
                                .shadow(color: Color.themeRose.opacity(0.4), radius: 10, y: 5)
                            
                            Image(systemName: currentPage == slides.count - 1 ? "checkmark" : "arrow.right")
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            updateGrandmaState(for: 0)
        }
    }
    
    private func updateGrandmaState(for index: Int) {
        let slide = slides[index]
        withAnimation {
            action = slide.action
            expression = slide.expression
        }
    }
}

struct OnboardingSlide {
    let title: String
    let description: String
    let icon: String // Keep for fallback or reference
    let action: GrandmaAction
    let expression: GrandmaExpression
}
