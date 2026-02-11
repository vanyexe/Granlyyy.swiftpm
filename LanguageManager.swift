//
//  LanguageManager.swift
//  Granly
//
//  Created by student on 10/02/26.
//
import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en-US"
    case spanish = "es-ES"
    case french = "fr-FR"
    case german = "de-DE"
    case hindi = "hi-IN"
    // Add more as needed
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .spanish: return "Español"
        case .french: return "Français"
        case .german: return "Deutsch"
        case .hindi: return "हिन्दी"
        }
    }
}

class LanguageManager: ObservableObject {
    @AppStorage("selectedLanguage") var selectedLanguageCode: String = AppLanguage.english.rawValue
    
    var selectedLanguage: AppLanguage {
        get { AppLanguage(rawValue: selectedLanguageCode) ?? .english }
        set { selectedLanguageCode = newValue.rawValue }
    }
}


