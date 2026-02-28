import SwiftUI

@main
struct GranlyApp: App {
    @AppStorage("darkMode") private var darkMode = false

    @AppStorage("selectedLanguage") private var selectedLanguage: String = AppLanguage.english.rawValue

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(darkMode ? .dark : .light)
                .environmentObject(LanguageManager.shared)

                .environment(\.locale, Locale(identifier: selectedLanguage))
        }
    }
}