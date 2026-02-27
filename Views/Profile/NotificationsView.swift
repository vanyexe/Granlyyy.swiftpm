import SwiftUI
import UserNotifications

// MARK: - NotificationsView
struct NotificationsView: View {

    @StateObject private var nm = NotificationManager.shared
    @EnvironmentObject var lang: LanguageManager

    // Local time-picker state
    @State private var storyTime:    Date = NotificationsView.savedTime("story",    defaultHour: 20)
    @State private var activityTime: Date = NotificationsView.savedTime("activity", defaultHour: 8)

    @State private var showPermAlert = false

    var body: some View {
        ZStack {
            MeshGradientBackground().ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {

                    // ── Permission banner ────────────────────────────────────
                    if nm.authStatus == .denied {
                        permissionBanner
                    } else if nm.authStatus == .notDetermined {
                        requestPermissionBanner
                    }

                    // ── Story Reminder ────────────────────────────────────────
                    reminderCard(
                        icon: "book.fill",
                        iconColor: Color.themeRose,
                        title: L10n.t(.storyReminder),
                        subtitle: L10n.t(.notifStorySubtitle),
                        isOn: $nm.storyEnabled,
                        time: $storyTime,
                        previewTitle: L10n.t(.notifStoryTitle),
                        previewBody:  L10n.t(.notifStoryBody)
                    )
                    .onChange(of: nm.storyEnabled) { _ in handleToggle() }
                    .onChange(of: storyTime) { _ in
                        let c = Calendar.current.dateComponents([.hour, .minute], from: storyTime)
                        nm.storyHour   = c.hour   ?? 20
                        nm.storyMinute = c.minute  ?? 0
                        if nm.storyEnabled { nm.scheduleStoryReminder() }
                    }

                    // ── Activity Reminder ─────────────────────────────────────
                    reminderCard(
                        icon: "heart.fill",
                        iconColor: .orange,
                        title: L10n.t(.activityReminder),
                        subtitle: L10n.t(.notifActivitySubtitle),
                        isOn: $nm.activityEnabled,
                        time: $activityTime,
                        previewTitle: L10n.t(.notifActivityTitle),
                        previewBody:  L10n.t(.notifActivityBody)
                    )
                    .onChange(of: nm.activityEnabled) { _ in handleToggle() }
                    .onChange(of: activityTime) { _ in
                        let c = Calendar.current.dateComponents([.hour, .minute], from: activityTime)
                        nm.activityHour   = c.hour   ?? 8
                        nm.activityMinute = c.minute  ?? 0
                        if nm.activityEnabled { nm.scheduleActivityReminder() }
                    }

                    // ── Progress Updates ──────────────────────────────────────
                    progressCard

                    // ── Empty state ───────────────────────────────────────────
                    if !nm.storyEnabled && !nm.activityEnabled && !nm.streakEnabled {
                        emptyState
                    }

                    Spacer().frame(height: 60)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
            }
        }
        .navigationTitle(L10n.t(.notifications))
        .navigationBarTitleDisplayMode(.inline)
        .task { await nm.refreshStatus() }
    }

    // MARK: Permission banners
    private var requestPermissionBanner: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                Image(systemName: "bell.badge.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.themeRose)
                VStack(alignment: .leading, spacing: 2) {
                    Text(L10n.t(.notifPermissionTitle))
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                    Text(L10n.t(.notifPermissionBody))
                        .font(.granlyBody)
                        .foregroundStyle(.secondary)
                }
            }
            Button {
                Task {
                    let granted = await nm.requestPermission()
                    if granted { nm.applyAll() }
                }
            } label: {
                Text(L10n.t(.notifPermissionButton))
                    .font(.granlyBodyBold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.themeRose)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(16)
        .glassCard(cornerRadius: 16)
    }

