import SwiftUI

struct HistoricalStoryDetailView: View {
    let story: HistoricalStory
    @State private var journalEntry: String = ""
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var audioService = AudioService.shared
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(colors: [Color.themeRose, Color.themeWarm], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 140)

                    Image(systemName: story.iconName)
                        .font(.system(size: 60))
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding(.horizontal)
                .padding(.top, 10)

                VStack(alignment: .leading, spacing: 4) {
                    Text(story.title)
                        .font(.granlyTitle2)
                        .foregroundStyle(Color.themeText)

                    Text(story.era)
                        .font(.granlyCaption)
                        .foregroundStyle(Color.themeRose)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    HistoricalSectionHeader(title: L10n.t(.whatHappened), icon: "book.fill")

                    Text(story.summary)
                        .font(.granlyBody)
                        .lineSpacing(4)
                        .foregroundStyle(Color.themeText.opacity(0.9))
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    HistoricalSectionHeader(title: L10n.t(.lifeLessons), icon: "sparkles")

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
                .padding(16)
                .background(Color.themeGreen.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    HistoricalSectionHeader(title: L10n.t(.grandmaAsks), icon: "person.2.fill")

                    ForEach(story.reflectionQuestions, id: \.self) { question in
                        HStack(alignment: .top) {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundStyle(Color.themeRose)
                            Text(question)
                                .font(.body.italic())
                                .foregroundStyle(Color.themeText)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding(.horizontal)

                VStack(alignment: .center, spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "leaf.fill")
                            .foregroundStyle(Color.themeGreen)
                        Text(L10n.t(.growthTakeaway))
                            .font(.granlyHeadline)
                            .foregroundStyle(Color.themeText)
                    }

                    Text("\"\(story.personalGrowthTakeaway)\"")
                        .font(.title3.italic())
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .foregroundStyle(Color.themeText)
                }
                .frame(maxWidth: .infinity)
                .padding(16)
                .background(Color.themeWarm.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    HistoricalSectionHeader(title: L10n.t(.yourReflection), icon: "pencil")

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

                VStack(spacing: 12) {
                    Text(L10n.t(.continueYourJourney))
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                        .padding(.top, 10)

                    NavigationLink(destination: AskGrandmaView()) {
                        DetailActionRow(title: L10n.t(.talkGrandmaAboutThis), icon: "person.wave.2.fill")
                    }

                    NavigationLink(destination: GrowthPathView()) {
                        DetailActionRow(title: L10n.t(.updateGrowthPath), icon: "chart.line.uptrend.xyaxis")
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
        HistoricalStoryDetailView(story: HistoricalStoriesData.top10Stories(for: .english)[0])
    }
}