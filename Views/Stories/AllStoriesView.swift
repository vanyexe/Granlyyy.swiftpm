import SwiftUI

@MainActor
struct AllStoriesView: View {
    @EnvironmentObject var lang: LanguageManager
    @ObservedObject private var storyManager = StoryManager.shared
    @Environment(\.dismiss) private var dismiss

    let moods = Mood.allMoods

    @State private var selectedMood: Mood? = nil
    @State private var selectedCategory: String = "All"

    private let categories = ["All", "Short", "Moral", "Bedtime", "Funny", "Nature", "Comfort"]
    private let categoryKeys: [String: L10nKey] = [
        "All":     .allCategory,
        "Short":   .shortCategory,
        "Moral":   .moralCategory,
        "Bedtime": .bedtimeCategory,
        "Funny":   .funnyCategory,
        "Nature":  .natureCategory,
        "Comfort": .comfortCategory,
    ]

    private var filteredStories: [(story: Story, mood: Mood)] {
        let source: [(story: Story, mood: Mood)]
        if let mood = selectedMood {
            source = storyManager.getStories(for: mood).map { ($0, mood) }
        } else {
            source = moods.flatMap { mood in
                storyManager.getStories(for: mood).map { ($0, mood) }
            }
        }
        guard selectedCategory != "All" else { return source }
        return source.filter { $0.story.category == selectedCategory }
    }

    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                            .foregroundStyle(Color.themeText)
                            .frame(width: 36, height: 36)
                            .glassCard(cornerRadius: 12)
                    }
                    Spacer()
                    Text(L10n.t(.featuredSeeAll))
                        .font(.granlyTitle2)
                        .foregroundStyle(Color.themeText)
                    Spacer()

                    Color.clear.frame(width: 36, height: 36)
                }
                .padding()
                .background(.ultraThinMaterial)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {

                        MoodFilterChip(
                            label: L10n.t(.allCategory),
                            color: Color.themeRose,
                            isSelected: selectedMood == nil
                        ) { selectedMood = nil }

                        ForEach(moods) { mood in
                            MoodFilterChip(
                                label: mood.localizedName(for: lang.selectedLanguage),
                                color: mood.baseColor,
                                isSelected: selectedMood?.id == mood.id
                            ) { selectedMood = mood }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .background(.ultraThinMaterial)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories, id: \.self) { cat in
                            let label = L10n.t(categoryKeys[cat] ?? .allCategory)
                            let accentColor = selectedMood?.baseColor ?? Color.themeRose
                            Button(action: { selectedCategory = cat }) {
                                Text(label)
                                    .font(.granlyBodyBold)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 6)
                                    .background(selectedCategory == cat ? accentColor : Color.clear)
                                    .foregroundStyle(selectedCategory == cat ? .white : Color.themeText)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(accentColor.opacity(0.3), lineWidth: 1))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }

                Divider().opacity(0.3)

                if filteredStories.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "book.closed")
                            .font(.system(size: 48))
                            .foregroundStyle(Color.themeRose.opacity(0.6))
                        Text(L10n.t(.noStoriesFound))
                            .font(.granlyBody)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(filteredStories, id: \.story.id) { item in
                                NavigationLink(destination: StoryView(mood: item.mood, storyToLoad: item.story)) {
                                    AllStoryRow(story: item.story, mood: item.mood)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

@MainActor
private struct MoodFilterChip: View {
    let label: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(isSelected ? .white : Color.themeText)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(isSelected ? color : color.opacity(0.12))
                .clipShape(Capsule())
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}

@MainActor
private struct AllStoryRow: View {
    let story: Story
    let mood: Mood
    @ObservedObject private var storyManager = StoryManager.shared
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        HStack(spacing: 14) {

            ZStack {
                Circle()
                    .fill(mood.baseColor.opacity(0.15))
                    .frame(width: 46, height: 46)
                Image(systemName: mood.icon)
                    .foregroundStyle(mood.baseColor)
                    .font(.headline)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(story.title)
                    .font(.granlyBodyBold)
                    .foregroundStyle(Color.themeText)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Text(mood.localizedName(for: lang.selectedLanguage).uppercased())
                        .font(.system(size: 9, weight: .black, design: .rounded))
                        .tracking(0.8)
                        .foregroundStyle(mood.baseColor)

                    Text("·")
                        .foregroundStyle(.secondary)

                    Text(story.category)
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary)

                    Text("·")
                        .foregroundStyle(.secondary)

                    Image(systemName: "clock")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text("\(story.readTime) \(L10n.t(.minRead))")
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Button(action: {
                withAnimation { storyManager.toggleLike(for: story) }
            }) {
                Image(systemName: storyManager.isLiked(story: story) ? "heart.fill" : "heart")
                    .foregroundStyle(storyManager.isLiked(story: story) ? Color.themeRose : .gray.opacity(0.4))
                    .font(.headline)
            }
            .buttonStyle(.plain)
        }
        .padding(14)
        .glassCard(cornerRadius: 14)
    }
}