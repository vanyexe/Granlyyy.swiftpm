import SwiftUI

struct DigitalGrandmaWisdomView: View {
    @State private var scrolledOffsets: CGFloat = 0
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        // Dependency: re-render body when language changes
        let _ = lang.selectedLanguage
        return ZStack {
            MeshGradientBackground(scrollOffset: scrolledOffsets)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text(L10n.t(.wisdomHubTitle))
                            .font(.granlyTitle)
                            .foregroundStyle(Color.themeText)
                        Text(L10n.t(.wisdomHubSubtitle))
                            .font(.granlySubheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    // 1. Stories Section
                    WisdomSectionCard(
                        title: L10n.t(.impactfulStories),
                        subtitle: L10n.t(.impactfulStoriesSubtitle),
                        icon: "globe",
                        color: Color.themeRose
                    ) {
                        NavigationLink(destination: HistoricalStoryListView()) {
                            ActionRow(title: L10n.t(.readOurHistory))
                        }
                    }

                    // 2. Universal Quotes
                    WisdomSectionCard(
                        title: L10n.t(.universalWisdom),
                        subtitle: L10n.t(.universalWisdomSubtitle),
                        icon: "quote.bubble.fill",
                        color: Color.themeGreen
                    ) {
                        NavigationLink(destination: UniversalQuotesView()) {
                            ActionRow(title: L10n.t(.exploreDailyQuotes))
                        }
                    }

                    // 3. Memory Box
                    WisdomSectionCard(
                        title: L10n.t(.grandmasMemoryBox),
                        subtitle: L10n.t(.memoryBoxSubtitle),
                        icon: "archivebox.fill",
                        color: Color.themeGold
                    ) {
                        NavigationLink(destination: MemoryBoxView()) {
                            ActionRow(title: L10n.t(.openMemoryBox))
                        }
                    }

                    // 4. Ask Grandma
                    WisdomSectionCard(
                        title: L10n.t(.askGrandma),
                        subtitle: L10n.t(.askGrandmaSubtitle),
                        icon: "person.wave.2.fill",
                        color: Color.themeWarm
                    ) {
                        NavigationLink(destination: AskGrandmaView()) {
                            ActionRow(title: L10n.t(.talkToGrandma))
                        }
                    }

                    // 5. Personal Growth Path
                    WisdomSectionCard(
                        title: L10n.t(.growthPath),
                        subtitle: L10n.t(.growthPathSubtitle),
                        icon: "chart.line.uptrend.xyaxis",
                        color: .purple
                    ) {
                        NavigationLink(destination: GrowthPathView()) {
                            ActionRow(title: L10n.t(.chooseYourPath))
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
                        .frame(width: 44, height: 44)
                    Image(systemName: icon)
                        .font(.granlyHeadline)
                        .foregroundStyle(color)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.granlyBodyBold)
                        .foregroundStyle(Color.themeText)
                    Text(subtitle)
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary)
                }
            }

            content()
        }
        .padding(14)
        .glassCard(cornerRadius: 16)
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
        .padding(.vertical, 10)
        .padding(.horizontal, 14)
        .background(Color.white.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    DigitalGrandmaWisdomView()
}
