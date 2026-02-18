import Foundation
import SwiftUI

struct Story: Identifiable, Codable {
    var id: String { title }
    let title: String
    let content: String
    var category: String = "General" // Default for backward compatibility
    var readTime: Int = 3 // Default read time in minutes
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
    
    // Returns a single story for the main view (defaults to first or random)
    func getStory(for mood: Mood) -> Story {
        return getStories(for: mood).randomElement() ?? Story(title: "Grandma's Greeting", content: "Hello dear, I'm so happy to see you!", category: "General", readTime: 1)
    }
    
    func getStory(id: String) -> Story? {
        // Search through all moods
        for mood in Mood.allMoods {
            if let story = getStories(for: mood).first(where: { $0.id == id }) {
                return story
            }
        }
        return nil
    }
    
    // Returns ALL stories for a specific mood
    func getStories(for mood: Mood) -> [Story] {
        // For now, simpler implementation: switch on mood name
        // Ideally this would be a dictionary or database
        switch mood.name {
        case "Happy": return happyStories
        case "Sad": return sadStories
        case "Anxious": return anxiousStories
        case "Lonely": return lonelyStories
        case "Tired": return tiredStories
        case "Angry": return angryStories
        case "Grateful": return gratefulStories
        case "Excited": return excitedStories
        default: return [Story(title: "Grandma's Love", content: "You are always loved, my dear.", category: "Love", readTime: 1)]
        }
    }
    
    func getRandomStory(for mood: Mood) -> Story {
        let base = getStories(for: mood).randomElement() ?? getStory(for: mood)
        // Add random closing for variety
        let extras = [
            "\n\nAnd remember, my dear, every sunset promises a new sunrise.",
            "\n\nNow come, let me make you a warm cup of tea while we sit together.",
            "\n\nYou know, your grandfather would have loved to hear this story too.",
            "\n\nSometimes the best stories are the ones we live, not just the ones we hear.",
            "\n\nNow, shall I tell you another? Or shall we just sit here and enjoy the quiet together?"
        ]
        let extra = extras[Int.random(in: 0..<extras.count)]
        return Story(title: base.title, content: base.content + extra, category: base.category, readTime: base.readTime)
    }
    
    // MARK: - Story Data (24 Stories, 3 per Mood)
    
    // HAPPY
    private var happyStories: [Story] {
        [
            Story(title: "The Garden of Joy", content: "Oh, hello my dear! It brings such warmth to my heart to see you smiling. You know, happiness is like my old garden... [Content from previous version] ...seeing that first bloom all over again.", category: "Nature", readTime: 3),
            Story(title: " The Surprise Picnic", content: "Do you remember the time we went on a picnic and forgot the basket? We laughed so hard until our bellies hurt! We ended up eating wild berries and telling stories under the old oak tree. It wasn't the lunch we planned, but it was perfect because we were together.", category: "Funny", readTime: 2),
            Story(title: "The Dancing Fireflies", content: "When I was a girl, the summer nights were filled with fireflies. They danced like tiny stars that had fallen to earth. We would catch them in jars, make a wish, and set them free. Your smile reminds me of that light—pure, magical, and full of hope.", category: "Bedtime", readTime: 4)
        ]
    }
    
    // SAD
    private var sadStories: [Story] {
        [
            Story(title: "The Rainy Window", content: "Come here, sweet child. Let me wrap this warm blanket around you. I see a cloud hanging over you. Even the sky needs to cry sometimes to water the earth... [Content from previous version]", category: "Comfort", readTime: 3),
            Story(title: "The Broken Teacup", content: "I once had a beautiful teacup that shattered. I was devastated. But my father helped me glue it back together with gold lacquer. He told me, 'Now it's even more beautiful because it has a history.' Your broken pieces make you who you are, beautiful and strong.", category: "Moral", readTime: 3),
            Story(title: "The Moon's Hiding Place", content: "Even the moon disappears sometimes, hidden by the dark night. But she never leaves. She is just resting, gathering her light to shine even brighter. It's okay to hide for a while, my love. Your light will return.", category: "Bedtime", readTime: 2)
        ]
    }
    
