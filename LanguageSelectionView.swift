import SwiftUI

struct LanguageSelectionView: View {
    @Binding var hasSelectedLanguage: Bool
    @StateObject private var languageManager = LanguageManager()
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Title
                Text("Choose Your Language")
                    .font(.custom("Baskerville-Bold", size: 32))
                    .foregroundStyle(Color.themeText)
                    .multilineTextAlignment(.center)
                
                Text("Select a language to get started with Granly.")
                    .font(.body)
                    .foregroundStyle(Color.themeText.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                // Language List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(AppLanguage.allCases) { language in
                            LanguageButton(
                                language: language,
                                isSelected: languageManager.selectedLanguage == language,
                                action: {
                                    if language == .english {
                                        languageManager.selectedLanguage = language
                                        // Slight delay to show selection
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            withAnimation {
                                                hasSelectedLanguage = true
                                            }
                                        }
                                    }
                                }
                            )
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct LanguageButton: View {
    let language: AppLanguage
    let isSelected: Bool
    let action: () -> Void
    
    // Only English is currently supported/selectable as per requirements
    var isEnabled: Bool {
        return language == .english
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(language.displayName)
                    .font(.headline)
                    .foregroundStyle(isEnabled ? Color.themeText : Color.gray)
                
                Spacer()
                
                if isEnabled {
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(Color.themeAccent)
                    } else {
                        Image(systemName: "circle")
                            .foregroundStyle(Color.themeText.opacity(0.3))
                    }
                } else {
                    Text("Coming Soon")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.5))
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
            )
            .opacity(isEnabled ? 1.0 : 0.6)
        }
        .disabled(!isEnabled)
    }
}

