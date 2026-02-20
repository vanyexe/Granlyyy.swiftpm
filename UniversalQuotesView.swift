import SwiftUI

struct UniversalQuotesView: View {
    @State private var currentIndex = 0
    let quotes = UniversalQuotesData.quotes
    
    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Universal Wisdom")
                        .font(.granlyTitle2) // Title -> Title2
                        .foregroundStyle(Color.themeText)
                    Text("Timeless truths connecting us all.")
                        .font(.granlySubheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                Spacer()
                
                // Card View Carousel
                TabView(selection: $currentIndex) {
                    ForEach(0..<quotes.count, id: \.self) { index in
                        QuoteDetailCard(quote: quotes[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentIndex)
                
                Spacer()
                
                // Indicators
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
                // Core Principle Badge
                Text(quote.corePrinciple)
                    .font(.granlyCaption)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(quote.iconColor)
                    .clipShape(Capsule())
                
                // Original Quote & Source
                VStack(spacing: 12) {
                    Text("\"\(quote.originalQuote)\"")
                        .font(.system(size: 20, weight: .medium, design: .serif)) // 24 -> 20
                        .foregroundStyle(Color.themeText)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                    
                    Text("— \(quote.source)")
                        .font(.subheadline.italic().bold())
                        .foregroundStyle(.secondary)
                }
                .padding()
                
                Divider()
                
                // Modern Meaning
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "globe")
                            .foregroundStyle(Color.themeRose)
                        Text("Simple Meaning")
                            .font(.granlyBodyBold) // Headline -> BodyBold
                            .foregroundStyle(Color.themeText)
                    }
                    Text(quote.modernMeaning)
                        .font(.granlyCaption) // Subheadline -> Caption
                        .foregroundStyle(Color.themeText.opacity(0.8))
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.themeRose.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // Grandma Interpret
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(Color.themeWarm)
                        Text("Grandma Says...")
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
                
                // Daily Practice
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "leaf.fill")
                            .foregroundStyle(Color.themeGreen)
                        Text("Daily Practice")
                            .font(.granlyBodyBold) // Headline -> BodyBold
                            .foregroundStyle(Color.themeText)
                    }
                    Text(quote.dailyPractice)
                        .font(.granlyCaption) // Subheadline -> Caption
                        .foregroundStyle(Color.themeText.opacity(0.8))
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.themeGreen.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // Next Steps Linking
                VStack(spacing: 12) {
                    Text("Continue Your Journey")
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                        .padding(.top, 10)
                    
                    NavigationLink(destination: AskGrandmaView()) {
                        DetailActionRow(title: "Discuss this quote", icon: "person.wave.2.fill")
                    }
                    
                    NavigationLink(destination: GrowthPathView()) {
                        DetailActionRow(title: "Update your Growth Path", icon: "chart.line.uptrend.xyaxis")
                    }
                }
                .padding(.top, 8)
                
            }
            .padding(16) // 24 -> 16
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 24)) // 32 -> 24
            .shadow(color: Color.black.opacity(0.05), radius: 10, y: 5) // 20 -> 10
            .padding(.horizontal, 20) // 24 -> 20
            .padding(.vertical, 8) // 10 -> 8
        }
        .scrollIndicators(.hidden)
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
    UniversalQuotesView()
}
