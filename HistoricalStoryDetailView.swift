import SwiftUI

struct HistoricalStoryDetailView: View {
    let story: HistoricalStory
    @State private var journalEntry: String = ""
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var audioService = AudioService.shared
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header Image Placeholder / Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 16) // 24 -> 16
                        .fill(LinearGradient(colors: [Color.themeRose, Color.themeWarm], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 140) // 200 -> 140
                    
                    Image(systemName: story.iconName)
                        .font(.system(size: 60)) // 80 -> 60
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Title & Era
                VStack(alignment: .leading, spacing: 4) { // 8 -> 4
                    Text(story.title)
                        .font(.granlyTitle2) // Title -> Title2
                        .foregroundStyle(Color.themeText)
                    
                    Text(story.era)
                        .font(.granlyCaption) // Subheadline -> Caption
                        .foregroundStyle(Color.themeRose)
                }
                .padding(.horizontal)
                
                // What Happened
                VStack(alignment: .leading, spacing: 8) { // 12 -> 8
                    HistoricalSectionHeader(title: "What Happened", icon: "book.fill")
                    
                    Text(story.summary)
                        .font(.granlyBody)
                        .lineSpacing(4) // 6 -> 4
                        .foregroundStyle(Color.themeText.opacity(0.9))
                }
                .padding(.horizontal)
                
                // Lessons Extracted
                VStack(alignment: .leading, spacing: 12) {
                    HistoricalSectionHeader(title: "Life Lessons", icon: "sparkles")
                    
                    ForEach(story.lessons, id: \.self) { lesson in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "leaf.fill")
                                .foregroundStyle(Color.themeGreen)
                                .padding(.top, 2)
                            
                            Text(lesson)
                                .font(.granlyBody)
                                .foregroundStyle(Color.themeText)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding(16) // 20 -> 16
                .background(Color.themeGreen.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16)) // 20 -> 16
                .padding(.horizontal)
                
                // Grandma's Reflection
                VStack(alignment: .leading, spacing: 12) {
                    HistoricalSectionHeader(title: "Grandma Asks...", icon: "person.2.fill")
                    
                    ForEach(story.reflectionQuestions, id: \.self) { question in
                        Text("🤔 " + question)
                            .font(.body.italic())
                            .foregroundStyle(Color.themeText)
                            .padding(.vertical, 4)
                    }
                }
                .padding(.horizontal)
                
                // Personal Growth Takeaway
                VStack(alignment: .center, spacing: 12) {
                    Text("🌱 Growth Takeaway")
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                    
                    Text("\"\(story.personalGrowthTakeaway)\"")
                        .font(.title3.italic())
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .foregroundStyle(Color.themeText)
                }
                .frame(maxWidth: .infinity)
                .padding(16) // 24 -> 16
                .background(Color.themeWarm.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 16)) // 20 -> 16
                .padding(.horizontal)
                
                // Journal Input
                VStack(alignment: .leading, spacing: 12) {
                    HistoricalSectionHeader(title: "Your Reflection", icon: "pencil")
                    
                    TextEditor(text: $journalEntry)
                        .frame(height: 120)
                        .padding(12)
                        .background(Color.white.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                        )
                }
                .padding(20)
                .background(Color.themeBackground)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.black.opacity(0.05), radius: 10)
                .padding(.horizontal)
                
                // Next Steps Linking
                VStack(spacing: 12) {
                    Text("Continue Your Journey")
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                        .padding(.top, 10)
                    
                    NavigationLink(destination: AskGrandmaView()) {
                        DetailActionRow(title: "Talk to Grandma about this", icon: "person.wave.2.fill")
                    }
                    
                    NavigationLink(destination: GrowthPathView()) {
                        DetailActionRow(title: "Update your Growth Path", icon: "chart.line.uptrend.xyaxis")
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .background(Color.themeBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.themeText)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Button(action: {
                        favoritesManager.toggleHistoricalStory(story)
                    }) {
                        Image(systemName: favoritesManager.isFavorite(story) ? "heart.fill" : "heart")
                            .foregroundStyle(Color.themeRose)
                    }
                    
                    Button(action: {
                        let textToRead = "\(story.title). \(story.summary) Lessons. \(story.lessons.joined(separator: ". "))"
                        audioService.readText(textToRead)
                    }) {
                        Image(systemName: audioService.isPlaying ? "stop.fill" : "speaker.wave.2.fill")
                            .foregroundStyle(audioService.isPlaying ? Color.red : Color.themeRose)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onDisappear {
            audioService.stopAudio()
        }
    }
}

struct HistoricalSectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(Color.themeRose)
            Text(title)
                .font(.granlyHeadline)
                .foregroundStyle(Color.themeText)
        }
    }
}

// Private helper to avoid re-declaring ActionRow which exists in the main hub
private struct DetailActionRow: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(Color.themeRose)
            
            Text(title)
                .font(.granlySubheadline)
                .foregroundStyle(Color.themeText)
            
            Spacer()
            
            Image(systemName: "chevron.right.circle.fill")
                .foregroundStyle(Color.themeText.opacity(0.5))
                .font(.granlyHeadline)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(Color.white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NavigationView {
        HistoricalStoryDetailView(story: HistoricalStoriesData.top10Stories[0])
    }
}
