import SwiftUI

struct UniversalQuotesView: View {
    @State private var currentIndex = 0
    @EnvironmentObject var lang: LanguageManager

    private var quotes: [UniversalQuote] {

        UniversalQuotesData.quotes(for: lang.selectedLanguage)
    }

    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack(alignment: .leading, spacing: 4) {
                    Text(L10n.t(.universalWisdom))
                        .font(.granlyTitle2)
                        .foregroundStyle(Color.themeText)
                    Text(L10n.t(.timelessTruthsSubtitle))
                        .font(.granlySubheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 16)

                Spacer()

                TabView(selection: $currentIndex) {
                    ForEach(0..<quotes.count, id: \.self) { index in
                        QuoteDetailCard(quote: quotes[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentIndex)

                Spacer()

                HStack(spacing: 8) {
                    ForEach(0..<quotes.count, id: \.self) { index in
                        Circle()
                            .fill(currentIndex == index ? Color.themeText : Color.themeText.opacity(0.2))
                            .frame(width: 8, height: 8)
                            .animation(.spring(), value: currentIndex)
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}

struct QuoteDetailCard: View {
    let quote: UniversalQuote

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                Text(quote.corePrinciple)
                    .font(.granlyCaption)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(quote.iconColor)
                    .clipShape(Capsule())

                VStack(spacing: 12) {
                    Text("\"\(quote.originalQuote)\"")
                        .font(.system(size: 20, weight: .medium, design: .serif))
                        .foregroundStyle(Color.themeText)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)

                    Text("— \(quote.source)")
                        .font(.subheadline.italic().bold())
                        .foregroundStyle(.secondary)
                }
                .padding()

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "globe")
                            .foregroundStyle(Color.themeRose)
                        Text(L10n.t(.simpleMeaning))
                            .font(.granlyBodyBold)
                            .foregroundStyle(Color.themeText)
                    }
                    Text(quote.modernMeaning)
                        .font(.granlyCaption)
                        .foregroundStyle(Color.themeText.opacity(0.8))
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.themeRose.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(Color.themeWarm)
                        Text(L10n.t(.grandmaSaysTitle))
                            .font(.granlyHeadline)
                            .foregroundStyle(Color.themeText)
                    }
                    Text("\"\(quote.grandmaInterpretation)\"")
                        .font(.subheadline.italic())
                        .foregroundStyle(Color.themeText.opacity(0.8))
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.themeWarm.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "leaf.fill")
                            .foregroundStyle(Color.themeGreen)
                        Text(L10n.t(.dailyPractice))
                            .font(.granlyBodyBold)
                            .foregroundStyle(Color.themeText)
                    }
                    Text(quote.dailyPractice)
                        .font(.granlyCaption)
                        .foregroundStyle(Color.themeText.opacity(0.8))
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.themeGreen.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(spacing: 12) {
                    Text(L10n.t(.continueAction))
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                        .padding(.top, 10)

                    NavigationLink(destination: AskGrandmaView()) {
                        DetailActionRow(title: L10n.t(.discussThisQuote), icon: "person.wave.2.fill")
                    }

                    NavigationLink(destination: GrowthPathView()) {
                        DetailActionRow(title: L10n.t(.updateGrowthPath), icon: "chart.line.uptrend.xyaxis")
                    }
                }
                .padding(.top, 8)

            }
            .padding(16)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(color: Color.black.opacity(0.05), radius: 10, y: 5)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
        }
        .scrollIndicators(.hidden)
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
    UniversalQuotesView()
}