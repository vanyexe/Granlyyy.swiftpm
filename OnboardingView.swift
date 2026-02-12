import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    
    let slides = [
        OnboardingSlide(image: "book.closed.fill", title: "Welcome to Granly", description: "Your virtual grandma, here to tell you stories and keep you company."),
        OnboardingSlide(image: "heart.text.square.fill", title: "Stories for You", description: "Tell Granly how you feel, and she'll pick a story just for your mood."),
        OnboardingSlide(image: "sparkles", title: "Always Here", description: "For those who need a grandma's warmth, Granly is always just a tap away.")
    ]
    
    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Content Card
                VStack(spacing: 30) {
                    ZStack {
                        Circle()
                            .fill(Color.themeAccent.opacity(0.1))
                            .frame(width: 180, height: 180)
                            .blur(radius: 20)
                        
                        let icon = Image(systemName: slides[currentPage].image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(Color.themeAccent)
                        
                        if #available(iOS 17.0, *) {
                            icon.symbolEffect(.bounce, value: currentPage)
                        } else {
                            icon
                        }
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        Text(slides[currentPage].title)
                            .font(.system(size: 32, weight: .bold, design: .serif))
                            .foregroundStyle(Color.themeText)
                            .multilineTextAlignment(.center)
                        
                        Text(slides[currentPage].description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 20)
                            .lineSpacing(4)
                    }
                }
                .padding(30)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(.white.opacity(0.5), lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .move(edge: .leading).combined(with: .opacity)))
                .id(currentPage)
                
                Spacer()
                
                // Pagination & Controls
                VStack(spacing: 30) {
                    HStack(spacing: 8) {
                        ForEach(0..<slides.count, id: \.self) { index in
                            Capsule()
                                .fill(currentPage == index ? Color.themeAccent : Color.secondary.opacity(0.3))
                                .frame(width: currentPage == index ? 24 : 8, height: 8)
                                .animation(.spring(), value: currentPage)
                        }
                    }
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            if currentPage < slides.count - 1 {
                                currentPage += 1
                            } else {
                                hasCompletedOnboarding = true
                            }
                        }
                    }) {
                        Text(currentPage == slides.count - 1 ? "Get Started" : "Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.themeAccent)
                            .clipShape(Capsule())
                            .shadow(color: Color.themeAccent.opacity(0.3), radius: 15, x: 0, y: 10)
                    }
                    .padding(.horizontal, 32)
                }
                .padding(.bottom, 50)
            }
        }
    }
}


struct OnboardingSlide {
    let image: String
    let title: String
    let description: String
}


