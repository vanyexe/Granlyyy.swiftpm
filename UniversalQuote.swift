import Foundation
import SwiftUI

struct UniversalQuote: Identifiable {
    let id = UUID()
    let originalQuote: String
    let source: String
    let modernMeaning: String
    let corePrinciple: String
    let grandmaInterpretation: String
    let dailyPractice: String
    let iconColor: Color
}

struct UniversalQuotesData {
    static let quotes: [UniversalQuote] = [
        UniversalQuote(
            originalQuote: "You are what your deep, driving desire is. As your desire is, so is your will. As your will is, so is your deed. As your deed is, so is your destiny.",
            source: "Brihadaranyaka Upanishad (Vedic / Hindu)",
            modernMeaning: "Your most deep-rooted intentions shape your actions, and those actions continuously create your future. You define your path.",
            corePrinciple: "Intention & Action",
            grandmaInterpretation: "My dear, the seeds you plant in your heart today are exactly what will grow in your garden tomorrow. What are you watering with your thoughts?",
            dailyPractice: "Write down one thing you strongly desire today. Notice if your actions this afternoon move you closer to it or further away.",
            iconColor: .orange
        ),
        
        UniversalQuote(
            originalQuote: "Love your neighbor as yourself.",
            source: "Leviticus 19:18 & Mark 12:31 (Torah / Bible)",
            modernMeaning: "Treat the people around you with the exact same kindness, grace, and patience you would hope someone shows to you when you make a mistake.",
            corePrinciple: "Compassion",
            grandmaInterpretation: "It is easy to love someone perfect, sweetheart, but there are no perfect people. We all need love the most when we deserve it the least. Give what you hope to receive.",
            dailyPractice: "When someone annoys you today, pause and ask: 'If I was in their shoes, how would I want to be treated right now?'",
            iconColor: Color.themeRose
        ),
        
        UniversalQuote(
            originalQuote: "Hatred does not cease by hatred, but only by love; this is the eternal rule.",
            source: "The Dhammapada (Buddhist)",
            modernMeaning: "You cannot solve anger with more anger. Fire cannot put out fire; only water can.",
            corePrinciple: "Forgiveness",
            grandmaInterpretation: "Holding onto anger is like drinking poison and expecting the other person to get sick. Whenever you feel angry, take a deep breath and let it go. It's for your own peace.",
            dailyPractice: "Think of a small grudge you are holding. Visualize opening your hand and letting it fly away like a bird. You don't need to carry it anymore.",
            iconColor: .purple
        ),
        
        UniversalQuote(
            originalQuote: "Whoever saves one life, it is as if he had saved mankind entirely.",
            source: "Quran 5:32 (Islamic)",
            modernMeaning: "Every single human life holds infinite value. One small act of kindness to one person changes the entire world because they are someone's whole world.",
            corePrinciple: "Value of Life",
            grandmaInterpretation: "Never think your small acts of kindness don't matter, my love. A smile, holding the door, a kind word—you might just be saving someone's day without even knowing it.",
            dailyPractice: "Do one totally unseen, anonymous act of kindness today. Pick up a piece of trash, leave a nice note, let someone merge in traffic.",
            iconColor: .green
        ),
        
        UniversalQuote(
            originalQuote: "Recognize the human race as one.",
            source: "Guru Gobind Singh (Sikh)",
            modernMeaning: "Beyond all our different clothing, jobs, appearances, and beliefs, we all share the exact same fundamental human spirit and worth.",
            corePrinciple: "Unity",
            grandmaInterpretation: "We are all different flowers in the same big garden. The differences make the garden beautiful. We need the roses and the sunflowers alike.",
            dailyPractice: "When you interact with a stranger today (like a cashier), look them in the eyes and remember: they have a family, hopes, and worries, just like you.",
            iconColor: .blue
        ),
        
        UniversalQuote(
            originalQuote: "You have the right to work, but never to the fruit of work.",
            source: "Bhagavad Gita (Hindu)",
            modernMeaning: "Focus entirely on doing a good job with what is in front of you, but do not get obsessed with the reward, the applause, or the outcome. You can only control your effort.",
            corePrinciple: "Detachment",
            grandmaInterpretation: "Do your absolute best, wash your hands, and let it be. If you bake a cake just for the compliments, it never tastes as sweet as a cake baked with pure love.",
            dailyPractice: "Do a chore today (dishes, sweeping) not just to 'get it done,' but to do it beautifully. Appreciate the act of doing.",
            iconColor: .yellow
        ),
        
        UniversalQuote(
            originalQuote: "Nature does not hurry, yet everything is accomplished.",
            source: "Lao Tzu (Tao Te Ching)",
            modernMeaning: "Growth takes the time it takes. You cannot force a flower to bloom by pulling its petals.",
            corePrinciple: "Patience",
            grandmaInterpretation: "Oh honey, you're always running so fast! Sit. Breathe. The seasons always change right on time. Trust your own timing. You are not behind.",
            dailyPractice: "For just five minutes today, sit completely still with no screens, no music, no talking. Just watch the world happen around you.",
            iconColor: Color.themeGreen
        )
    ]
}
