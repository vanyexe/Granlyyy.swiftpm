import SwiftUI

struct Mood: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String // Emoji or SF Symbol
    let baseColor: Color
    
    static let allMoods = [
        Mood(name: "Happy", icon: "sun.max", baseColor: .yellow),
        Mood(name: "Sad", icon: "cloud.rain", baseColor: .blue),
        Mood(name: "Anxious", icon: "wind", baseColor: .orange),
        Mood(name: "Lonely", icon: "person.fill.questionmark", baseColor: .purple),
        Mood(name: "Tired", icon: "moon.zzz", baseColor: .gray),
        Mood(name: "Angry", icon: "flame", baseColor: .red)

    ]
}


