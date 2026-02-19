import Foundation
import SwiftUI

struct GrowthNode: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let isCompleted: Bool
    let category: String
    let icon: String
}

class GrowthTrackerManager: ObservableObject {
    @Published var emotionalScore: Int = 10
    @Published var completedPaths: Int = 0
    
    // Hardcoded path nodes
    @Published var nodes: [GrowthNode] = [
        GrowthNode(title: "Seed of Patience", description: "Learn to sit with uncertainty.", isCompleted: true, category: "Patience", icon: "leaf"),
        GrowthNode(title: "Sprout of Courage", description: "Face a fear, no matter how small.", isCompleted: true, category: "Courage", icon: "flame"),
        GrowthNode(title: "Branch of Forgiveness", description: "Let go of a past grievance.", isCompleted: false, category: "Forgiveness", icon: "wind"),
        GrowthNode(title: "Bloom of Joy", description: "Find happiness in the mundane.", isCompleted: false, category: "Joy", icon: "sun.max"),
        GrowthNode(title: "Roots of Wisdom", description: "Reflect on a past failure.", isCompleted: false, category: "Wisdom", icon: "tree")
    ]
    
    func completeNode(id: UUID) {
        if let index = nodes.firstIndex(where: { $0.id == id }) {
            let node = nodes[index]
            nodes[index] = GrowthNode(
                title: node.title,
                description: node.description,
                isCompleted: true,
                category: node.category,
                icon: node.icon
            )
            emotionalScore += 10
            completedPaths += 1
        }
    }
}
