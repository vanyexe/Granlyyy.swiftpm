import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("hasSelectedLanguage") private var hasSelectedLanguage = false
    
    var body: some View {
        ZStack {
            if isActive {
                if hasSelectedLanguage {
                    if hasCompletedOnboarding {
                        HomeView()
                    } else {
                        OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
                    }
                } else {
                    LanguageSelectionView(hasSelectedLanguage: $hasSelectedLanguage)
                }
            } else {
                SplashView(isActive: $isActive)
            }
        }
        .animation(.easeInOut, value: isActive)
        .animation(.easeInOut, value: hasCompletedOnboarding)
        .animation(.easeInOut, value: hasSelectedLanguage)
    }
}





