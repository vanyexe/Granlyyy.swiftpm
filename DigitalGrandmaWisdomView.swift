import SwiftUI

struct DigitalGrandmaWisdomView: View {
    @State private var scrolledOffsets: CGFloat = 0
    
    var body: some View {
        ZStack {
            MeshGradientBackground(scrollOffset: scrolledOffsets)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Wisdom & Growth")
                            .font(.granlyTitle)
                            .foregroundStyle(Color.themeText)
                        Text("A gentle space to reflect and grow.")
                            .font(.granlySubheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // 1. Stories Section
                    WisdomSectionCard(
                        title: "Impactful Stories",
                        subtitle: "Lessons from history's greatest moments.",
                        icon: "globe",
                        color: Color.themeRose
                    ) {
                        NavigationLink(destination: HistoricalStoryListView()) {
                            ActionRow(title: "Read Our Shared History")
                        }
                    }
                    
                    // 2. Universal Quotes
                    WisdomSectionCard(
                        title: "Universal Wisdom",
                        subtitle: "Timeless truths from across the world.",
                        icon: "quote.bubble.fill",
                        color: Color.themeGreen
                    ) {
                        NavigationLink(destination: UniversalQuotesView()) {
                            ActionRow(title: "Explore Daily Quotes")
                        }
                    }
                    
                    // 3. Memory Box
                    WisdomSectionCard(
                        title: "Grandma's Memory Box",
                        subtitle: "Revisit your favorite stories and quotes.",
                        icon: "archivebox.fill",
                        color: Color.themeGold
                    ) {
                        NavigationLink(destination: MemoryBoxView()) {
                            ActionRow(title: "Open Memory Box")
                        }
                    }
                    
                    // 3. Grandma Mode
                    WisdomSectionCard(
                        title: "Ask Grandma",
                        subtitle: "Need advice? I'm here to listen.",
                        icon: "person.wave.2.fill",
                        color: Color.themeWarm
                    ) {
                        NavigationLink(destination: AskGrandmaView()) {
                            ActionRow(title: "Talk to Grandma")
                        }
                    }
                    
                    // 4. Personal Growth Path
                    WisdomSectionCard(
                        title: "Growth Path",
                        subtitle: "Track your emotional journey.",
                        icon: "chart.line.uptrend.xyaxis",
                        color: .purple
                    ) {
                        NavigationLink(destination: GrowthPathView()) {
                            ActionRow(title: "Choose Your Path")
                        }
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}

struct WisdomSectionCard<Content: View>: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.15))
                        .frame(width: 44, height: 44) // 50 -> 44
                    Image(systemName: icon)
                        .font(.granlyHeadline) // Title2 -> Headline
                        .foregroundStyle(color)
                }
                
                VStack(alignment: .leading, spacing: 2) { // 4 -> 2
                    Text(title)
                        .font(.granlyBodyBold) // Headline -> BodyBold
                        .foregroundStyle(Color.themeText)
                    Text(subtitle)
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary)
                }
            }
            
            content()
        }
        .padding(14) // 16 -> 14
        .glassCard(cornerRadius: 16) // 20 -> 16
        .padding(.horizontal)
    }
}

struct ActionRow: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.granlySubheadline)
                .foregroundStyle(Color.themeText)
            
            Spacer()
            
            Image(systemName: "arrow.right.circle.fill")
                .foregroundStyle(Color.themeText.opacity(0.5))
                .font(.granlyHeadline)
        }
        .padding(.vertical, 10) // 12 -> 10
        .padding(.horizontal, 14) // 16 -> 14
        .background(Color.white.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10)) // 12 -> 10
    }
}

#Preview {
    DigitalGrandmaWisdomView()
}
