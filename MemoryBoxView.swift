import SwiftUI

struct MemoryBoxView: View {
    @ObservedObject var favoritesManager = FavoritesManager.shared
    @ObservedObject var storyManager = StoryManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) { // 20 -> 16
                        
                        // Header Image showing a wooden box or memory jar
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LinearGradient(colors: [Color.themeWarm, Color.themeGold], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(height: 160) // 140 -> 160
                            
                            VStack {
                                Image(systemName: "archivebox.fill")
                                    .font(.system(size: 52)) // 44 -> 52
                                    .foregroundStyle(.white)
                                    .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
                                
                                Text("Grandma's Memory Box")
                                    .font(.granlyTitle2) // Title -> Title2
                                    .foregroundStyle(.white)
                                    .padding(.top, 4) // 8 -> 4
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        if favoritesManager.favoriteHistoricalStoryIDs.isEmpty && storyManager.likedStoryIDs.isEmpty {
                            VStack(spacing: 12) { // 16 -> 12
                                Image(systemName: "heart.slash")
                                    .font(.system(size: 48)) // Title2 -> 48
                                    .foregroundStyle(Color.themeRose.opacity(0.5))
                                Text("Your Memory Box is empty.")
                                    .font(.granlyTitle2) // BodyBold -> Title2
                                    .foregroundStyle(Color.themeText.opacity(0.8))
                                Text("Tap the heart icon on your favorite stories and quotes to keep them safe in here.")
                                    .font(.granlyCaption) // Subheadline -> Caption
                                    .foregroundStyle(Color.themeText.opacity(0.6))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 40) // 60 -> 40
                            .padding(.horizontal, 24) // 40 -> 24
                        } else {
                            
                            // 1. Digital Grandma Mood Stories
                            if !storyManager.likedStoryIDs.isEmpty {
                                SectionHeaderTitle(title: "Bedtime Stories", icon: "moon.stars.fill", color: .themeRose)
                                
                                // Fetch stories from IDs
                                let likedStories = storyManager.likedStoryIDs.compactMap { id in
                                    // A small hack: we flatten all stories and find by title
                                    StoryManager.shared.getAllStories().first { $0.title == id }
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(likedStories, id: \.title) { story in
                                            // Navigation to a read-only StoryView is tricky since it needs a mood. Let's just create a Simple card.
                                            SavedStoryCard(title: story.title, category: story.category, color: .themeRose)
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom, 10)
                                }
                            }
                            
                            // 2. Historical Real-World Stories
                            if !favoritesManager.favoriteHistoricalStoryIDs.isEmpty {
                                SectionHeaderTitle(title: "World History", icon: "globe.americas.fill", color: .themeGreen)
                                
                                VStack(spacing: 12) {
                                    ForEach(Array(favoritesManager.favoriteHistoricalStoryIDs), id: \.self) { id in
                                        if let story = HistoricalStoriesData.top10Stories.first(where: { $0.title == id }) {
                                            NavigationLink(destination: HistoricalStoryDetailView(story: story)) {
                                                SavedHistoricalRow(story: story)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            .navigationTitle("Memory Box")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Helper views

private struct SectionHeaderTitle: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(color)
            Text(title)
                .font(.granlyTitle2) // Title -> Title2
                .foregroundStyle(Color.themeText)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

struct SavedStoryCard: View {
    let title: String
    let category: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 36, height: 36) // 32 -> 36
                .overlay(
                    Image(systemName: "heart.fill")
                        .font(.granlySubheadline) // Add subheadline font to shrink icon
                        .foregroundStyle(color)
                )
            
            Spacer()
            
            Text(title)
                .font(.granlyHeadline) // BodyBold -> Headline
                .foregroundStyle(Color.themeText)
                .lineLimit(2)
            
            Text(category.uppercased())
                .font(.system(size: 10, weight: .bold, design: .rounded)) // Custom small tag
                .tracking(1) // Premium kerning
                .foregroundStyle(color)
        }
        .padding(16) // 14 -> 16
        .frame(width: 140, height: 150) // 130x140 -> 140x150
        .glassCard(cornerRadius: 18) // 16 -> 18
    }
}

struct SavedHistoricalRow: View {
    let story: HistoricalStory
    
    var body: some View {
        HStack(spacing: 14) { // 12 -> 14
            ZStack {
                Rectangle()
                    .fill(Color.themeGreen.opacity(0.2))
                    .frame(width: 52, height: 52) // 48 -> 52
                    .clipShape(RoundedRectangle(cornerRadius: 12)) // 10 -> 12
                
                Image(systemName: story.iconName)
                    .font(.granlyHeadline) // Title2 -> Headline
                    .foregroundStyle(Color.themeGreen)
            }
            
            VStack(alignment: .leading, spacing: 4) { // 2 -> 4
                Text(story.title)
                    .font(.granlyHeadline) // BodyBold -> Headline
                    .foregroundStyle(Color.themeText)
                    .lineLimit(1)
                
                Text(story.era)
                    .font(.granlyCaption) // Subheadline -> Caption
                    .foregroundStyle(Color.themeText.opacity(0.6))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.granlySubheadline)
                .foregroundStyle(Color.themeText.opacity(0.3))
                .padding(.trailing, 4) // 8 -> 4
        }
        .padding(14) // 12 -> 14
        .glassCard(cornerRadius: 18) // 16 -> 18
    }
}

#Preview {
    MemoryBoxView()
}
