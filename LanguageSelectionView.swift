import SwiftUI

struct LanguageSelectionView: View {
    @Binding var hasSelectedLanguage: Bool
    @StateObject private var languageManager = LanguageManager()
    @State private var animateCards = false
    
    let flagEmojis: [AppLanguage: String] = [
        .english: "🇺🇸",
        .spanish: "🇪🇸",
        .french: "🇫🇷",
        .german: "🇩🇪",
        .hindi: "🇮🇳"
    ]
    
    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 28) {
                Spacer()
                
                // Title
                VStack(spacing: 12) {
                    Text("🌍")
                        .font(.system(size: 50))
                    
                    Text("Choose Your Language")
                        .font(.system(size: 30, weight: .bold, design: .serif))
                        .foregroundStyle(Color.themeText)
                        .multilineTextAlignment(.center)
                    
                    Text("Select a language to begin your journey with Granly")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
                
                // Language Cards
                VStack(spacing: 12) {
                    ForEach(Array(AppLanguage.allCases.enumerated()), id: \.element.id) { index, language in
                        let isEnabled = language == .english
                        
                        Button(action: {
                            if isEnabled {
                                languageManager.selectedLanguage = language
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                        hasSelectedLanguage = true
                                    }
                                }
                            }
                        }) {
                            HStack(spacing: 14) {
                                // Flag
                                Text(flagEmojis[language] ?? "🏳️")
                                    .font(.title2)
                                
                                Text(language.displayName)
                                    .font(.headline)
                                    .foregroundStyle(isEnabled ? Color.themeText : .secondary)
                                
                                Spacer()
                                
                                if isEnabled {
                                    if languageManager.selectedLanguage == language {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.title3)
                                            .foregroundStyle(Color.themeAccent)
                                    } else {
                                        Image(systemName: "circle")
                                            .font(.title3)
                                            .foregroundStyle(.secondary.opacity(0.5))
                                    }
                                } else {
                                    Text("Coming Soon")
                                        .font(.caption.bold())
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Color.secondary.opacity(0.4))
                                        .clipShape(Capsule())
                                }
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 14)
                            .glassCard(cornerRadius: 18)
                            .opacity(isEnabled ? 1.0 : 0.55)
                        }
                        .disabled(!isEnabled)
                        .scaleEffect(animateCards ? 1 : 0.9)
                        .opacity(animateCards ? 1 : 0)
                        .animation(
                            .spring(response: 0.5, dampingFraction: 0.7).delay(Double(index) * 0.08),
                            value: animateCards
                        )
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
        .onAppear {
            withAnimation {
                animateCards = true
            }
        }
    }
}