    private var permissionBanner: some View {
        HStack(spacing: 12) {
            Image(systemName: "bell.slash.fill")
                .font(.system(size: 20))
                .foregroundStyle(.red)
            VStack(alignment: .leading, spacing: 2) {
                Text("Notifications disabled")
                    .font(.granlyHeadline)
                    .foregroundStyle(Color.themeText)
                Text("Enable them in iOS Settings → Granly.")
                    .font(.granlyBody)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("Settings")
                    .font(.granlyBodyBold)
                    .foregroundStyle(Color.themeRose)
            }
        }
        .padding(16)
        .glassCard(cornerRadius: 16)
    }

    // MARK: Reminder card builder
    @ViewBuilder
    private func reminderCard(
        icon: String,
        iconColor: Color,
        title: String,
        subtitle: String,
        isOn: Binding<Bool>,
        time: Binding<Date>,
        previewTitle: String,
        previewBody: String
    ) -> some View {
        VStack(spacing: 0) {
            // Header row
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(iconColor.opacity(0.15))
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundStyle(iconColor)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.granlyBodyBold).foregroundStyle(Color.themeText)
                    Text(subtitle).font(.granlyCaption).foregroundStyle(.secondary)
                }
                Spacer()
                Toggle("", isOn: isOn).labelsHidden().tint(Color.themeRose)
            }
            .padding(16)

            if isOn.wrappedValue {
                Divider().padding(.horizontal, 16)

                // Time picker
                HStack {
                    Text(L10n.t(.reminderTime))
                        .font(.granlyBody)
                        .foregroundStyle(.secondary)
                    Spacer()
                    DatePicker("", selection: time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .accentColor(iconColor)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

                Divider().padding(.horizontal, 16)

                // Preview notification bubble  
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "bell.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(iconColor)
                        .padding(6)
                        .background(iconColor.opacity(0.12))
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 2) {
                        Text(previewTitle)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color.themeText)
                        Text(previewBody)
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
        }
        .glassCard(cornerRadius: 16)
    }

    // MARK: Progress / streak card
    private var progressCard: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.purple.opacity(0.15))
                    .frame(width: 40, height: 40)
                Image(systemName: "flame.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(Color.purple)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(L10n.t(.progressUpdates))
                    .font(.granlyBodyBold)
                    .foregroundStyle(Color.themeText)
                Text(L10n.t(.notifProgressSubtitle))
                    .font(.granlyCaption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Toggle("", isOn: $nm.streakEnabled)
                .labelsHidden()
                .tint(Color.themeRose)
                .onChange(of: nm.streakEnabled) { on in
                    UserDefaults.standard.set(on, forKey: "notif_streak_on")
                    if on { Task { await ensurePermissionThenSchedule() } }
                    else  { nm.cancel(id: "com.granly.streak") }
                }
        }
        .padding(16)
        .glassCard(cornerRadius: 16)
    }

    // MARK: Empty state
    private var emptyState: some View {
        VStack(spacing: 14) {
            Image(systemName: "bell.slash")
                .font(.system(size: 44, weight: .light))
                .foregroundStyle(Color.themeRose.opacity(0.5))
                .padding(.top, 30)
            Text(L10n.t(.notifEmptyTitle))
                .font(.granlyHeadline)
                .foregroundStyle(Color.themeText)
                .multilineTextAlignment(.center)
            Text(L10n.t(.notifEmptyBody))
                .font(.granlyBody)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
    }

    // MARK: Helpers
    private func handleToggle() {
        Task { await ensurePermissionThenSchedule() }
    }

    private func ensurePermissionThenSchedule() async {
        if nm.authStatus == .notDetermined {
            _ = await nm.requestPermission()
        }
        if nm.authStatus == .authorized || nm.authStatus == .provisional {
            nm.applyAll()
        }
    }

    // Restore persisted time to a Date
    static func savedTime(_ key: String, defaultHour: Int) -> Date {
        let h = UserDefaults.standard.integer(forKey: "notif_\(key)_hour")
        let m = UserDefaults.standard.integer(forKey: "notif_\(key)_minute")
        var c = DateComponents()
        c.hour   = h == 0 ? defaultHour : h
        c.minute = m
        return Calendar.current.date(from: c) ?? Date()
    }
}
