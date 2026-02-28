import SwiftUI
import Combine

enum AppLanguage: String, CaseIterable, Identifiable {
    case english  = "en-US"
    case mandarin = "zh-CN"
    case hindi    = "hi-IN"
    case spanish  = "es-ES"
    case french   = "fr-FR"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .english:  return "English"
        case .mandarin: return "中文"
        case .hindi:    return "हिन्दी"
        case .spanish:  return "Español"
        case .french:   return "Français"
        }
    }

    var bcp47: String { rawValue }

    var icon: String {
        switch self {
        case .english:  return "character.book.closed"
        case .mandarin: return "character.bubble.zh"
        case .hindi:    return "character"
        case .spanish:  return "character.bubble"
        case .french:   return "text.book.closed"
        }
    }

    var isFullySupported: Bool {
        return true
    }
}

@MainActor
final class LanguageManager: ObservableObject {

    static let shared = LanguageManager()

    @AppStorage("selectedLanguage") private var storedLanguageCode: String = AppLanguage.english.rawValue

    @Published private(set) var selectedLanguage: AppLanguage = .english

    private init() {

        selectedLanguage = AppLanguage(rawValue: storedLanguageCode) ?? .english
    }

    func setLanguage(_ language: AppLanguage) {
        storedLanguageCode = language.rawValue
        withAnimation(.easeInOut(duration: 0.35)) {
            selectedLanguage = language
        }
    }
}