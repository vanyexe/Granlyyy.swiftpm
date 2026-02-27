import SwiftUI

@MainActor
struct ContentView: View {
    @State private var isActive = false
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("hasSelectedLanguage") private var hasSelectedLanguage = false
    
    // Inject the global language manager so changing the language forces an app-wide redraw
    @EnvironmentObject var lang: LanguageManager
    
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
        .id(lang.selectedLanguage.rawValue) // CRITICAL: Forces entire app to redraw when language changes
        .animation(.easeInOut, value: isActive)
        .animation(.easeInOut, value: hasCompletedOnboarding)
        .animation(.easeInOut, value: hasSelectedLanguage)
    }
}





