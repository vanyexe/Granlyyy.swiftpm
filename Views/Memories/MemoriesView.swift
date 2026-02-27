import SwiftUI

@MainActor
public struct MemoriesView: View {
    public init() {}
    @ObservedObject var storyManager = StoryManager.shared
    @EnvironmentObject var lang: LanguageManager
    
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
                    VStack(alignment: .leading, spacing: 6) {
                        Text(L10n.t(.savedMemoriesTitle))
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.themeText)
                        
                        if !savedStories.isEmpty {
                            Text(L10n.tf(.storiesSavedCount, savedStories.count))
                                .font(.granlySubheadline)
                                .foregroundStyle(Color.themeRose)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 12)
                
                if savedStories.isEmpty {
                    VStack(spacing: 16) {
                        Spacer().frame(height: 60)
                        Image(systemName: "heart.slash")
                            .font(.system(size: 48, weight: .light))
                            .foregroundStyle(Color.themeRose.opacity(0.5))
                        
                        Text(L10n.t(.noMemoriesYet))
                            .font(.granlyHeadline)
                            .foregroundStyle(Color.themeText)
                        
                        Text(L10n.t(.noMemoriesBody))
                            .font(.granlyBody)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
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
                    .frame(width: 48, height: 48) // 52 -> 48
                
                Image(systemName: "book.closed.fill")
                    .font(.granlyHeadline) // Title2 -> Headline
                    .foregroundStyle(Color.themeText)
            }
            
            VStack(alignment: .leading, spacing: 2) { // 4 -> 2
                Text(story.title)
                    .font(.granlyBodyBold) // Headline -> BodyBold
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
        .glassCard(cornerRadius: 16) // 20 -> 16
    }
}
