import SwiftUI

struct HistoricalStoryListView: View {
    @State private var selectedStory: HistoricalStory?
    
    var body: some View {
        if #available(iOS 17.0, *) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Stories That Shaped Us")
                        .font(.system(size: 28, weight: .bold, design: .serif))
                        .foregroundStyle(Color.themeText)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    Text("Learn from the most impactful events in human history.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                    
                    LazyVStack(spacing: 16) {
                        ForEach(HistoricalStoriesData.top10Stories) { story in
                            Button(action: {
                                selectedStory = story
                            }) {
                                HistoricalStoryCard(story: story)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
            .background(Color.themeBackground.ignoresSafeArea())
            .navigationDestination(item: $selectedStory) { story in
                HistoricalStoryDetailView(story: story)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct HistoricalStoryCard: View {
    let story: HistoricalStory
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.themeRose.opacity(0.15))
                    .frame(width: 60, height: 60)
                
                Image(systemName: story.iconName)
                    .font(.title2)
                    .foregroundStyle(Color.themeRose)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(story.title)
                    .font(.headline)
                    .foregroundStyle(Color.themeText)
                    .multilineTextAlignment(.leading)
                
                Text(story.era)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
        }
        .padding()
        .glassCard(cornerRadius: 16)
    }
}

#Preview {
    NavigationView {
        HistoricalStoryListView()
    }
}
