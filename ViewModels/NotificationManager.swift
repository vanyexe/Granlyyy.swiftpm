import UserNotifications
import SwiftUI

// MARK: - Notification IDs
private enum NotifID {
    static let story    = "com.granly.story"
    static let activity = "com.granly.activity"
    static let streak   = "com.granly.streak"
}

// MARK: - NotificationManager
@MainActor
final class NotificationManager: ObservableObject {

    static let shared = NotificationManager()
    private init() {}

    // MARK: Published toggles & times
    @Published var storyEnabled:    Bool = UserDefaults.standard.bool(forKey: "notif_story_on")
    @Published var activityEnabled: Bool = UserDefaults.standard.bool(forKey: "notif_activity_on")
    @Published var streakEnabled:   Bool = UserDefaults.standard.bool(forKey: "notif_streak_on")

    @Published var storyHour:    Int = UserDefaults.standard.integer(forKey: "notif_story_hour")    == 0 ? 20 : UserDefaults.standard.integer(forKey: "notif_story_hour")
    @Published var storyMinute:  Int = UserDefaults.standard.integer(forKey: "notif_story_minute")
    @Published var activityHour: Int = UserDefaults.standard.integer(forKey: "notif_activity_hour") == 0 ? 8 : UserDefaults.standard.integer(forKey: "notif_activity_hour")
    @Published var activityMinute: Int = UserDefaults.standard.integer(forKey: "notif_activity_minute")

    // Authorisation status — populated on view appear
    @Published var authStatus: UNAuthorizationStatus = .notDetermined

    // MARK: Request permission
    func requestPermission() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge])
            await refreshStatus()
            return granted
        } catch {
            return false
        }
    }

    // MARK: Refresh current auth status
    func refreshStatus() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        authStatus = settings.authorizationStatus
    }

    // MARK: Schedule story reminder
    func scheduleStoryReminder() {
        cancel(id: NotifID.story)
        guard storyEnabled else { return }

        // Alternate between two body texts
        let bodies = [L10n.t(.notifStoryBody), L10n.t(.notifStoryBody2)]
        for (i, body) in bodies.enumerated() {
            let content = UNMutableNotificationContent()
            content.title = L10n.t(.notifStoryTitle)
            content.body  = body
            content.sound = .default

            var comps = DateComponents()
            comps.hour   = storyHour
            comps.minute = storyMinute + i * 1 // slight offset so they don't collapse

            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
            let req     = UNNotificationRequest(identifier: "\(NotifID.story)_\(i)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(req)
        }

        // Persist
        UserDefaults.standard.set(true,        forKey: "notif_story_on")
        UserDefaults.standard.set(storyHour,   forKey: "notif_story_hour")
        UserDefaults.standard.set(storyMinute, forKey: "notif_story_minute")
    }

    // MARK: Schedule activity reminder
    func scheduleActivityReminder() {
        cancel(id: NotifID.activity)
        guard activityEnabled else { return }

        let content       = UNMutableNotificationContent()
        content.title     = L10n.t(.notifActivityTitle)
        content.body      = L10n.t(.notifActivityBody)
        content.sound     = .default

        var comps         = DateComponents()
        comps.hour        = activityHour
        comps.minute      = activityMinute

        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        let req     = UNNotificationRequest(identifier: NotifID.activity, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req)

        // Weekend special (same time Saturday & Sunday)
        for weekday in [7, 1] { // Sat, Sun
            var wComps          = comps
            wComps.weekday      = weekday
            let wContent        = UNMutableNotificationContent()
            wContent.title      = L10n.t(.notifActivityTitle)
            wContent.body       = L10n.t(.notifActivityBody2)
            wContent.sound      = .default
            let wReq            = UNNotificationRequest(
                identifier: "\(NotifID.activity)_weekend_\(weekday)",
                content: wContent,
                trigger: UNCalendarNotificationTrigger(dateMatching: wComps, repeats: true)
            )
            UNUserNotificationCenter.current().add(wReq)
        }

        UserDefaults.standard.set(true,           forKey: "notif_activity_on")
        UserDefaults.standard.set(activityHour,   forKey: "notif_activity_hour")
        UserDefaults.standard.set(activityMinute, forKey: "notif_activity_minute")
    }

    // MARK: Schedule streak reminder (fires 24h after last recorded open)
    func scheduleStreakReminder() {
        cancel(id: NotifID.streak)
        guard streakEnabled else { return }

        let content   = UNMutableNotificationContent()
        content.title = L10n.t(.notifStreakTitle)
        content.body  = L10n.t(.notifStreakBody)
        content.sound = .default

        // Repeating interval: every 24 h
        let trigger   = UNTimeIntervalNotificationTrigger(timeInterval: 86_400, repeats: true)
        let req       = UNNotificationRequest(identifier: NotifID.streak, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req)

        UserDefaults.standard.set(true, forKey: "notif_streak_on")
    }

    // MARK: Cancel individual type
    func cancel(id: String) {
        let center = UNUserNotificationCenter.current()
        // Remove all identifiers that start with the given id prefix
        center.getPendingNotificationRequests { requests in
            let ids = requests.map(\.identifier).filter { $0.hasPrefix(id) }
            center.removePendingNotificationRequests(withIdentifiers: ids)
        }
    }

    // MARK: Cancel all Granly notifications
    func cancelAll() {
        cancel(id: NotifID.story)
        cancel(id: NotifID.activity)
        cancel(id: NotifID.streak)
    }

    // MARK: Apply all current settings
    func applyAll() {
        scheduleStoryReminder()
        scheduleActivityReminder()
        scheduleStreakReminder()
    }
}
