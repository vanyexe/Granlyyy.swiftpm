import SwiftUI

// MARK: - Mood Palette
/// Per-mood, per-color-scheme gradient stop arrays.
struct MoodPalette {
    let dark: [Color]   // 3 stops: vibrant richness for dark mode
    let light: [Color]  // 3 stops: warm softness for light mode
}

@MainActor
struct Mood: Identifiable, Hashable {
    let id = UUID()
    let name: String          // English key for StoryManager lookup (do not localize this)
    let icon: String
    let baseColor: Color

    /// Vibrant mood-specific gradient stops, adaptive for light/dark mode.
    func gradientColors(for colorScheme: ColorScheme) -> [Color] {
        let palette: MoodPalette
        switch name {
        case "Happy":
            palette = MoodPalette(
                dark:  [Color(red:0.88, green:0.70, blue:0.32),   // warm golden
                        Color(red:0.72, green:0.44, blue:0.20),   // soft amber
                        Color(red:0.28, green:0.18, blue:0.08)],  // warm caramel shadow
                light: [Color(red:1.00, green:0.93, blue:0.50),
                        Color(red:1.00, green:0.72, blue:0.22),
                        Color(red:0.98, green:0.55, blue:0.10)])
        case "Sad":
            palette = MoodPalette(
                dark:  [Color(red:0.28, green:0.38, blue:0.68),   // softened slate blue
                        Color(red:0.38, green:0.52, blue:0.78),   // muted cornflower
                        Color(red:0.10, green:0.14, blue:0.30)],  // warm deep slate
                light: [Color(red:0.60, green:0.78, blue:1.00),
                        Color(red:0.35, green:0.58, blue:0.90),
                        Color(red:0.20, green:0.38, blue:0.70)])
        case "Anxious":
            palette = MoodPalette(
                dark:  [Color(red:0.78, green:0.48, blue:0.20),   // warm amber
                        Color(red:0.60, green:0.28, blue:0.12),   // muted terracotta
                        Color(red:0.22, green:0.10, blue:0.04)],  // warm dark sienna
                light: [Color(red:1.00, green:0.82, blue:0.60),
                        Color(red:1.00, green:0.62, blue:0.28),
                        Color(red:0.88, green:0.40, blue:0.10)])
        case "Lonely":
            palette = MoodPalette(
                dark:  [Color(red:0.52, green:0.25, blue:0.68),   // soft violet
                        Color(red:0.35, green:0.16, blue:0.50),   // muted plum
                        Color(red:0.15, green:0.08, blue:0.22)],  // warm deep plum
                light: [Color(red:0.88, green:0.72, blue:1.00),
                        Color(red:0.68, green:0.45, blue:0.90),
                        Color(red:0.48, green:0.22, blue:0.72)])
        case "Tired":
            palette = MoodPalette(
                dark:  [Color(red:0.38, green:0.32, blue:0.50),   // muted dusty lavender
                        Color(red:0.26, green:0.22, blue:0.38),   // warm slate violet
                        Color(red:0.14, green:0.12, blue:0.20)],  // soft warm charcoal
                light: [Color(red:0.78, green:0.74, blue:0.88),
                        Color(red:0.58, green:0.55, blue:0.72),
                        Color(red:0.38, green:0.36, blue:0.55)])
        case "Angry":
            palette = MoodPalette(
                dark:  [Color(red:0.82, green:0.22, blue:0.16),   // warm crimson
                        Color(red:0.58, green:0.14, blue:0.10),   // muted brick red
                        Color(red:0.20, green:0.08, blue:0.06)],  // warm dark crimson
                light: [Color(red:1.00, green:0.60, blue:0.55),
                        Color(red:0.95, green:0.30, blue:0.22),
                        Color(red:0.75, green:0.10, blue:0.08)])
        case "Grateful":
            palette = MoodPalette(
                dark:  [Color(red:0.18, green:0.62, blue:0.42),   // warm emerald
                        Color(red:0.12, green:0.44, blue:0.32),   // muted forest
                        Color(red:0.08, green:0.18, blue:0.14)],  // warm deep forest
                light: [Color(red:0.70, green:0.98, blue:0.80),
                        Color(red:0.38, green:0.85, blue:0.58),
                        Color(red:0.18, green:0.65, blue:0.42)])
        case "Excited":
            palette = MoodPalette(
                dark:  [Color(red:0.85, green:0.52, blue:0.18),   // warm golden orange
                        Color(red:0.68, green:0.26, blue:0.42),   // muted raspberry
                        Color(red:0.24, green:0.10, blue:0.18)],  // warm deep berry
                light: [Color(red:1.00, green:0.88, blue:0.50),
                        Color(red:1.00, green:0.60, blue:0.35),
                        Color(red:0.92, green:0.28, blue:0.55)])
        default:
            palette = MoodPalette(
                dark:  [Color(red:0.48, green:0.30, blue:0.38),   // soft warm mauve
                        Color(red:0.30, green:0.18, blue:0.26),   // muted rosewood
                        Color(red:0.18, green:0.12, blue:0.16)],  // warm dark mauve
                light: [Color(red:0.90, green:0.78, blue:0.85),
                        Color(red:0.72, green:0.55, blue:0.68),
                        Color(red:0.55, green:0.35, blue:0.50)])
        }
        return colorScheme == .dark ? palette.dark : palette.light
    }

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
        Mood(name: "Happy",    icon: "sun.max.fill",             baseColor: Color(red:1.00, green:0.80, blue:0.10)),
        Mood(name: "Sad",      icon: "cloud.rain.fill",           baseColor: Color(red:0.25, green:0.50, blue:0.90)),
        Mood(name: "Anxious",  icon: "wind",                     baseColor: Color(red:0.90, green:0.45, blue:0.08)),
        Mood(name: "Lonely",   icon: "person.fill.questionmark",  baseColor: Color(red:0.55, green:0.20, blue:0.80)),
        Mood(name: "Tired",    icon: "moon.zzz.fill",             baseColor: Color(red:0.55, green:0.50, blue:0.75)),
        Mood(name: "Angry",    icon: "flame.fill",                baseColor: Color(red:0.92, green:0.12, blue:0.10)),
        Mood(name: "Grateful", icon: "hands.clap.fill",           baseColor: Color(red:0.12, green:0.72, blue:0.45)),
        Mood(name: "Excited",  icon: "star.fill",                 baseColor: Color(red:0.98, green:0.55, blue:0.10))
    ]
}