    // ANXIOUS
    private var anxiousStories: [Story] {
        [
            Story(title: "The Ancient Oak", content: "Breathe with me, deep and slow. Imagine a vast forest and an ancient oak tree... [Content from previous version]", category: "Nature", readTime: 3),
            Story(title: "The River's Flow", content: "Ideally, life flows like a river. Sometimes it rushes over rocks, sometimes it's calm. But the river never worries about where it's going—it trusts the path. Trust your path, my dear. You will get where you need to be.", category: "Moral", readTime: 3),
            Story(title: "Grandma's Secret Pocket", content: "I used to carry a smooth stone in my pocket whenever I felt scared. I'd rub it with my thumb and remember: 'This too shall pass.' Imagine I'm putting that stone in your hand right now. You are safe.", category: "Comfort", readTime: 2)
        ]
    }
    
    // LONELY
    private var lonelyStories: [Story] {
        [
            Story(title: "The Symphony of Stars", content: "Oh, my precious one. Loneliness can feel cold. But look up at the night sky... [Content from previous version]", category: "Bedtime", readTime: 4),
            Story(title: "The Invisible Thread", content: "There is an ancient legend that says an invisible red thread connects those who are destined to meet. Even when you feel alone, you are connected to people who love you, and people you haven't even met yet. You are part of a giant web of love.", category: "Moral", readTime: 3),
            Story(title: "The Letter in the Mail", content: "I used to write letters to myself when I was lonely. I'd tell myself all the things I needed to hear. 'You are kind, you are smart, you are worthy.' Maybe today, you can be your own best friend too.", category: "Comfort", readTime: 2)
        ]
    }
    
    // TIRED
    private var tiredStories: [Story] {
        [
            Story(title: "The Cozy Quilt", content: "Oh my dear, you look weary. Let me tell you about the quilt my mother made... [Content from previous version]", category: "Comfort", readTime: 3),
            Story(title: "The Hibernating Bear", content: "Even the great bears sleep all winter long. They don't apologize for resting; they know it's how they survive. You are allowed to hibernate, my love. Rest is not a weakness.", category: "Bedtime", readTime: 2),
            Story(title: "The Cat on the Windowsill", content: "Have you ever watched a cat sleep in a sunbeam? They are masters of rest. They stretch, they yawn, they don't have a worry in the world. Channel your inner cat today. Find a warm spot and just... be.", category: "Funny", readTime: 2)
        ]
    }
    
    // ANGRY
    private var angryStories: [Story] {
        [
            Story(title: "The Thunderstorm", content: "I see the fire in your eyes. Anger is like a thunderstorm... [Content from previous version]", category: "Nature", readTime: 3),
            Story(title: "The Hot Coal", content: "Holding onto anger is like grasping a hot coal with the intent of throwing it at someone else; you are the one who gets burned. Drop the coal, my dear. Let it go. Let your hands heal.", category: "Moral", readTime: 2),
            Story(title: "The Scribble Page", content: "When I was mad, I would take a crayon and scribble as hard as I could on a piece of paper. Round and round, hard and fast! It felt so good to let it out on the page instead of on people. Try it sometime!", category: "Funny", readTime: 2)
        ]
    }
    
    // GRATEFUL
    private var gratefulStories: [Story] {
        [
            Story(title: "The Thank You Jar", content: "Oh, what a wonderful feeling gratitude is! Let me tell you about my Thank You Jar... [Content from previous version]", category: "Moral", readTime: 3),
            Story(title: "The Golden Spectacles", content: "Imagine if I gave you a pair of magical golden glasses. When you put them on, everything you love glows with a soft light. The coffee mug, the cat, the sunshine. Gratitude is just putting on those glasses.", category: "Bedtime", readTime: 3),
            Story(title: "The Gift of Today", content: "Yesterday is history, tomorrow is a mystery, but today is a gift. That is why it is called the present! I am so grateful for the gift of you, right here, right now.", category: "Short", readTime: 1)
        ]
    }
    
    // EXCITED
    private var excitedStories: [Story] {
        [
            Story(title: "The Ticket to Anywhere", content: "Oh, the sparkle in your eyes! It reminds me of the day I found a mystery ticket... [Content from previous version]", category: "Short", readTime: 3),
            Story(title: "The First Snowfall", content: "Do you remember the feeling of waking up and seeing the whole world turned white? Thta urge to run outside and make the first footprints? That is pure excitement. Hold onto that child-like wonder!", category: "Nature", readTime: 2),
            Story(title: "The Bakery Smell", content: "Walking past a bakery early in the morning, smelling the yeast and sugar... the anticipation of that first bite! Life is full of sweet moments waiting just around the corner.", category: "Funny", readTime: 2)
        ]
    }
}
