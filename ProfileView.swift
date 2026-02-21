import SwiftUI

struct ProfileView: View {
    @StateObject private var languageManager = LanguageManager()
    @AppStorage("grandmaName") private var grandmaName = "Granly"
    @AppStorage("userName") private var userName = "My Dear"
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("darkMode") private var darkMode = false
    @AppStorage("storiesRead") private var storiesRead = 12
    
    @State private var showLanguageSheet = false
    @State private var showOnboarding = false
    @State private var showMakeover = false // New State
    @State private var showNameEditAlert = false
    @State private var tempName = ""
    @State private var showResetAlert = false
    @State private var showRateAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) { // 24 -> 20
                        // Hero Header
                        VStack(spacing: 12) { // 16 -> 12
                            ZStack {
                                Circle()
                                    .fill(Color.themeRose.opacity(0.2))
                                    .frame(width: 100, height: 100) // 120 -> 100
                                    .blur(radius: 20)
                                
                                Image("grandma_avatar_circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80) // 100 -> 80
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.white, lineWidth: 3)) // 4 -> 3
                                    .shadow(radius: 8) // 10 -> 8
                            }
                            
                            VStack(spacing: 4) {
                                Text(userName)
                                    .font(.granlyHeadline) // Title2 -> Headline
                                    .foregroundStyle(Color.themeText)
                                Text("Stories Read: \(storiesRead)")
                                    .font(.granlySubheadline)
                                    .foregroundStyle(.secondary)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.top, 40)
                        
                        // Personal Section (New)
                        VStack(spacing: 16) {
                            SectionHeader(title: "Personal")
                            
                            // Grandma Name
                            SettingsRow(icon: "person.text.rectangle", color: .blue, title: "Grandma's Name", value: grandmaName) {
                                tempName = grandmaName
                                showNameEditAlert = true
                            }
                            
                            // Grandma Makeover Link
                            SettingsActionRow(icon: "sparkles.rectangle.stack.fill", color: .pink, title: "Grandma Makeover") {
                                showMakeover = true
                            }
                        }
                        .padding(16) // 20 -> 16
                        .glassCard(cornerRadius: 16)
                        .padding(.horizontal)
                        
                        // Settings Section
                        VStack(spacing: 16) {
                            SectionHeader(title: "Preferences")
                            
                            // Language
                            SettingsRow(icon: "globe", color: .green, title: "Language", value: languageManager.selectedLanguage.displayName) {
                                showLanguageSheet = true
                            }
                            
                            // Dark Mode
                            ToggleRow(icon: "moon.fill", color: .purple, title: "Dark Mode", isOn: $darkMode)
                            
                            // Notifications
                            ToggleRow(icon: "bell.fill", color: .orange, title: "Daily Reminders", isOn: $notificationsEnabled)
                        }
                        .padding(16) // 20 -> 16
                        .glassCard(cornerRadius: 16)
                        .padding(.horizontal)
                        
                        // Support Section
                        VStack(spacing: 16) {
                            SectionHeader(title: "Support")
                            
                            NavigationLink(destination: AboutView()) {
                                SettingsRow(icon: "info.circle", color: .blue, title: "About Granly", value: "Version 2.0") {}
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            
                            SettingsActionRow(icon: "sparkles", color: .purple, title: "View Onboarding") {
                                showOnboarding = true
                            }
                            
                            SettingsActionRow(icon: "star.fill", color: .yellow, title: "Rate Granly") {
                                showRateAlert = true
                            }
                            
                            ShareLink(item: "Check out Granly! It's the sweetest storytelling app ever.") {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                        .foregroundStyle(.pink)
                                        .frame(width: 30)
                                    Text("Share with Friends")
                                        .foregroundStyle(Color.themeText)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.granlyCaption)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .padding(16) // 20 -> 16
                        .glassCard(cornerRadius: 16)
                        .padding(.horizontal)
                        
                        // Danger Zone
                        Button(action: { showResetAlert = true }) {
                            Text("Reset All Data")
                                .font(.granlySubheadline)
                                .foregroundStyle(.red.opacity(0.8))
                                .padding()
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
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
            .alert("Rename Grandma", isPresented: $showNameEditAlert) {
                TextField("Name", text: $tempName)
                Button("Cancel", role: .cancel) { }
                Button("Save") { grandmaName = tempName }
            }
            .alert("Rate Granly", isPresented: $showRateAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Thank you for your love!")
            }
            .alert("Reset Data?", isPresented: $showResetAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    storiesRead = 0
                    grandmaName = "Granly"
                    likedStoryIDsRaw = ""
                    // Reset customization settings
                    if let bundleID = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: bundleID)
                    }
                }
            } message: {
                Text("This will clear your read history, favorite stories, and customization settings. This cannot be undone.")
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
                    .font(.system(size: 18)) // Add explicit compact icon size
                    .frame(width: 24) // 30 -> 24
                Text(title)
                    .font(.granlyBodyBold) // Make items more editorial
                    .foregroundStyle(Color.themeText)
                Spacer()
                Text(value)
                    .font(.granlySubheadline)
                    .foregroundStyle(.secondary)
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold)) // Explicit small chevron
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 6) // 8 -> 6
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
                    .font(.system(size: 18)) // Explicit compact
                    .frame(width: 24) // 30 -> 24
                Text(title)
                    .font(.granlyBodyBold)
                    .foregroundStyle(Color.themeText)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 6) // 8 -> 6
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
                .font(.system(size: 18))
                .frame(width: 24) // 30 -> 24
            Text(title)
                .font(.granlyBodyBold)
                .foregroundStyle(Color.themeText)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Color.themeRose)
        }
        .padding(.vertical, 6) // 8 -> 6
    }
}
