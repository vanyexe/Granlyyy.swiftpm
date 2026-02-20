import SwiftUI

struct StoryListView: View {
    let mood: Mood
    @ObservedObject var storyManager = StoryManager.shared
    @Environment(\.dismiss) private var dismiss
    
    // Filter by Category
    @State private var selectedCategory: String = "All"
    let categories = ["All", "Short", "Moral", "Bedtime", "Funny"]
    
    var filteredStories: [Story] {
        let stories = storyManager.getStories(for: mood)
        if selectedCategory == "All" { return stories }
        return stories.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.granlyTitle2)
                            .foregroundStyle(Color.themeText)
                            .frame(width: 44, height: 44)
                            .glassCard(cornerRadius: 12)
                    }
                    Spacer()
                    Text("\(mood.name) Stories")
                        .font(.granlyTitle2)
                        .foregroundStyle(Color.themeText)
                    Spacer()
                    // Hidden balance
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding()
                
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: { selectedCategory = category }) {
                                Text(category)
                                    .font(.granlySubheadline)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedCategory == category ? mood.baseColor : Color.clear)
                                    .foregroundStyle(selectedCategory == category ? .white : Color.themeText)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(mood.baseColor.opacity(0.3), lineWidth: 1))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                }
                
                // Story List
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredStories) { story in
                            NavigationLink(destination: StoryView(mood: mood, storyToLoad: story)) {
                                StoryListRow(story: story, moodColor: mood.baseColor)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct StoryListRow: View {
    let story: Story
    let moodColor: Color
    @ObservedObject var storyManager = StoryManager.shared
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon / Category Badge
            ZStack {
                Circle()
                    .fill(moodColor.opacity(0.15))
                    .frame(width: 50, height: 50)
                Image(systemName: getIcon(for: story.category))
                    .foregroundStyle(moodColor)
                    .font(.granlyHeadline)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(story.title)
                    .font(.granlyHeadline)
                    .foregroundStyle(Color.themeText)
                    .lineLimit(1)
                
                HStack {
                    Text(story.category)
                        .font(.granlyCaption)
                        .foregroundStyle(moodColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(moodColor.opacity(0.1))
                        .cornerRadius(4)
                    
                    Text("• \(story.readTime) min read")
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            // Like Button
            Button(action: {
                withAnimation {
                    storyManager.toggleLike(for: story)
                }
            }) {
                Image(systemName: storyManager.isLiked(story: story) ? "heart.fill" : "heart")
                    .foregroundStyle(storyManager.isLiked(story: story) ? Color.themeRose : .gray.opacity(0.4))
                    .font(.granlyHeadline)
            }
        }
        .padding()
        .glassCard(cornerRadius: 16)
    }
    
    func getIcon(for category: String) -> String {
        switch category {
        case "Moral": return "star.fill"
        case "Funny": return "face.smiling.fill"
        case "Bedtime": return "moon.stars.fill"
        default: return "book.fill"
        }
    }
}
