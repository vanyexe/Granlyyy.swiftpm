import SwiftUI

struct DailyWisdomView: View {
    @State private var selectedCategory = 0
    @State private var currentQuoteIndex = 0
    @State private var showShareSheet = false
    @State private var animateCard = false
    @State private var savedQuotes: Set<String> = [] // Simple in-memory save for now
    
    // Expanded Categories
    let categories = ["Life Lessons", "Love & Family", "Resilience", "Simple Joys", "Happiness", "Patience"]
    let categoryEmojis = ["🌿", "💕", "💪", "🌻", "😊", "⏳"]
    let categoryColors: [Color] = [
        Color(red: 0.45, green: 0.72, blue: 0.60), // Life - Green
        Color(red: 0.90, green: 0.50, blue: 0.55), // Love - Pink
        Color(red: 0.75, green: 0.55, blue: 0.35), // Resilience - Brown
        Color(red: 0.95, green: 0.78, blue: 0.40), // Simple Joys - Yellow
        Color(red: 0.40, green: 0.60, blue: 0.90), // Happiness - Blue
        Color(red: 0.60, green: 0.40, blue: 0.70)  // Patience - Purple
    ]
    
    let quotes: [[WisdomQuote]] = [
        // Life Lessons
        [
            WisdomQuote(text: "The best things in life aren't things at all, my dear. They're moments, memories, and the love we share.", author: "Grandma"),
            WisdomQuote(text: "Don't rush through life trying to get somewhere. The beauty is in the journey, not just the destination.", author: "Grandma")
        ],
        // Love & Family
        [
            WisdomQuote(text: "Family isn't just about blood. It's about who holds your hand when you're scared and laughs with you until you cry.", author: "Grandma"),
            WisdomQuote(text: "Love isn't perfect, sweetheart. It's messy and complicated, but it's always, always worth it.", author: "Grandma")
        ],
        // Resilience
        [
            WisdomQuote(text: "I've weathered many storms in my years, and I can tell you this: the sun always returns. Always.", author: "Grandma"),
            WisdomQuote(text: "Being brave doesn't mean you're not afraid. It means you keep going even when you are.", author: "Grandma")
        ],
        // Simple Joys
        [
            WisdomQuote(text: "A cup of tea, a good book, and a cozy blanket — sometimes that's all the magic you need.", author: "Grandma"),
            WisdomQuote(text: "Watch the sunrise once in a while. It's God's way of reminding us that every day is a fresh start.", author: "Grandma")
        ],
        // Happiness (NEW)
        [
            WisdomQuote(text: "Happiness is like a butterfly; the more you chase it, the more it eludes you. But if you turn your attention to other things, it comes and sits softly on your shoulder.", author: "Grandma"), // Attributed to Thoreau/Grandma
            WisdomQuote(text: "You don't need a reason to be happy. Being alive is reason enough to smile.", author: "Grandma")
        ],
        // Patience (NEW)
        [
            WisdomQuote(text: "Patience is not simply the ability to wait - it's how we behave while we're waiting.", author: "Grandma"), // Joyce Meyer/Grandma
            WisdomQuote(text: "Nature does not hurry, yet everything is accomplished. Trust your timing.", author: "Grandma") // Lao Tzu/Grandma
        ]
    ]
    
    var currentQuote: WisdomQuote {
        let catQuotes = quotes[selectedCategory]
        return catQuotes[currentQuoteIndex % catQuotes.count]
    }
    
    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Daily Wisdom")
                        .font(.granlyTitle)
                        .foregroundStyle(Color.themeText)
                    Text("Grandma's timeless advice ✨")
                        .font(.granlySubheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                // Category Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(0..<categories.count, id: \.self) { index in
                            Button(action: {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    selectedCategory = index
                                    currentQuoteIndex = 0
                                    animateCard = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                        animateCard = true
                                    }
                                }
                            }) {
                                HStack(spacing: 6) {
                                    Text(categoryEmojis[index])
                                        .font(.granlyBody)
                                    Text(categories[index])
                                        .font(.granlySubheadline)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(selectedCategory == index ? categoryColors[index].opacity(0.2) : Color.clear)
                                .foregroundStyle(selectedCategory == index ? categoryColors[index] : .secondary)
                                .glassCard(cornerRadius: 20)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Quote Card
                VStack(spacing: 24) {
                    // Header Row: Emoji + Bookmark
                    HStack {
                        Spacer()
                        Text(categoryEmojis[selectedCategory])
                            .font(.system(size: 50))
                            .padding(.leading, 24) // Offset to center visually
                        Spacer()
                        
                        Button(action: {
                            if savedQuotes.contains(currentQuote.text) {
                                savedQuotes.remove(currentQuote.text)
                            } else {
                                savedQuotes.insert(currentQuote.text)
                            }
                        }) {
                            Image(systemName: savedQuotes.contains(currentQuote.text) ? "bookmark.fill" : "bookmark")
                                .font(.granlyTitle2)
                                .foregroundStyle(categoryColors[selectedCategory])
                        }
                    }
                    
                    Text("\"")
                        .font(.granlyTitle)
                        .foregroundStyle(categoryColors[selectedCategory].opacity(0.5))
                        .offset(y: 10)
                    
                    Text(currentQuote.text)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                        .foregroundStyle(Color.themeText)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.horizontal, 8)
                    
                    Text("— \(currentQuote.author)")
                        .font(.subheadline.italic())
                        .foregroundStyle(.secondary)
                }
                .padding(32)
                .frame(maxWidth: .infinity)
                .glassCard(cornerRadius: 32)
                .padding(.horizontal, 24)
                .scaleEffect(animateCard ? 1 : 0.9)
                .opacity(animateCard ? 1 : 0)
                
                Spacer()
                
                // Controls
                HStack(spacing: 20) {
                    // Previous
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            animateCard = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            let count = quotes[selectedCategory].count
                            currentQuoteIndex = (currentQuoteIndex - 1 + count) % count
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                animateCard = true
                            }
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.granlyTitle2)
                            .foregroundStyle(Color.themeText)
                            .frame(width: 50, height: 50)
                            .glassCard(cornerRadius: 25)
                    }
                    
                    // Share
                    ShareLink(item: "\"\(currentQuote.text)\" — Grandma 💛\n\nFrom Granly App") {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.granlyHeadline)
                            Text("Share Wisdom")
                                .font(.granlyHeadline)
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 14)
                        .background(categoryColors[selectedCategory])
                        .clipShape(Capsule())
                        .shadow(color: categoryColors[selectedCategory].opacity(0.4), radius: 12, x: 0, y: 6)
                    }
                    
                    // Next
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            animateCard = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            currentQuoteIndex = (currentQuoteIndex + 1) % quotes[selectedCategory].count
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                animateCard = true
                            }
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.granlyTitle2)
                            .foregroundStyle(Color.themeText)
                            .frame(width: 50, height: 50)
                            .glassCard(cornerRadius: 25)
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.2)) {
                animateCard = true
            }
        }
    }
}

struct WisdomQuote: Identifiable {
    let id = UUID()
    let text: String
    let author: String
}
