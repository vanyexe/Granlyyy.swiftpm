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
            MeshGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Saved Memories")
                            .font(.granlyTitle)
                            .foregroundStyle(Color.themeText)
                        Text("\(savedStories.count) stories saved 💛")
                            .font(.granlySubheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 12)
                
                if savedStories.isEmpty {
                    Spacer()
                    // Beautiful empty state
                    VStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(Color.themeRose.opacity(0.1))
                                .frame(width: 140, height: 140)
                                .blur(radius: 20)
                            
                            VStack(spacing: 8) {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundStyle(Color.themeText.opacity(0.8))
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 30))
                                    .foregroundStyle(Color.themeRose)
                                    .offset(x: 20, y: -20)
                            }
                        }
                        
                        Text("No memories yet")
                            .font(.granlyTitle)
                            .foregroundStyle(Color.themeText)
                        
                        Text("When grandma tells you a story you love,\ntap the heart to save it here forever.")
                            .font(.granlySubheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                        
                        Image(systemName: "heart.slash")
                            .font(.granlyTitle)
                            .foregroundStyle(Color.themeRose.opacity(0.3))
                            .padding(.top, 8)
                    }
                    .padding(40)
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 14) {
                            ForEach(savedStories) { story in
                                NavigationLink(destination: StoryView(mood: Mood.allMoods[0], storyToLoad: story)) {
                                    MemoryCard(story: story, storyManager: storyManager)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 100)
                    }
                }
            }
        }
    }
}

struct MemoryCard: View {
    let story: Story
    let storyManager: StoryManager
    
    var body: some View {
        HStack(spacing: 14) {
            // Warm gradient icon
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: [Color.themeRose.opacity(0.3), Color.themeWarm.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 52, height: 52)
                
                Image(systemName: "book.closed.fill")
                    .font(.granlyTitle2)
                    .foregroundStyle(Color.themeText)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(story.title)
                    .font(.granlyHeadline)
                    .foregroundStyle(Color.themeText)
                    .lineLimit(1)
                
                Text(story.content.prefix(60) + "...")
                    .font(.granlyCaption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            // Heart toggle
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    storyManager.toggleLike(for: story)
                }
            }) {
                Image(systemName: storyManager.isLiked(story: story) ? "heart.fill" : "heart")
                    .font(.granlyHeadline)
                    .foregroundStyle(storyManager.isLiked(story: story) ? Color.themeRose : .secondary)
            }
        }
        .padding(14)
        .glassCard(cornerRadius: 20)
    }
}
