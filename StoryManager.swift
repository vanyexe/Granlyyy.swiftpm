import Foundation
import SwiftUI


struct Story: Identifiable, Codable {
    var id: String { title } // Use title as ID for simplicity in this version
    let title: String
    let content: String
}

@MainActor
public class StoryManager: ObservableObject {
    public static let shared = StoryManager()
    @AppStorage("selectedLanguage") var selectedLanguageCode: String = "en-US"
    @AppStorage("likedStoryIDs") private var likedStoryIDsRaw: String = ""
    
    var likedStoryIDs: [String] {
        get { likedStoryIDsRaw.split(separator: ",").map(String.init) }
        set { likedStoryIDsRaw = newValue.joined(separator: ",") }
    }
    
    func isLiked(story: Story) -> Bool {
        likedStoryIDs.contains(story.id)
    }
    
    func toggleLike(for story: Story) {
        var current = likedStoryIDs
        if let index = current.firstIndex(of: story.id) {
            current.remove(at: index)
        } else {
            current.append(story.id)
        }
        likedStoryIDs = current
    }
    
    func getStory(id: String) -> Story? {
        // Search through all languages/moods to find the story.
        let allStories = Mood.allMoods.map { getStory(for: $0) }
        return allStories.first { $0.id == id }
    }
    
    func getStory(for mood: Mood) -> Story {
        let lang = AppLanguage(rawValue: selectedLanguageCode) ?? .english
        
        switch lang {
        case .english: return getEnglishStory(for: mood)
        case .spanish: return getSpanishStory(for: mood)
        case .french: return getFrenchStory(for: mood)
        case .german: return getGermanStory(for: mood)
        case .hindi: return getHindiStory(for: mood)
        }
    }
    
    // MARK: - English Stories (Long & Sweet)
    private func getEnglishStory(for mood: Mood) -> Story {
        switch mood.name {
        case "Happy":
            return Story(title: "The Garden of Joy", content: "Oh, hello my dear! It brings such warmth to my heart to see you smiling like that. You know, happiness is a lot like my old garden back at the cottage. \n\nI remember one particular spring morning, much like this one. The sun was just peeking over the hills, painting the sky in shades of soft pink and gold. I had spent weeks preparing the soil, worrying if the frost had been too harsh that winter. But as I walked out with my watering can, I saw it—the very first bloom of the season. A magnificent, yellow daffodil, standing tall and proud, waving in the gentle breeze.\n\nIt reminded me that no matter how long the winter, spring always returns. Joy always finds a way to break through. Seeing you happy is like seeing that first bloom all over again. It spreads, you know? Your smile lights up this whole room, just like that daffodil lit up my entire garden. Hold onto this feeling, cherish it, and let it help you grow. You are my little ray of sunshine. And just like the garden needs the sun to bloom, the world needs your beautiful smile. Never forget how precious this happiness is.")
        case "Sad":
            return Story(title: "The Rainy Window", content: "Come here, sweet child. Let me wrap this warm, knitted blanket around your shoulders. There, that's better. I see a little cloud hanging over you today. It's alright, you know. Even the sky needs to cry sometimes to water the earth.\n\nI remember a time when I was a breathless young girl, and my best friend moved far away. Oh, I felt like my heart had cracked right down the middle. It rained for three days straight, and I sat by the window, watching the droplets race each other down the glass. My grandmother—your great-great-grandmother—sat beside me, just as I am sitting with you now. She didn't tell me to stop crying. She just handed me a warm cup of cocoa and held my hand.\n\nShe told me that sadness is just love with nowhere to go for the moment. It shows that you have a big, beautiful heart capable of feeling deeply. So let the tears fall if they must. I am right here. We'll watch the rain together until the clouds clear. And they always do clear, my love. They always do. You are never alone in your sadness, I am here to hold your hand through it all.")
        case "Anxious":
            return Story(title: "The Ancient Oak", content: "Breathe with me, deep and slow. In... and out. Good. Now, close your eyes and imagine a vast, green forest. In the center of this forest stands an ancient oak tree. It has been there for hundreds of years.\n\nThink about all the storms that tree has seen. The howling winds, the heavy snows, the crashing thunder. Yet, through it all, it stands firm. Do you know why? Because its roots go deep, deep into the earth. They anchor it, holding it steady no matter what is happening above ground.\n\nYou are just like that oak tree, my darling. You have strength inside you that is deeper than you know. The worries you feel right now are just like the wind rustling the leaves—they are noisy and they might shake you a little, but they cannot uproot you. You are grounded. You are safe. I am here, leaning against the trunk with you, and together we can weather any storm. You are stronger than your fears. Trust in your roots, trust in yourself.")
        case "Lonely":
            return Story(title: "The Symphony of Stars", content: "Oh, my precious one. Loneliness can feel so cold, like standing in an empty field in winter. But look up with me. Imagine the night sky, dark and vast. At first, it seems empty, doesn't it?\n\nBut if you keep looking, your eyes adjust, and you see one tiny star. Then another. And another. Soon, you realize the sky isn't empty at all—it is crowded with millions of shining lights, all connected in a grand, silent dance. \n\nWe are like those stars. Even when we feel miles apart, we are part of the same beautiful universe. The light from a star takes years to reach us, but it travels all that way just to say, 'I am here.' My love for you is like that starlight. Even when you can't see me, even when you feel completely on your own, my love is travelling to you, surrounding you. You are never truly alone. The whole universe is holding you, and I am right here in your heart.")
        default:
            return Story(title: "Grandma's Kitchen", content: "It is simply wonderful to see you. Why don't you pull up a chair? I was just remembering the smell of fresh apple pie baking in the oven. The scent of cinnamon and sugar filling the air, warm and comforting. \n\nI remember baking my first pie with my mother. I made such a mess! Flour everywhere, on my nose, in my hair. But we laughed so hard our bellies hurt. That's the secret ingredient, you know. Love and laughter. \n\nNo matter how you are feeling, there is always a seat for you at my table, and plenty of love to go around. You are always welcome here, in the warmth of my kitchen and my heart.")
        }
    }
    
