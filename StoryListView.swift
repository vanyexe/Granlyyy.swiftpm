import SwiftUI

struct StoryListView: View {
    let mood: Mood
    @ObservedObject var storyManager = StoryManager.shared
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var lang: LanguageManager

    // Use index-based selection so it survives language switches
    @State private var selectedCategoryIndex: Int = 0

    private var categoryKeys: [L10nKey] {
        [.allCategory, .shortCategory, .moralCategory, .bedtimeCategory, .funnyCategory]
    }
    // Raw English values for filtering story data (invariant)
    private let categoryValues = ["All", "Short", "Moral", "Bedtime", "Funny"]

    var filteredStories: [Story] {
        let stories = storyManager.getStories(for: mood)
        if selectedCategoryIndex == 0 { return stories }
        return stories.filter { $0.category == categoryValues[selectedCategoryIndex] }
    }
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.granlyHeadline) // Title2 -> Headline for a smaller back button
                            .foregroundStyle(Color.themeText)
                            .frame(width: 36, height: 36) // 44 -> 36
                            .glassCard(cornerRadius: 12)
                    }
                    Spacer()
                    Text("\(mood.localizedName(for: lang.selectedLanguage)) \(L10n.t(.storiesLabel))")
                        .font(.granlyTitle2)
                        .foregroundStyle(Color.themeText)
                    Spacer()
                    // Hidden balance
                    Color.clear.frame(width: 36, height: 36)
                }
                .padding()
                
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(0..<categoryKeys.count, id: \.self) { idx in
                            Button(action: { selectedCategoryIndex = idx }) {
                                Text(L10n.t(categoryKeys[idx]))
                                    .font(.granlyBodyBold)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 6)
                                    .background(selectedCategoryIndex == idx ? mood.baseColor : Color.clear)
                                    .foregroundStyle(selectedCategoryIndex == idx ? .white : Color.themeText)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(mood.baseColor.opacity(0.3), lineWidth: 1))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                }
                
                // Story List
                ScrollView {
                    LazyVStack(spacing: 12) { // 16 -> 12
                        ForEach(filteredStories) { story in
                            NavigationLink(destination: StoryView(mood: mood, storyToLoad: story)) {
                                StoryListRow(story: story, moodColor: mood.baseColor)
                            }
                        }
                    }
                    .padding(.horizontal) // Just horizontal padding to tighten list
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
    @EnvironmentObject var lang: LanguageManager   // needed so SwiftUI re-renders on language change
    var body: some View {
        HStack(spacing: 12) { // 16 -> 12
            // Icon / Category Badge
            ZStack {
                Circle()
                    .fill(moodColor.opacity(0.15))
                    .frame(width: 40, height: 40) // 50 -> 40
                Image(systemName: getIcon(for: story.category))
                    .foregroundStyle(moodColor)
                    .font(.granlySubheadline) // Headline -> Subheadline
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(story.title)
                    .font(.granlyBodyBold) // Headline -> BodyBold
                    .foregroundStyle(Color.themeText)
                    .lineLimit(1)
                
                HStack {
                    Text(L10n.t(categoryKey(for: story.category)).uppercased())
                        .font(.system(size: 9, weight: .bold, design: .rounded))
                        .tracking(0.5)
                        .font(.granlyCaption)
                        .foregroundStyle(moodColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .clipShape(Capsule()) // 4px Radius -> Pill capsule
                    
                    Text("• \(story.readTime) \(L10n.t(.minRead))")
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
        .padding(14) // 16 -> 14
        .glassCard(cornerRadius: 14) // 16 -> 14
    }
    
    func categoryKey(for category: String) -> L10nKey {
        switch category {
        case "Short":   return .shortCategory
        case "Moral":   return .moralCategory
        case "Bedtime": return .bedtimeCategory
        case "Funny":   return .funnyCategory
        case "Nature":  return .natureCategory
        case "Comfort": return .comfortCategory
        default:        return .allCategory
        }
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
