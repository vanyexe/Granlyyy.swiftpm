import SwiftUI

struct DailyWisdomView: View {
    @State private var selectedCategory = 0
    @State private var currentQuoteIndex = 0
    @State private var showShareSheet = false
    @State private var animateCard = false
    @State private var savedQuotes: Set<String> = []
    @EnvironmentObject var lang: LanguageManager

    // MARK: - Reactive category names (re-computed when lang changes)
    private var categories: [String] {
        _ = lang.selectedLanguage // dependency trigger
        return [
            L10n.t(.wisdomCatLife),
            L10n.t(.wisdomCatLove),
            L10n.t(.wisdomCatResilience),
            L10n.t(.wisdomCatSimpleJoys),
            L10n.t(.wisdomCatHappiness),
            L10n.t(.wisdomCatPatience)
        ]
    }

    let categoryIcons = ["leaf.fill", "heart.fill", "shield.fill", "sparkles", "sun.max.fill", "hourglass"]
    let categoryColors: [Color] = [
        Color(red: 0.45, green: 0.72, blue: 0.60),
        Color(red: 0.90, green: 0.50, blue: 0.55),
        Color(red: 0.75, green: 0.55, blue: 0.35),
        Color(red: 0.95, green: 0.78, blue: 0.40),
        Color(red: 0.40, green: 0.60, blue: 0.90),
        Color(red: 0.60, green: 0.40, blue: 0.70)
    ]

