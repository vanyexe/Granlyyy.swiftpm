import SwiftUI

@MainActor
struct LanguageSelectionView: View {
    @Binding var hasSelectedLanguage: Bool
    @EnvironmentObject var languageManager: LanguageManager
    @State private var animateCards = false

    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                // Title section
                VStack(spacing: 8) {
                    Image(systemName: "globe")
                        .font(.system(size: 40))
                        .foregroundStyle(Color.themeRose)
                        .shadow(color: Color.themeRose.opacity(0.4), radius: 8, y: 4)

                    Text(L10n.t(.chooseLanguage))
                        .font(.granlyTitle2)
                        .foregroundStyle(Color.themeText)
                        .multilineTextAlignment(.center)

                    Text(L10n.t(.chooseLanguageSubtitle))
                        .font(.granlySubheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }

                Spacer()

                // Language cards
                VStack(spacing: 12) {
                    ForEach(Array(AppLanguage.allCases.enumerated()), id: \.element.id) { index, language in
                        let isEnabled = language.isFullySupported
                        let isSelected = languageManager.selectedLanguage == language

                        Button(action: {
                            if isEnabled {
                                languageManager.setLanguage(language)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                        hasSelectedLanguage = true
                                    }
                                }
                            }
                        }) {
                            HStack(spacing: 14) {
                                // Language icon
                                ZStack {
                                    Circle()
                                        .fill(isEnabled ? Color.themeRose.opacity(0.15) : Color.gray.opacity(0.1))
                                        .frame(width: 32, height: 32)
                                    Image(systemName: language.icon)
                                        .font(.granlySubheadline)
                                        .foregroundStyle(isEnabled ? Color.themeRose : .secondary)
                                }

                                Text(language.displayName)
                                    .font(.granlyBodyBold)
                                    .foregroundStyle(isEnabled ? Color.themeText : .secondary)

                                Spacer()

                                if isEnabled {
                                    if isSelected {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.granlySubheadline)
                                            .foregroundStyle(Color.themeAccent)
                                    } else {
                                        Image(systemName: "circle")
                                            .font(.granlySubheadline)
                                            .foregroundStyle(.secondary.opacity(0.5))
                                    }
                                } else {
                                    Text(L10n.t(.comingSoon))
                                        .font(.system(size: 11, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 3)
                                        .background(Color.secondary.opacity(0.4))
                                        .clipShape(Capsule())
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .glassCard(cornerRadius: 16)
                            .opacity(isEnabled ? 1.0 : 0.55)
                        }
                        .disabled(!isEnabled)
                        .scaleEffect(animateCards ? 1 : 0.9)
                        .opacity(animateCards ? 1 : 0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.7).delay(Double(index) * 0.07), value: animateCards)
                    }
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        }
        .onAppear { withAnimation { animateCards = true } }
    }
}
