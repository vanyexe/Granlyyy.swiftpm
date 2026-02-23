import SwiftUI
import Combine

// MARK: - AppLanguage
enum AppLanguage: String, CaseIterable, Identifiable {
    case english  = "en-US"
    case hindi    = "hi-IN"
    case spanish  = "es-ES"
    case french   = "fr-FR"
    case german   = "de-DE"
    case gujarati = "gu-IN"
    case marathi  = "mr-IN"

    var id: String { rawValue }

    /// Displayed in the language picker (native script)
    var displayName: String {
        switch self {
        case .english:  return "English"
        case .hindi:    return "हिन्दी"
        case .spanish:  return "Español"
        case .french:   return "Français"
        case .german:   return "Deutsch"
        case .gujarati: return "ગુજરાતી"
        case .marathi:  return "मराठी"
        }
    }

    /// BCP-47 language tag used by AVSpeechSynthesizer
    var bcp47: String { rawValue }

    /// SF Symbol icon for the language picker
    var icon: String {
        switch self {
        case .english:  return "character.book.closed"
        case .hindi:    return "character"
        case .spanish:  return "character.bubble"
        case .french:   return "text.book.closed"
        case .german:   return "text.bubble"
        case .gujarati: return "character.cursor.ibeam"
        case .marathi:  return "pencil.and.outline"
        }
    }

    /// True when full translation + TTS is shipped; others show "Coming Soon"
    var isFullySupported: Bool {
        switch self {
        case .english, .hindi, .spanish, .french, .german: return true
        case .gujarati, .marathi: return false
        }
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
