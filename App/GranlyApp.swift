import SwiftUI

@main
struct GranlyApp: App {
    @AppStorage("darkMode") private var darkMode = false
    /// Read directly so the Scene body re-evaluates when the stored value changes,
    /// giving `.environment(\.locale, …)` a new value and re-rendering the whole tree.
    @AppStorage("selectedLanguage") private var selectedLanguage: String = AppLanguage.english.rawValue

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(darkMode ? .dark : .light)
                .environmentObject(LanguageManager.shared)
                // Inject locale so native SwiftUI components (formatters, pickers, etc.)
                // also update without requiring an app restart.
                .environment(\.locale, Locale(identifier: selectedLanguage))
        }
    }
}
