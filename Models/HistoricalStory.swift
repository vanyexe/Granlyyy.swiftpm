import Foundation
import SwiftUI

struct HistoricalStory: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let era: String
    let summary: String
    let lessons: [String]
    let reflectionQuestions: [String]
    let personalGrowthTakeaway: String
    let iconName: String
    
    init(id: UUID = UUID(), title: String, era: String, summary: String, lessons: [String], reflectionQuestions: [String], personalGrowthTakeaway: String, iconName: String = "globe") {
        self.id = id
        self.title = title
        self.era = era
        self.summary = summary
        self.lessons = lessons
        self.reflectionQuestions = reflectionQuestions
        self.personalGrowthTakeaway = personalGrowthTakeaway
        self.iconName = iconName
    }
}
