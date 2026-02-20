import SwiftUI

struct MemoryBoxView: View {
    @ObservedObject var favoritesManager = FavoritesManager.shared
    @ObservedObject var storyManager = StoryManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Header Image showing a wooden box or memory jar
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LinearGradient(colors: [Color.themeWarm, Color.themeGold], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(height: 180)
                            
                            VStack {
                                Image(systemName: "archivebox.fill")
                                    .font(.system(size: 60))
                                    .foregroundStyle(.white)
                                    .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
                                
                                Text("Grandma's Memory Box")
                                    .font(.title2.bold().design(.serif))
                                    .foregroundStyle(.white)
                                    .padding(.top, 8)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        if favoritesManager.favoriteHistoricalStoryIDs.isEmpty && storyManager.likedStoryIDs.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "heart.slash")
                                    .font(.largeTitle)
                                    .foregroundStyle(Color.themeRose.opacity(0.5))
                                Text("Your Memory Box is empty.")
                                    .font(.headline)
                                    .foregroundStyle(Color.themeText.opacity(0.8))
                                Text("Tap the heart icon on your favorite stories and quotes to keep them safe in here.")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.themeText.opacity(0.6))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 60)
                            .padding(.horizontal, 40)
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

struct SectionHeaderTitle: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(color)
            Text(title)
                .font(.title3.bold().design(.serif))
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
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "heart.fill")
                        .foregroundStyle(color)
                )
            
            Spacer()
            
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.themeText)
                .lineLimit(2)
            
            Text(category)
                .font(.caption.bold())
                .foregroundStyle(color)
        }
        .padding(16)
        .frame(width: 150, height: 160)
        .background(Color.themeCard)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
    }
}

struct SavedHistoricalRow: View {
    let story: HistoricalStory
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Rectangle()
                    .fill(Color.themeGreen.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Image(systemName: story.iconName)
                    .font(.title2)
                    .foregroundStyle(Color.themeGreen)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(story.title)
                    .font(.headline)
                    .foregroundStyle(Color.themeText)
                    .lineLimit(1)
                
                Text(story.era)
                    .font(.subheadline)
                    .foregroundStyle(Color.themeText.opacity(0.6))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.themeText.opacity(0.3))
                .padding(.trailing, 8)
        }
        .padding(12)
        .background(Color.themeCard)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
    }
}

#Preview {
    MemoryBoxView()
}
