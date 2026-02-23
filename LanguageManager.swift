import SwiftUI
import Combine

// MARK: - AppLanguage
enum AppLanguage: String, CaseIterable, Identifiable {
    case english  = "en-US"
    case mandarin = "zh-CN"
    case hindi    = "hi-IN"
    case spanish  = "es-ES"
    case french   = "fr-FR"

    var id: String { rawValue }

    /// Displayed in the language picker (native script)
    var displayName: String {
        switch self {
        case .english:  return "English"
        case .mandarin: return "中文"
        case .hindi:    return "हिन्दी"
        case .spanish:  return "Español"
        case .french:   return "Français"
        }
    }

    /// BCP-47 language tag used by AVSpeechSynthesizer
    var bcp47: String { rawValue }

    /// SF Symbol icon for the language picker
    var icon: String {
        switch self {
        case .english:  return "character.book.closed"
        case .mandarin: return "character.bubble.zh"
        case .hindi:    return "character"
        case .spanish:  return "character.bubble"
        case .french:   return "text.book.closed"
        }
    }

    /// True when full translation + TTS is shipped; others show "Coming Soon"
    var isFullySupported: Bool {
        return true
    }
}

// MARK: - LanguageManager
@MainActor
final class LanguageManager: ObservableObject {
    
    /// Singleton injected at app root via `.environmentObject`
    static let shared = LanguageManager()

    @AppStorage("selectedLanguage") private var storedLanguageCode: String = AppLanguage.english.rawValue

    @Published private(set) var selectedLanguage: AppLanguage = .english

    private init() {
        // Sync @Published from @AppStorage on init
        selectedLanguage = AppLanguage(rawValue: storedLanguageCode) ?? .english
    }

    /// Call this to change language — persists & notifies all observers
    func setLanguage(_ language: AppLanguage) {
        storedLanguageCode = language.rawValue
        withAnimation(.easeInOut(duration: 0.35)) {
            selectedLanguage = language
        }
    }
}
