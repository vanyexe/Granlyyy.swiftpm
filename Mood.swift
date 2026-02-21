import SwiftUI

struct Mood: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
    let baseColor: Color
    
    static let allMoods = [
        Mood(name: "Happy", icon: "sun.max.fill", baseColor: .yellow),
        Mood(name: "Sad", icon: "cloud.rain.fill", baseColor: .blue),
        Mood(name: "Anxious", icon: "wind", baseColor: .orange),
        Mood(name: "Lonely", icon: "person.fill.questionmark", baseColor: .purple),
        Mood(name: "Tired", icon: "moon.zzz.fill", baseColor: .gray),
        Mood(name: "Angry", icon: "flame.fill", baseColor: .red),
        Mood(name: "Grateful", icon: "hands.clap.fill", baseColor: Color(red: 0.35, green: 0.75, blue: 0.55)),
        Mood(name: "Excited", icon: "star.fill", baseColor: Color(red: 0.95, green: 0.65, blue: 0.30))
    ]
}
