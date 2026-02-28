import Foundation
import SwiftUI

struct GrowthNode: Identifiable {
    let id = UUID()
    let titleKey: L10nKey
    let descKey: L10nKey
    let isCompleted: Bool
    let category: String
    let icon: String

    var title: String { L10n.t(titleKey) }

    var description: String { L10n.t(descKey) }
}

class GrowthTrackerManager: ObservableObject {
    @Published var emotionalScore: Int = 10
    @Published var completedPaths: Int = 0

    @Published var nodes: [GrowthNode] = [
        GrowthNode(titleKey: .growthNode1Title, descKey: .growthNode1Desc, isCompleted: true,  category: "Patience",    icon: "leaf"),
        GrowthNode(titleKey: .growthNode2Title, descKey: .growthNode2Desc, isCompleted: true,  category: "Courage",     icon: "flame"),
        GrowthNode(titleKey: .growthNode3Title, descKey: .growthNode3Desc, isCompleted: false, category: "Forgiveness", icon: "wind"),
        GrowthNode(titleKey: .growthNode4Title, descKey: .growthNode4Desc, isCompleted: false, category: "Joy",         icon: "sun.max"),
        GrowthNode(titleKey: .growthNode5Title, descKey: .growthNode5Desc, isCompleted: false, category: "Wisdom",      icon: "tree"),
    ]

    func completeNode(id: UUID) {
        if let index = nodes.firstIndex(where: { $0.id == id }) {
            let node = nodes[index]
            nodes[index] = GrowthNode(
                titleKey: node.titleKey,
                descKey: node.descKey,
                isCompleted: true,
                category: node.category,
                icon: node.icon
            )
            emotionalScore += 10
            completedPaths += 1
        }
    }
}