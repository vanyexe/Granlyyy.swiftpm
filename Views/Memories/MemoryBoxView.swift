import SwiftUI

@MainActor
struct MemoryBoxView: View {
    @ObservedObject var favoritesManager = FavoritesManager.shared
    @ObservedObject var storyManager = StoryManager.shared
    @AppStorage("selectedLanguage") private var selectedLanguage: String = AppLanguage.english.rawValue
    @EnvironmentObject var lang: LanguageManager

    private var historicalStories: [HistoricalStory] {
        HistoricalStoriesData.top10Stories(for: lang.selectedLanguage)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBackground.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LinearGradient(colors: [Color.themeWarm, Color.themeGold], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(height: 160)

                            VStack {
                                Image(systemName: "archivebox.fill")
                                    .font(.system(size: 52))
                                    .foregroundStyle(.white)
                                    .shadow(color: .black.opacity(0.2), radius: 5, y: 5)

                                Text(L10n.t(.grandmasMemoryBox))
                                    .font(.granlyTitle2)
                                    .foregroundStyle(.white)
                                    .padding(.top, 4)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)

                        if favoritesManager.favoriteHistoricalStoryIDs.isEmpty && storyManager.likedStoryIDs.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "heart.slash")
                                    .font(.system(size: 48))
                                    .foregroundStyle(Color.themeRose.opacity(0.5))
                                Text(L10n.t(.emptyMemoryBox))
                                    .font(.granlyTitle2)
                                    .foregroundStyle(Color.themeText.opacity(0.8))
                                Text(L10n.t(.emptyMemoryBoxHint))
                                    .font(.granlyCaption)
                                    .foregroundStyle(Color.themeText.opacity(0.6))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 40)
                            .padding(.horizontal, 24)
                        } else {

                            if !storyManager.likedStoryIDs.isEmpty {
                                SectionHeaderTitle(title: L10n.t(.savedStories), icon: "moon.stars.fill", color: .themeRose)

                                let likedStories = storyManager.likedStoryIDs.compactMap { id in

                                    StoryManager.shared.getAllStories().first { $0.title == id }
                                }

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(likedStories, id: \.title) { story in

                                            SavedStoryCard(title: story.title, category: story.category, color: .themeRose)
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom, 10)
                                }
                            }

                            if !favoritesManager.favoriteHistoricalStoryIDs.isEmpty {
                                SectionHeaderTitle(title: L10n.t(.historicalStories), icon: "globe.americas.fill", color: .themeGreen)

                                VStack(spacing: 12) {
                                    ForEach(Array(favoritesManager.favoriteHistoricalStoryIDs), id: \.self) { id in
                                        if let story = historicalStories.first(where: { $0.iconName == id || $0.title == id }) {
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
            .navigationTitle(L10n.t(.memories))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct SectionHeaderTitle: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(color)
            Text(title)
                .font(.granlyTitle2)
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
                .frame(width: 36, height: 36)
                .overlay(
                    Image(systemName: "heart.fill")
                        .font(.granlySubheadline)
                        .foregroundStyle(color)
                )

            Spacer()

            Text(title)
                .font(.granlyHeadline)
                .foregroundStyle(Color.themeText)
                .lineLimit(2)

            Text(category.uppercased())
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .tracking(1)
                .foregroundStyle(color)
        }
        .padding(16)
        .frame(width: 140, height: 150)
        .glassCard(cornerRadius: 18)
    }
}

struct SavedHistoricalRow: View {
    let story: HistoricalStory

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Rectangle()
                    .fill(Color.themeGreen.opacity(0.2))
                    .frame(width: 52, height: 52)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Image(systemName: story.iconName)
                    .font(.granlyHeadline)
                    .foregroundStyle(Color.themeGreen)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(story.title)
                    .font(.granlyHeadline)
                    .foregroundStyle(Color.themeText)
                    .lineLimit(1)

                Text(story.era)
                    .font(.granlyCaption)
                    .foregroundStyle(Color.themeText.opacity(0.6))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.granlySubheadline)
                .foregroundStyle(Color.themeText.opacity(0.3))
                .padding(.trailing, 4)
        }
        .padding(14)
        .glassCard(cornerRadius: 18)
    }
}

#Preview {
    MemoryBoxView()
}