import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    
    let slides = [
        OnboardingSlide(image: "book.fill", title: "Welcome to Granly", description: "Your virtual grandma, here to tell you stories and keep you company."),
        OnboardingSlide(image: "heart.fill", title: "Stories for You", description: "Tell Granly how you feel, and she'll pick a story just for your mood."),
        OnboardingSlide(image: "figure.2.and.child.holdinghands", title: "Always Here", description: "For those who need a grandma's warmth, Granly is always just a tap away.")
    ]
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Image Area
                Image(systemName: slides[currentPage].image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .foregroundStyle(Color.themeAccent)
                    .padding()
                    .transition(.opacity) // Simple transition
                    .id(currentPage) // Force redraw for transition
                
                // Text Area
                VStack(spacing: 16) {
                    Text(slides[currentPage].title)
                        .font(.custom("Baskerville-Bold", size: 32))
                        .foregroundStyle(Color.themeText)
                    
                    Text(slides[currentPage].description)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.themeText.opacity(0.8))
                        .padding(.horizontal, 32)
                }
                .padding(.top, 24)
                
                Spacer()
                
                // Custom Rectangular Slider
                HStack(spacing: 0) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        Rectangle()
                            .fill(currentPage == index ? Color.themeAccent : Color.gray.opacity(0.3))
                            .frame(height: 6)
                            .frame(maxWidth: .infinity)
                            .animation(.spring(), value: currentPage)
                    }
                }
                .frame(width: 200)
                .cornerRadius(3)
                .padding(.bottom, 20)
                
                // Buttons
                Button(action: {
                    withAnimation {
                        if currentPage < slides.count - 1 {
                            currentPage += 1
                        } else {
                            hasCompletedOnboarding = true
                        }
                    }
                }) {
                    Text(currentPage == slides.count - 1 ? "Get Started" : "Next")
                        .font(.headline)
                        .foregroundColor(Color.themeBackground)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.themeText)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
    }
}

struct OnboardingSlide {
    let image: String
    let title: String
    let description: String
}


