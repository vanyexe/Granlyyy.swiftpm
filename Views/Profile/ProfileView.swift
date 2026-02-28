import SwiftUI

@MainActor
struct ProfileView: View {
    @EnvironmentObject var lang: LanguageManager
    @AppStorage("grandmaName") private var grandmaName = "Granly"
    @AppStorage("darkMode") private var darkMode = false
    @AppStorage("storiesRead") private var storiesRead = 12

    @State private var showLanguageSheet = false
    @State private var showOnboarding = false
    @State private var showMakeover = false
    @State private var showNameEditAlert = false
    @State private var tempName = ""
    @State private var showResetAlert = false
    @State private var showAvatarSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                MeshGradientBackground()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {

                        VStack(spacing: 16) {

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
                                HStack {
                                    Image(systemName: "book.pages.fill")
                                        .foregroundStyle(Color.themeRose)
                                    Text(L10n.tf(.storiesSavedCount, storiesRead))
                                        .font(.granlySubheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 3)
                                .background(.ultraThinMaterial)
                                .clipShape(Capsule())
                            }
                        }
                        .padding(.top, 40)

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
                        .padding(16)
                        .glassCard(cornerRadius: 16)
                        .padding(.horizontal)

                        VStack(spacing: 16) {
                            SectionHeader(title: L10n.t(.preferences))

                            SettingsRow(icon: "globe", color: .green, title: L10n.t(.language), value: lang.selectedLanguage.displayName) {
                                showLanguageSheet = true
                            }

                            ToggleRow(icon: "moon.fill", color: .purple, title: L10n.t(.darkMode), isOn: $darkMode)

                            NavigationLink(destination: NotificationsView().environmentObject(lang)) {
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .fill(Color.orange.opacity(0.15))
                                            .frame(width: 32, height: 32)
                                        Image(systemName: "bell.fill")
                                            .font(.system(size: 16))
                                            .foregroundStyle(.orange)
                                    }
                                    Text(L10n.t(.notifications))
                                        .font(.granlyBodyBold)
                                        .foregroundStyle(Color.themeText)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(.secondary)
                                }
                                .contentShape(Rectangle())
                                .padding(.vertical, 6)
                            }
                            .buttonStyle(.plain)

                        }
                        .padding(16)
                        .glassCard(cornerRadius: 16)
                        .padding(.horizontal)

                        VStack(spacing: 16) {
                            SectionHeader(title: L10n.t(.support))

                            NavigationLink(destination: AboutView().environmentObject(lang)) {
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

                            ShareLink(item: L10n.t(.shareMessage)) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up").foregroundStyle(.pink).font(.system(size: 20)).frame(width: 32)
                                    Text(L10n.t(.shareWithFriends)).font(.granlyBodyBold).foregroundStyle(Color.themeText)
                                    Spacer()
                                    Image(systemName: "chevron.right").font(.system(size: 14, weight: .semibold)).foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .padding(16)
                        .glassCard(cornerRadius: 16)
                        .padding(.horizontal)

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
            .navigationTitle(L10n.t(.profile))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showMakeover = true
                    } label: {
                        Image(systemName: "sparkles.rectangle.stack.fill")
                            .font(.title2)
                            .foregroundStyle(Color.themeRose)
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
            .sheet(isPresented: $showAvatarSheet) {
                AvatarSelectionSheet()
            }
            .alert(L10n.t(.renameGrandma), isPresented: $showNameEditAlert) {
                TextField(L10n.t(.grandmasName), text: $tempName)
                Button(L10n.t(.cancel), role: .cancel) { }
                Button(L10n.t(.save)) { grandmaName = tempName }
            }
            .alert(L10n.t(.resetDataQuestion), isPresented: $showResetAlert) {
                Button(L10n.t(.cancel), role: .cancel) { }
                Button(L10n.t(.resetDataConfirm), role: .destructive) {
                    storiesRead = 0
                    grandmaName = "Granly"
                    likedStoryIDsRaw = ""

                    if let bundleID = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: bundleID)
                    }
                }
            } message: {
                Text(L10n.t(.resetDataMessage))
            }
            .id(lang.selectedLanguage)
        }
    }

    @AppStorage("likedStoryIDs") private var likedStoryIDsRaw: String = ""
}

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