    // MARK: - Spanish Stories (Examples)
    private func getSpanishStory(for mood: Mood) -> Story {
        switch mood.name {
        case "Happy":
            return Story(title: "El Jardín Soleado", content: "¡Hola, cariño! Me alegra tanto verte sonreír. La felicidad es como mi viejo jardín. Recuerdo una mañana de primavera, vi el primer narciso florecer. Me recordó que, sin importar cuán largo sea el invierno, la primavera siempre regresa. Tu sonrisa ilumina esta habitación como esa flor iluminó mi jardín. Eres mi pequeño rayo de sol.")
        default:
            return Story(title: "Amor de Abuela", content: "Estoy tan feliz de verte. Recuerda, sin importar cómo te sientas, la abuela te quiere mucho.")
        }
    }
    
    // MARK: - French Stories (Examples)
    private func getFrenchStory(for mood: Mood) -> Story {
        switch mood.name {
        case "Happy":
            return Story(title: "Le Jardin Ensoleillé", content: "Bonjour, mon chéri! Cela me réchauffe le cœur de te voir sourire. Le bonheur, c'est comme mon vieux jardin. Je me souviens d'un matin de printemps, j'ai vu la première jonquille fleurir. Elle m'a rappelé que peu importe la durée de l'hiver, le printemps revient toujours. Ton sourire illumine cette pièce tout comme cette fleur a illuminé mon jardin.")
        default:
            return Story(title: "L'amour de Grand-mère", content: "Je suis si heureuse de te voir. Rappelle-toi, peu importe ce que tu ressens, Grand-mère t'aime beaucoup.")
        }
    }
    
    // MARK: - German Stories (Examples)
    private func getGermanStory(for mood: Mood) -> Story {
         return Story(title: "Omas Liebe", content: "Ich bin so froh, dich zu sehen. Denk daran, egal wie du dich fühlst, Oma hat dich sehr lieb.")
    }
    
    // MARK: - Hindi Stories (Examples)
    private func getHindiStory(for mood: Mood) -> Story {
         return Story(title: "दादी का प्यार", content: "तुम्हें देखकर मुझे बहुत खुशी हुई। याद रखना, तुम कैसा भी महसूस करो, दादी तुम्हें बहुत प्यार करती है।")
    }
}