    // MARK: - Localized quotes per language
    private static let allQuotes: [AppLanguage: [[WisdomQuote]]] = [
        .english: [
            // Life Lessons
            [WisdomQuote(text: "The best things in life aren't things at all, my dear. They're moments, memories, and the love we share.", author: "Grandma"),
             WisdomQuote(text: "Don't rush through life trying to get somewhere. The beauty is in the journey, not just the destination.", author: "Grandma")],
            // Love & Family
            [WisdomQuote(text: "Family isn't just about blood. It's about who holds your hand when you're scared and laughs with you until you cry.", author: "Grandma"),
             WisdomQuote(text: "Love isn't perfect, sweetheart. It's messy and complicated, but it's always, always worth it.", author: "Grandma")],
            // Resilience
            [WisdomQuote(text: "I've weathered many storms in my years, and I can tell you this: the sun always returns. Always.", author: "Grandma"),
             WisdomQuote(text: "Being brave doesn't mean you're not afraid. It means you keep going even when you are.", author: "Grandma")],
            // Simple Joys
            [WisdomQuote(text: "A cup of tea, a good book, and a cozy blanket — sometimes that's all the magic you need.", author: "Grandma"),
             WisdomQuote(text: "Watch the sunrise once in a while. It's God's way of reminding us that every day is a fresh start.", author: "Grandma")],
            // Happiness
            [WisdomQuote(text: "Happiness is like a butterfly; the more you chase it, the more it eludes you. But if you turn your attention to other things, it comes and sits softly on your shoulder.", author: "Grandma"),
             WisdomQuote(text: "You don't need a reason to be happy. Being alive is reason enough to smile.", author: "Grandma")],
            // Patience
            [WisdomQuote(text: "Patience is not simply the ability to wait — it's how we behave while we're waiting.", author: "Grandma"),
             WisdomQuote(text: "Nature does not hurry, yet everything is accomplished. Trust your timing.", author: "Grandma")]
        ],
        .hindi: [
            [WisdomQuote(text: "जीवन की सबसे अच्छी चीजें वस्तुएं नहीं हैं, मेरे प्रिय। वे पल, यादें और प्यार हैं।", author: "दादी"),
             WisdomQuote(text: "कहीं पहुंचने की जल्दी में जीवन को मत भागो। सुंदरता यात्रा में है, सिर्फ मंजिल में नहीं।", author: "दादी")],
            [WisdomQuote(text: "परिवार सिर्फ खून का नहीं होता। यह वो होते हैं जो डर में आपका हाथ थामते हैं।", author: "दादी"),
             WisdomQuote(text: "प्यार परफेक्ट नहीं होता, प्रिये। यह उलझा हुआ होता है, पर हमेशा कीमती होता है।", author: "दादी")],
            [WisdomQuote(text: "मैंने अपने जीवन में कई तूफान झेले हैं, और मैं बता सकती हूँ: सूरज हमेशा लौटता है।", author: "दादी"),
             WisdomQuote(text: "बहादुर होने का मतलब डर न लगना नहीं है। इसका मतलब है डरते हुए भी आगे बढ़ते रहना।", author: "दादी")],
            [WisdomQuote(text: "एक कप चाय, एक अच्छी किताब और एक आरामदायक कंबल — कभी-कभी यही सब जादू चाहिए।", author: "दादी"),
             WisdomQuote(text: "कभी-कभी सूर्योदय देखें। यह ईश्वर का तरीका है हमें याद दिलाने का कि हर दिन एक नई शुरुआत है।", author: "दादी")],
            [WisdomQuote(text: "खुशी तितली की तरह है; जितना इसका पीछा करो, उतनी दूर भागती है। ध्यान बदलो तो वह खुद आ जाती है।", author: "दादी"),
             WisdomQuote(text: "खुश रहने के लिए कोई कारण नहीं चाहिए। जीवित होना ही मुस्कुराने का कारण है।", author: "दादी")],
            [WisdomQuote(text: "धैर्य सिर्फ प्रतीक्षा करने की क्षमता नहीं है — यह इस बारे में है कि हम प्रतीक्षा करते समय कैसे व्यवहार करते हैं।", author: "दादी"),
             WisdomQuote(text: "प्रकृति जल्दी नहीं करती, फिर भी सब कुछ पूरा होता है। अपने समय पर भरोसा रखें।", author: "दादी")]
        ],
        .spanish: [
            [WisdomQuote(text: "Las mejores cosas de la vida no son cosas en absoluto, mi amor. Son momentos, recuerdos y el amor que compartimos.", author: "Abuela"),
             WisdomQuote(text: "No te apresures en la vida tratando de llegar a algún lugar. La belleza está en el viaje, no solo en el destino.", author: "Abuela")],
            [WisdomQuote(text: "La familia no es solo sangre. Es quien te sostiene la mano cuando tienes miedo y ríe contigo hasta llorar.", author: "Abuela"),
             WisdomQuote(text: "El amor no es perfecto, cariño. Es desordenado y complicado, pero siempre, siempre vale la pena.", author: "Abuela")],
            [WisdomQuote(text: "He soportado muchas tormentas en mis años, y puedo decirte esto: el sol siempre regresa. Siempre.", author: "Abuela"),
             WisdomQuote(text: "Ser valiente no significa que no tengas miedo. Significa que sigues adelante aunque lo tengas.", author: "Abuela")],
            [WisdomQuote(text: "Una taza de té, un buen libro y una manta acogedora: a veces eso es toda la magia que necesitas.", author: "Abuela"),
             WisdomQuote(text: "Mira el amanecer de vez en cuando. Es la forma de Dios de recordarnos que cada día es un nuevo comienzo.", author: "Abuela")],
            [WisdomQuote(text: "La felicidad es como una mariposa; cuanto más la persigues, más se aleja. Pero si diriges tu atención hacia otras cosas, viene y se posa suavemente en tu hombro.", author: "Abuela"),
             WisdomQuote(text: "No necesitas una razón para ser feliz. Estar vivo es razón suficiente para sonreír.", author: "Abuela")],
            [WisdomQuote(text: "La paciencia no es simplemente la capacidad de esperar — es cómo nos comportamos mientras esperamos.", author: "Abuela"),
             WisdomQuote(text: "La naturaleza no tiene prisa, sin embargo todo se logra. Confía en tu propio tiempo.", author: "Abuela")]
        ],
        .french: [
            [WisdomQuote(text: "Les meilleures choses de la vie ne sont pas des choses, ma chérie. Ce sont des moments, des souvenirs et l'amour que nous partageons.", author: "Grand-mère"),
             WisdomQuote(text: "Ne te précipite pas dans la vie pour arriver quelque part. La beauté est dans le voyage, pas seulement dans la destination.", author: "Grand-mère")],
            [WisdomQuote(text: "La famille ne se résume pas au sang. C'est ceux qui vous tiennent la main quand vous avez peur et rient avec vous jusqu'aux larmes.", author: "Grand-mère"),
             WisdomQuote(text: "L'amour n'est pas parfait, ma chérie. C'est désordonné et compliqué, mais ça vaut toujours, toujours la peine.", author: "Grand-mère")],
            [WisdomQuote(text: "J'ai traversé bien des tempêtes au fil des ans, et je peux vous dire ceci : le soleil revient toujours. Toujours.", author: "Grand-mère"),
             WisdomQuote(text: "Être courageux ne signifie pas ne pas avoir peur. Cela signifie continuer même quand vous l'êtes.", author: "Grand-mère")],
            [WisdomQuote(text: "Une tasse de thé, un bon livre et une couverture douillette — parfois c'est toute la magie dont vous avez besoin.", author: "Grand-mère"),
             WisdomQuote(text: "Regardez le lever du soleil de temps en temps. C'est la façon de Dieu de nous rappeler que chaque jour est un nouveau départ.", author: "Grand-mère")],
            [WisdomQuote(text: "Le bonheur est comme un papillon ; plus vous le poursuivez, plus il vous échappe. Mais si vous portez votre attention ailleurs, il vient se poser doucement sur votre épaule.", author: "Grand-mère"),
             WisdomQuote(text: "Vous n'avez pas besoin d'une raison d'être heureux. Être en vie est une raison suffisante de sourire.", author: "Grand-mère")],
            [WisdomQuote(text: "La patience n'est pas simplement la capacité d'attendre — c'est notre comportement pendant que nous attendons.", author: "Grand-mère"),
             WisdomQuote(text: "La nature ne se presse pas, et pourtant tout s'accomplit. Faites confiance à votre timing.", author: "Grand-mère")]
        ],
        .mandarin: [
            [WisdomQuote(text: "生命中最美好的事不是物品，亲爱的。它们是时刻、回忆和我们共同分享的爱。", author: "奶奶"),
             WisdomQuote(text: "不要为了到达某个地方而匆匆度过人生。美丽在于旅程本身，而不仅仅是目的地。", author: "奶奶")],
            [WisdomQuote(text: "家人不只是血缘。是那些在你害怕时握住你手、和你笑到流泪的人。", author: "奶奶"),
             WisdomQuote(text: "爱不是完美的，亲爱的。它是凌乱复杂的，但永远、永远值得。", author: "奶奶")],
            [WisdomQuote(text: "我经历了许多风风雨雨，我可以告诉你：太阳永远会回来。永远。", author: "奶奶"),
             WisdomQuote(text: "勇敢不意味着没有恐惧。它意味着即使恐惧时也继续前行。", author: "奶奶")],
            [WisdomQuote(text: "一杯茶、一本好书和一条温暖的毯子——有时候这就是你所需要的全部魔法。", author: "奶奶"),
             WisdomQuote(text: "偶尔看看日出。那是上帝提醒我们每一天都是新的开始的方式。", author: "奶奶")],
            [WisdomQuote(text: "幸福就像蝴蝶；你越追逐它，它就越溜走。但如果你把注意力转向其他事物，它就会轻轻落在你的肩上。", author: "奶奶"),
             WisdomQuote(text: "你不需要理由去快乐。活着本身就是微笑的理由。", author: "奶奶")],
            [WisdomQuote(text: "耐心不仅仅是等待的能力——它是我们等待时的行为方式。", author: "奶奶"),
             WisdomQuote(text: "自然不急不躁，却万物成就。相信你自己的时机。", author: "奶奶")]
        ]
    ]

