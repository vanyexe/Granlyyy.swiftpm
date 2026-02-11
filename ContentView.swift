import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        ZStack {
            if isActive {
                if hasCompletedOnboarding {
                    if isLoggedIn {
                        HomeView()
                    } else {
                        LoginView(isLoggedIn: $isLoggedIn)
                    }
                } else {
                    OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
                }
            } else {
                SplashView(isActive: $isActive)
            }
        }
        .animation(.easeInOut, value: isActive)
        .animation(.easeInOut, value: isLoggedIn)
        .animation(.easeInOut, value: hasCompletedOnboarding)
    }
}



