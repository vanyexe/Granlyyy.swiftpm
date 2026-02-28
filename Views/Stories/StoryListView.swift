import SwiftUI

struct StoryListView: View {
    let mood: Mood
    @ObservedObject var storyManager = StoryManager.shared
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var lang: LanguageManager

    @State private var selectedCategoryIndex: Int = 0

    private var categoryKeys: [L10nKey] {
        [.allCategory, .shortCategory, .moralCategory, .bedtimeCategory, .funnyCategory]
    }

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

                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.granlyHeadline)
                            .foregroundStyle(Color.themeText)
                            .frame(width: 44, height: 44)
                            .glassCard(cornerRadius: 14)
                    }
                    Spacer()
                    Text("\(mood.localizedName(for: lang.selectedLanguage)) \(L10n.t(.storiesLabel))")
                        .font(.granlyTitle2)
                        .foregroundStyle(Color.themeText)
                    Spacer()

                    Color.clear.frame(width: 44, height: 44)
                }
                .padding()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(0..<categoryKeys.count, id: \.self) { idx in
                            Button(action: { selectedCategoryIndex = idx }) {
                                Text(L10n.t(categoryKeys[idx]))
                                    .font(.granlyBodyBold)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 8)
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

                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredStories) { story in
                            NavigationLink(destination: StoryView(mood: mood, storyToLoad: story)) {
                                StoryListRow(story: story, moodColor: mood.baseColor)
                            }
                        }
                    }
                    .padding(.horizontal)
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
    @EnvironmentObject var lang: LanguageManager
    var body: some View {
        HStack(spacing: 12) {

            ZStack {
                Circle()
                    .fill(moodColor.opacity(0.15))
                    .frame(width: 48, height: 48)
                Image(systemName: getIcon(for: story.category))
                    .foregroundStyle(moodColor)
                    .font(.system(size: 18))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(story.title)
                    .font(.granlyBodyBold)
                    .foregroundStyle(Color.themeText)
                    .lineLimit(1)

                HStack {
                    Text(L10n.t(categoryKey(for: story.category)).uppercased())
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .tracking(0.6)
                        .foregroundStyle(moodColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .clipShape(Capsule())

                    Text("• \(story.readTime) \(L10n.t(.minRead))")
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

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
        .padding(14)
        .glassCard(cornerRadius: 14)
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