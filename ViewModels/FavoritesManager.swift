import SwiftUI
import Combine

@MainActor
final class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()

    @Published var favoriteHistoricalStoryIDs: Set<String> = []

    private let favoriteHistoricalKey = "FavoriteHistoricalStoryIDs"

    init() {
        loadFavorites()
    }

    private func loadFavorites() {
        if let savedHistorical = UserDefaults.standard.array(forKey: favoriteHistoricalKey) as? [String] {
            favoriteHistoricalStoryIDs = Set(savedHistorical)
        }
    }

    private func saveFavorites() {
        UserDefaults.standard.set(Array(favoriteHistoricalStoryIDs), forKey: favoriteHistoricalKey)
    }

    func toggleHistoricalStory(_ story: HistoricalStory) {
        if favoriteHistoricalStoryIDs.contains(story.iconName) {
            favoriteHistoricalStoryIDs.remove(story.iconName)
        } else {
            favoriteHistoricalStoryIDs.insert(story.iconName)
        }
        saveFavorites()
    }

    func isFavorite(_ story: HistoricalStory) -> Bool {
        favoriteHistoricalStoryIDs.contains(story.iconName) || favoriteHistoricalStoryIDs.contains(story.title)
    }
}