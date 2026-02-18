import SwiftUI

struct Mood: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
    let emoji: String
    let baseColor: Color
    
    static let allMoods = [
        Mood(name: "Happy", icon: "sun.max.fill", emoji: "😊", baseColor: .yellow),
        Mood(name: "Sad", icon: "cloud.rain.fill", emoji: "😢", baseColor: .blue),
        Mood(name: "Anxious", icon: "wind", emoji: "😰", baseColor: .orange),
        Mood(name: "Lonely", icon: "person.fill.questionmark", emoji: "🥺", baseColor: .purple),
        Mood(name: "Tired", icon: "moon.zzz.fill", emoji: "😴", baseColor: .gray),
        Mood(name: "Angry", icon: "flame.fill", emoji: "😤", baseColor: .red),
        Mood(name: "Grateful", icon: "hands.clap.fill", emoji: "🙏", baseColor: Color(red: 0.35, green: 0.75, blue: 0.55)),
        Mood(name: "Excited", icon: "star.fill", emoji: "🤩", baseColor: Color(red: 0.95, green: 0.65, blue: 0.30))
    ]
}
