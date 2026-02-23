import SwiftUI

struct Mood: Identifiable, Hashable {
    let id = UUID()
    let name: String          // English key for StoryManager lookup (do not localize this)
    let icon: String
    let baseColor: Color

    /// Localized display name — pass current language explicitly to avoid actor isolation issues
    func localizedName(for language: AppLanguage) -> String {
        let key: L10nKey
        switch name {
        case "Happy":    key = .moodHappy
        case "Sad":      key = .moodSad
        case "Anxious":  key = .moodAnxious
        case "Lonely":   key = .moodLonely
        case "Tired":    key = .moodTired
        case "Angry":    key = .moodAngry
        case "Grateful": key = .moodGrateful
        case "Excited":  key = .moodExcited
        default:         return name
        }
        return L10n.strings[language]?[key] ?? name
    }

    static let allMoods = [
        Mood(name: "Happy",    icon: "sun.max.fill",             baseColor: .yellow),
        Mood(name: "Sad",      icon: "cloud.rain.fill",           baseColor: .blue),
        Mood(name: "Anxious",  icon: "wind",                     baseColor: .orange),
        Mood(name: "Lonely",   icon: "person.fill.questionmark",  baseColor: .purple),
        Mood(name: "Tired",    icon: "moon.zzz.fill",             baseColor: .gray),
        Mood(name: "Angry",    icon: "flame.fill",                baseColor: .red),
        Mood(name: "Grateful", icon: "hands.clap.fill",           baseColor: Color(red: 0.35, green: 0.75, blue: 0.55)),
        Mood(name: "Excited",  icon: "star.fill",                 baseColor: Color(red: 0.95, green: 0.65, blue: 0.30))
    ]
}
