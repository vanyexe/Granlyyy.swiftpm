import SwiftUI

@MainActor
struct ProfileView: View {
    @StateObject private var languageManager = LanguageManager.shared
    @EnvironmentObject var lang: LanguageManager
    @AppStorage("grandmaName") private var grandmaName = "Granly"
    @AppStorage("darkMode") private var darkMode = false
    @AppStorage("storiesRead") private var storiesRead = 12
    
    @State private var showLanguageSheet = false
    @State private var showOnboarding = false
    @State private var showMakeover = false // New State
    @State private var showNameEditAlert = false
    @State private var tempName = ""
    @State private var showResetAlert = false
    @State private var showRateAlert = false
    @State private var showAvatarSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                MeshGradientBackground()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) { // 24 -> 20
                        // Hero Header
                        VStack(spacing: 16) { 
                            // Profile Picture
                            Button(action: { showAvatarSheet = true }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.themeRose.opacity(0.08))
                                        .frame(width: 100, height: 100)
                                        .blur(radius: 16)

                                    ProfileAvatarView(size: 110)
                                .shadow(color: .black.opacity(0.15), radius: 10, y: 4)

                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundStyle(.white)
                                        .padding(5)
                                        .background(Color.themeRose)
                                        .clipShape(Circle())
                                        .offset(x: 26, y: 26)
                                }
                            }
                            .buttonStyle(.plain)
                            
                            VStack(spacing: 6) {
                                Text(L10n.t(.myDear))
                                    .font(.granlyHeadline)
                                    .foregroundStyle(Color.themeText)

                                Text("\(L10n.t(.storiesRead)): \(storiesRead)")
                                    .font(.granlySubheadline)
                                    .foregroundStyle(.secondary)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 3)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.top, 40)
                        
                        // Personal Section (New)
                        VStack(spacing: 16) {
                            SectionHeader(title: L10n.t(.personal))
                            
                            SettingsRow(icon: "person.text.rectangle", color: .blue, title: L10n.t(.grandmasName), value: grandmaName) {
                                tempName = grandmaName
                                showNameEditAlert = true
                            }
                            
                            SettingsActionRow(icon: "sparkles.rectangle.stack.fill", color: .pink, title: L10n.t(.grandmaMakeover)) {
                                showMakeover = true
                            }
                        }
                        .padding(16) // 20 -> 16
                        .glassCard(cornerRadius: 16)
                        .padding(.horizontal)
                        
                        // Settings Section
                        VStack(spacing: 16) {
                            SectionHeader(title: L10n.t(.preferences))
                            
                            SettingsRow(icon: "globe", color: .green, title: L10n.t(.language), value: languageManager.selectedLanguage.displayName) {
                                showLanguageSheet = true
                            }
                            
                            ToggleRow(icon: "moon.fill", color: .purple, title: L10n.t(.darkMode), isOn: $darkMode)
                            

                        }
                        .padding(16) // 20 -> 16
                        .glassCard(cornerRadius: 16)
                        .padding(.horizontal)
                        
                        // Support Section
                        VStack(spacing: 16) {
                            SectionHeader(title: L10n.t(.support))
                            
                            NavigationLink(destination: AboutView()) {
                                HStack {
                                    Image(systemName: "info.circle").foregroundStyle(.blue).font(.system(size: 20)).frame(width: 28)
                                    Text(L10n.t(.aboutGrantly)).font(.granlyBodyBold).foregroundStyle(Color.themeText)
                                    Spacer()
                                    Image(systemName: "chevron.right").font(.system(size: 14, weight: .semibold)).foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 6).contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            
                            SettingsActionRow(icon: "sparkles", color: .purple, title: L10n.t(.viewOnboarding)) { showOnboarding = true }
                            SettingsActionRow(icon: "star.fill", color: .yellow, title: L10n.t(.rateGrantly)) { showRateAlert = true }
                            
                            ShareLink(item: "Check out Granly! It's the sweetest storytelling app ever.") {
                                HStack {
                                    Image(systemName: "square.and.arrow.up").foregroundStyle(.pink).font(.system(size: 20)).frame(width: 32)
                                    Text(L10n.t(.shareWithFriends)).font(.granlyBodyBold).foregroundStyle(Color.themeText)
                                    Spacer()
                                    Image(systemName: "chevron.right").font(.system(size: 14, weight: .semibold)).foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .padding(16) // 20 -> 16
                        .glassCard(cornerRadius: 16)
                        .padding(.horizontal)
                        
                        // Danger Zone
                        Button(action: { showResetAlert = true }) {
                            Text(L10n.t(.resetAllData))
                                .font(.granlySubheadline)
                                .foregroundStyle(.red.opacity(0.8))
                                .padding()
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showMakeover) {
                CustomizeGrandmaView()
            }
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingView(hasCompletedOnboarding: Binding(
                    get: { !showOnboarding }, 
                    set: { if $0 { showOnboarding = false } }
                ))
            }
            .sheet(isPresented: $showLanguageSheet) {
                LanguageSelectionView(hasSelectedLanguage: .constant(true))
            }
            .sheet(isPresented: $showAvatarSheet) {
                AvatarSelectionSheet()
            }
            .alert(L10n.t(.renameGrandma), isPresented: $showNameEditAlert) {
                TextField(L10n.t(.grandmasName), text: $tempName)
                Button(L10n.t(.cancel), role: .cancel) { }
                Button(L10n.t(.save)) { grandmaName = tempName }
            }
            .alert(L10n.t(.rateMessage), isPresented: $showRateAlert) {
                Button(L10n.t(.ok), role: .cancel) { }
            } message: {
                Text(L10n.t(.thankYouForLove))
            }
            .alert(L10n.t(.resetDataQuestion), isPresented: $showResetAlert) {
                Button(L10n.t(.cancel), role: .cancel) { }
                Button(L10n.t(.resetDataConfirm), role: .destructive) {
                    storiesRead = 0
                    grandmaName = "Granly"
                    likedStoryIDsRaw = ""
                    // Reset customization settings
                    if let bundleID = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: bundleID)
                    }
                }
            } message: {
                Text(L10n.t(.resetDataMessage))
            }
        }
    }
    
    // Helper property to access private var
    @AppStorage("likedStoryIDs") private var likedStoryIDsRaw: String = ""
}

// MARK: - Components (Reused)
struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title.uppercased())
            .font(.granlyCaption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SettingsRow: View {
    let icon: String
    let color: Color
    let title: String
    let value: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)
                    .font(.system(size: 24))
                    .frame(width: 32)
                Text(title)
                    .font(.granlyBodyBold)
                    .foregroundStyle(Color.themeText)
                Spacer()
                Text(value)
                    .font(.granlySubheadline)
                    .foregroundStyle(.secondary)
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 10)
        }
    }
}

struct SettingsActionRow: View {
    let icon: String
    let color: Color
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)
                    .font(.system(size: 24))
                    .frame(width: 32)
                Text(title)
                    .font(.granlyBodyBold)
                    .foregroundStyle(Color.themeText)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 10)
        }
    }
}

struct ToggleRow: View {
    let icon: String
    let color: Color
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                    .foregroundStyle(color)
                    .font(.system(size: 20))
                    .frame(width: 28)
                Text(title)
                    .font(.granlyBodyBold)
                    .foregroundStyle(Color.themeText)
                Spacer()
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .tint(Color.themeRose)
        }
        .padding(.vertical, 6)
    }
}