    // Returns the right quotes for the currently selected language
    private var quotes: [[WisdomQuote]] {
        DailyWisdomView.allQuotes[lang.selectedLanguage] ?? DailyWisdomView.allQuotes[.english]!
    }

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
                    Text(L10n.t(.wisdomPageTitle))
                        .font(.granlyTitle)
                        .foregroundStyle(Color.themeText)
                    HStack(spacing: 6) {
                        Text(L10n.t(.wisdomPageSubtitle))
                        Image(systemName: "sparkles")
                            .foregroundStyle(Color.themeGold)
                    }
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
                                    Image(systemName: categoryIcons[index])
                                        .font(.granlySubheadline)
                                    Text(categories[index])
                                        .font(.system(size: 11, weight: .bold, design: .rounded))
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(selectedCategory == index ? categoryColors[index].opacity(0.2) : Color.clear)
                                .foregroundStyle(selectedCategory == index ? categoryColors[index] : .secondary)
                                .glassCard(cornerRadius: 16)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.top, 20)

                Spacer()

                // Quote Card
                VStack(spacing: 24) {
                    HStack {
                        Spacer()
                        Image(systemName: categoryIcons[selectedCategory])
                            .font(.system(size: 40))
                            .padding(.leading, 24)
                        Spacer()

                        Button(action: {
                            if savedQuotes.contains(currentQuote.text) {
                                savedQuotes.remove(currentQuote.text)
                            } else {
                                savedQuotes.insert(currentQuote.text)
                            }
                        }) {
                            Image(systemName: savedQuotes.contains(currentQuote.text) ? "bookmark.fill" : "bookmark")
                                .font(.granlyHeadline)
                                .foregroundStyle(categoryColors[selectedCategory])
                        }
                    }

                    Text("\"")
                        .font(.granlyTitle2)
                        .foregroundStyle(categoryColors[selectedCategory].opacity(0.5))
                        .offset(y: 10)

                    Text(currentQuote.text)
                        .font(.system(size: 20, weight: .medium, design: .serif))
                        .foregroundStyle(Color.themeText)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 8)

                    Text("— \(currentQuote.author)")
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary)
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .glassCard(cornerRadius: 24)
                .padding(.horizontal, 20)
                .scaleEffect(animateCard ? 1.0 : 0.95)
                .opacity(animateCard ? 1 : 0)

                Spacer()

                // Controls
                HStack(spacing: 20) {
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { animateCard = false }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            let count = quotes[selectedCategory].count
                            currentQuoteIndex = (currentQuoteIndex - 1 + count) % count
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) { animateCard = true }
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.granlyHeadline)
                            .foregroundStyle(Color.themeText)
                            .frame(width: 44, height: 44)
                            .glassCard(cornerRadius: 16)
                    }

                    ShareLink(item: "\"\(currentQuote.text)\" — \(currentQuote.author)\n\nFrom Granly App") {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.granlySubheadline)
                            Text(L10n.t(.shareWisdom))
                                .font(.granlyBodyBold)
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 22)
                        .padding(.vertical, 12)
                        .background(categoryColors[selectedCategory])
                        .clipShape(Capsule())
                        .shadow(color: categoryColors[selectedCategory].opacity(0.4), radius: 8, x: 0, y: 4)
                    }

                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { animateCard = false }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            currentQuoteIndex = (currentQuoteIndex + 1) % quotes[selectedCategory].count
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) { animateCard = true }
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.granlyHeadline)
                            .foregroundStyle(Color.themeText)
                            .frame(width: 44, height: 44)
                            .glassCard(cornerRadius: 16)
                    }
                }
                .padding(.bottom, 24)
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
