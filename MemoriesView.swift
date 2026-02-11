import SwiftUI

public struct MemoriesView: View {
    public init() {}
    @ObservedObject var storyManager = StoryManager.shared
    
    var savedStories: [Story] {
        storyManager.likedStoryIDs.compactMap { id in
            storyManager.getStory(id: id)
        }
    }
    
    public var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            if savedStories.isEmpty {
                VStack {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 60))
                        .foregroundStyle(Color.themeAccent.opacity(0.5))
                        .padding()
                    
                    Text("No saved memories yet.")
                        .font(.title2)
                        .foregroundStyle(Color.themeText)
                    
                    Text("Tap the heart icon on a story to save it here.")
                        .font(.subheadline)
                        .foregroundStyle(Color.themeText.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding()
                }
            } else {
                List(savedStories) { story in
                    NavigationLink(destination: StoryView(mood: Mood.allMoods[0], storyToLoad: story)) {
                        VStack(alignment: .leading) {
                            Text(story.title)
                                .font(.headline)
                                .foregroundStyle(Color.themeText)
                            
                            Text(story.content.prefix(100) + "...")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                        }
                        .padding(.vertical, 8)
                    }
                    .listRowBackground(Color.white.opacity(0.5))
                }
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("Saved Memories")
    }
}

