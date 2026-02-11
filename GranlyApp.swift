import SwiftUI

@main
struct GranlyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.none) // Respect system light/dark mode
        }
    }
}


