import SwiftUI
import NaturalLanguage

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct AskGrandmaView: View {
    @EnvironmentObject var lang: LanguageManager
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = []
    @State private var isThinking = false

    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()

            VStack {
                // Header
                HStack {
                    ZStack {
                        Circle()
                            .fill(Color.themeWarm.opacity(0.3))
                            .frame(width: 44, height: 44)
                        Text("👵🏻")
                            .font(.granlyTitle2)
                    }

                    VStack(alignment: .leading) {
                        Text(L10n.t(.chatWithGrandma))
                            .font(.granlyHeadline)
                            .foregroundStyle(Color.themeText)
                        Text(L10n.t(.grandmaOnline))
                            .font(.granlyCaption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(.ultraThinMaterial)

                // Chat Area
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                            }

                            if isThinking {
                                HStack {
                                    Text(L10n.t(.grandmaTyping))
                                        .font(.caption.italic())
                                        .foregroundStyle(.secondary)
                                        .padding()
                                        .background(Color.white.opacity(0.6))
                                        .clipShape(Capsule())
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .id("ThinkingIndicator")
                            }
                        }
                        .padding(.vertical)
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }

                // Input Area
                HStack(spacing: 12) {
                    TextField(L10n.t(.tellGrandmaMind), text: $messageText)
                        .padding(16)
                        .background(Color.white.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.black.opacity(0.05), lineWidth: 1)
                        )

                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .font(.granlyHeadline)
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(messageText.isEmpty ? Color.gray.opacity(0.5) : Color.themeRose)
                            .clipShape(Circle())
                    }
                    .disabled(messageText.isEmpty)
                }
                .padding()
                .background(.ultraThinMaterial)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Inject greeting in current language on first appear only
            if messages.isEmpty {
                messages = [ChatMessage(text: L10n.t(.askGrandmaGreeting), isUser: false)]
            }
        }
        .onChange(of: lang.selectedLanguage) { _ in
            // Update greeting when language changes (only when still just the greeting)
            if messages.count == 1 && !messages[0].isUser {
                messages = [ChatMessage(text: L10n.t(.askGrandmaGreeting), isUser: false)]
            }
        }
    }

    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let userMessage = ChatMessage(text: messageText, isUser: true)
        messages.append(userMessage)

        let userInput = messageText
        messageText = ""
        isThinking = true

        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5...3.0)) {
            isThinking = false
            let response = generateGrandmaResponse(to: userInput, language: lang.selectedLanguage)
            messages.append(ChatMessage(text: response, isUser: false))
        }
    }

    // MARK: - Language-aware Response Engine

    private func generateGrandmaResponse(to input: String, language: AppLanguage) -> String {
        let lower = input.lowercased()

        // ── 1. Keyword sets per topic (English + transliterated equivalents) ──
        let sadKeywords      = ["sad", "cry", "depressed", "upset", "grief",
                                "उदास", "ro", "रोना", "triste", "llorar", "triste", "pleurer", "难过", "哭"]
        let anxiousKeywords  = ["anxious", "worried", "stress", "nervous", "fear",
                                "चिंता", "डर", "preocupado", "estresado", "anxieux", "stressé", "焦虑", "担心"]
        let angryKeywords    = ["angry", "mad", "frustrated", "furious",
                                "गुस्सा", "enojado", "frustrado", "en colère", "frustré", "生气", "愤怒"]
        let loveKeywords     = ["love", "relationship", "friend", "breakup", "lonely", "miss",
                                "प्यार", "दोस्त", "amor", "amigo", "amour", "ami", "爱", "朋友", "分手"]
        let tiredKeywords    = ["tired", "exhausted", "burnout", "sleep",
                                "थका", "थक", "cansado", "agotado", "fatigué", "épuisé", "累", "疲倦"]
        let happyKeywords    = ["happy", "good", "excited", "great", "joy", "wonderful",
                                "खुश", "अच्छा", "feliz", "emocionado", "heureux", "formidable", "开心", "高兴"]
        let sickKeywords     = ["sick", "ill", "hurt", "pain", "unwell",
                                "बीमार", "दर्द", "enfermo", "dolor", "malade", "douleur", "生病", "痛"]
        let workKeywords     = ["school", "job", "work", "study", "exam", "office",
                                "स्कूल", "काम", "पढ़ाई", "escuela", "trabajo", "estudio", "école", "travail", "étude", "学校", "工作", "学习"]

        // ── 2. Keyword check ──
        func containsAny(_ keywords: [String]) -> Bool {
            keywords.contains { lower.contains($0) }
        }

        // ── 3. Response pools per language ──
        struct Responses {
            let sad: String
            let anxious: String
            let angry: String
            let love: String
            let tired: String
            let happy: String
            let sick: String
            let work: String
            let negativeFallbacks: [String]
            let positiveFallbacks: [String]
            let neutralFallbacks: [String]
        }

        let pool: Responses
        switch language {
        case .hindi:
            pool = Responses(
                sad: "आओ यहाँ बैठो मेरे पास। उदास होना ठीक है। आसमान को भी बरसना पड़ता है तभी फूल खिलते हैं। तुम बहुत प्यारे हो, बहुत ज़्यादा प्यारे।",
                anxious: "मेरे साथ एक गहरी साँस लो। अंदर... और बाहर... बहुत अच्छा। याद रखो, हम केवल आज का सामना कर सकते हैं। कल की चिंता कल पर छोड़ दो।",
                angry: "मैं समझती हूँ तुम कितने परेशान हो। पर याद रखो, जलता कोयला सिर्फ अपना हाथ जलाता है। थोड़ी देर टहलो, ताज़ी हवा लेकर आओ।",
                love: "रिश्ते एक बगीचे की तरह होते हैं — उन्हें धैर्य और प्यार चाहिए। तुम उस प्यार के लायक हो जो घर जैसा लगे। समय अपना काम करेगा।",
                tired: "मेरे जान, तुमने इतना बोझ उठाया है। अब थोड़ा आराम करो। आराम कमज़ोरी नहीं, यही तो चंगा करता है। आज रात अच्छी नींद लो।",
                happy: "यह सुनकर मेरा दिल खुश हो गया! इस खुशी को संभाल कर रखो। तुम सबसे अच्छी चीज़ों के हकदार हो।",
                sick: "अरे, मेरे प्यारे। खूब गरम पानी पियो और आराम करो। तुम्हारा शरीर मंदिर है, उसे ठीक होने का समय दो। मेरी तरफ से एक बड़ी गले लगाई।",
                work: "तुम इतनी मेहनत कर रहे हो — मुझे तुम पर बहुत गर्व है। बीच-बीच में ब्रेक लेना मत भूलो। तुम्हारी कीमत तुम्हारे काम से नहीं, दिल से है।",
                negativeFallbacks: [
                    "सुनो, कभी-कभी बस बोल देने से बोझ हल्का हो जाता है। मैं हमेशा यहाँ हूँ।",
                    "यह अकेले उठाना ज़रूरी नहीं। अभी सब जवाब न हों, तो चलता है — खुद पर दया करो।",
                    "हाथ दिल पर रखो — वहाँ तुम्हारी सच्ची समझ है।",
                    "आज पानी पिया? कुछ खाया? कभी-कभी सबसे बड़ी परेशानी को बस थोड़ी-सी देखभाल चाहिए।",
                ],
                positiveFallbacks: [
                    "यह सुनकर बहुत अच्छा लगा! तुम्हारी खुशी संक्रामक है।",
                    "वाह! लगता है आज का दिन खूबसूरत रहा। इसे मनाते हैं!",
                    "तुम्हारे अंदर बहुत रोशनी है। चमकते रहो!",
                    "सुनकर मुस्कान आ गई। मुझे तुम पर बहुत गर्व है।",
                ],
                neutralFallbacks: [
                    "हाँ, मैं ध्यान से सुन रही हूँ। और बताओ।",
                    "बड़ी दिलचस्प बात है। तुम गहराई में क्या महसूस करते हो?",
                    "हाँ हाँ, मैं यहाँ हूँ। दिल की बात बताते रहो।",
                    "जीवन वाकई अजीब है। आगे क्या सोच रहे हो?",
                ]
            )
        case .spanish:
            pool = Responses(
                sad: "Ven, siéntate aquí conmigo. Está bien sentirse triste. Hasta el cielo tiene que llover para que florezcan las flores. Eres muy querido, muchísimo.",
                anxious: "Respira hondo conmigo, ahora mismo. Adentro... y afuera... Bien. Recuerda que solo podemos controlar lo que tenemos hoy. Deja las preocupaciones de mañana para mañana.",
                angry: "Entiendo lo frustrado que estás y tus sentimientos son completamente válidos. Pero recuerda que aferrarse a un carbón ardiente solo quema tu propia mano. Da un paseo, toma aire fresco.",
                love: "Las relaciones son como mantener un jardín. Necesitan paciencia, agua y mucha luz solar. Mereces un amor que se sienta como hogar. Deja que el tiempo haga su magia.",
                tired: "Has cargado tanto, mi valiente. Es hora de dejar las bolsas pesadas. El descanso no es debilidad; es como nos curamos. Por favor, duerme bien esta noche.",
                happy: "¡Oh, eso me hace el corazón feliz! ¡Estoy muy alegre por ti! Guarda este sentimiento para un día lluvioso. Mereces todo lo bueno.",
                sick: "Oh no, mi querido. Bebe bastante líquido caliente y descansa. Tu cuerpo es un templo, dale el tiempo que necesita para sanar. Te mando un gran abrazo cálido.",
                work: "Estás trabajando muy duro y estoy muy orgullosa de ti. No olvides tomar descansos. Tu valor no se mide por tu productividad, sino por tu hermoso corazón.",
                negativeFallbacks: [
                    "Te escucho, cariño. A veces solo decirlo en voz alta hace la carga un poco más ligera.",
                    "Eso suena pesado para cargarlo solo. Recuerda que no necesitas tener todas las respuestas ahora.",
                    "Oh, mi querido, la vida puede ser tan complicada. Pon tu mano en tu corazón—ahí vive tu verdadera sabiduría.",
                    "¿Has bebido agua hoy? ¿Comido bien? A veces nuestros mayores problemas necesitan el cuidado más simple.",
                ],
                positiveFallbacks: [
                    "¡Es maravilloso escuchar eso! Tu alegría es contagiosa, querido.",
                    "¡Parece que estás teniendo un día hermoso! ¡Celebremos eso!",
                    "Oh, ¡tienes una luz tan brillante en ti! ¡Sigue brillando, cariño!",
                    "Eso me hizo sonreír. ¡Estoy tan orgullosa de la persona que eres!",
                ],
                neutralFallbacks: [
                    "Estoy aquí contigo, querido. Cuéntame más sobre eso.",
                    "Eso es muy interesante. ¿Cómo te hace sentir en lo más profundo?",
                    "Mmhmm, te escucho. Siempre puedes compartir tus pensamientos conmigo.",
                    "La vida es realmente un viaje lleno de sorpresas. ¿Qué crees que harás a continuación?",
                ]
            )
        case .french:
            pool = Responses(
                sad: "Viens t'asseoir avec moi. C'est tout à fait normal de se sentir triste. Même le ciel doit pleurer parfois pour que les fleurs poussent. Tu es aimé, tellement aimé.",
                anxious: "Respire profondément avec moi, maintenant. Inspire... et expire... Bien. Rappelle-toi que nous ne pouvons contrôler que ce qui est devant nous aujourd'hui. Laisse les soucis de demain à demain.",
                angry: "J'entends ta frustration, et tes sentiments sont tout à fait valides. Mais souviens-toi que tenir un charbon ardent ne brûle que ta propre main. Fais une promenade, prends l'air frais.",
                love: "Les relations sont comme entretenir un jardin. Elles demandent patience, eau et beaucoup de lumière. Tu mérites un amour qui ressemble à la maison. Laisse le temps faire sa guérison.",
                tired: "Tu as porté tellement, mon brave. Il est temps de poser les lourds bagages. Le repos n'est pas une faiblesse ; c'est ainsi que nous guérissons. S'il te plaît, dors bien ce soir.",
                happy: "Oh, ça fait battre mon cœur de joie! Je suis tellement heureuse pour toi! Garde ce sentiment, mets-le en bouteille pour un jour de pluie. Tu mérites toutes les belles choses.",
                sick: "Oh non, mon cher. Assure-toi de boire plein de liquides chauds et de te reposer. Ton corps est un temple, donne-lui le temps dont il a besoin pour guérir. Je t'envoie un grand câlin chaleureux.",
                work: "Tu travailles si dur, et je suis incroyablement fière de toi. N'oublie pas de faire des pauses. Ta valeur ne se mesure pas par ta productivité, mais par ton beau cœur.",
                negativeFallbacks: [
                    "Je t'entends, chéri. Parfois, juste le dire à voix haute rend le fardeau un peu plus léger.",
                    "Ça semble lourd à porter seul. Rappelle-toi que tu n'as pas besoin d'avoir toutes les réponses maintenant.",
                    "Oh, ma chérie, la vie peut être si merveilleusement compliquée. Mets ta main sur ton cœur — c'est là que vit ta vraie sagesse.",
                    "As-tu bu de l'eau aujourd'hui? Mangé un bon repas? Parfois nos plus grands problèmes nécessitent les soins les plus simples.",
                ],
                positiveFallbacks: [
                    "C'est merveilleux à entendre! Ta joie est contagieuse, chéri.",
                    "Il semble que tu passes une belle journée. Célébrons ça !",
                    "Oh, tu as une si belle lumière en toi! Continue de briller, chéri!",
                    "Ça m'a fait sourire. Je suis tellement fière de la personne que tu es.",
                ],
                neutralFallbacks: [
                    "Je suis là avec toi, cher. Dis-m'en plus sur ça.",
                    "C'est très intéressant. Comment cela te fait-il te sentir au fond?",
                    "Mmhmm, j'écoute. Tu peux toujours partager tes pensées avec moi.",
                    "La vie est en effet un voyage plein de surprises. Que penses-tu faire ensuite?",
                ]
            )
        case .mandarin:
            pool = Responses(
                sad: "来，坐到我身边。难过是没关系的。天空有时也需要哭泣，才能让花儿绽放。你被爱着，深深地被爱着。",
                anxious: "跟我一起深呼吸，现在就做。吸气……呼气……很好。记住，我们只能掌控今天面前的事情。把明天的烦恼留给明天吧。",
                angry: "我听到你了，你有权感到沮丧，你的感受完全有效。但记住，紧握一块炭火只会灼伤自己的手。去散散步，吸点新鲜空气吧。",
                love: "感情就像打理一座花园，需要耐心、浇灌和充足的阳光。你值得拥有一份让你感到像家一样的爱。让时间来治愈一切。",
                tired: "你已经承担了太多了，我勇敢的孩子。是时候放下那些沉重的包袱了。休息不是软弱；休息是我们愈合的方式。今晚好好睡一觉吧。",
                happy: "这让我的心感到无比快乐！我真的为你高兴！把这种感觉珍藏起来，留待阴雨天使用。你值得拥有一切美好的事物。",
                sick: "哎呀，亲爱的。要多喝热的饮料，好好休息。你的身体是座神殿，给它所需的时间来康复。我送你一个大大的温暖拥抱。",
                work: "你工作得那么努力，我为你感到无比自豪。不要忘记休息。你的价值不是由你的生产力衡量的，而是由你美好的心灵衡量的。",
                negativeFallbacks: [
                    "我听见你了，亲爱的。有时候，只是大声说出来，就能让负担轻一点。我永远在这里。",
                    "这听起来是很沉重的事，一个人扛着。记住，你现在不需要有所有的答案。对自己慈悲一点。",
                    "哦，亲爱的，生活有时候真的很奇妙地复杂。把手放在心口上——那是你最真实的智慧所在。",
                    "你今天喝水了吗？吃了一顿好饭吗？有时，我们最大的问题只需要最简单的关照。",
                ],
                positiveFallbacks: [
                    "听到这个真是太好了！你的快乐有感染力，亲爱的。",
                    "听起来你今天过得很美好。我们来庆祝一下吧！",
                    "哦，你身上有那么美丽的光！继续闪耀吧，亲爱的。",
                    "这让我露出了笑容。我为你这个人感到无比自豪。",
                ],
                neutralFallbacks: [
                    "我在你身边，亲爱的。告诉我更多关于这件事吧。",
                    "这很有趣呢。深处来说，这让你有什么感受？",
                    "嗯嗯，我在听。你随时可以和我分享你的想法。",
                    "人生的确是一段充满惊喜的旅程。你想下一步怎么做呢？",
                ]
            )
        default: // .english
            pool = Responses(
                sad: "Oh honey, come sit here with me. It's okay to feel sad. Even the sky has to cry sometimes to make the flowers grow. Take a deep breath. You are loved, so very loved.",
                anxious: "Take a deep breath with me, right now. In... and out... Good. Remember we can only control what's in front of us today. Leave tomorrow's worries for tomorrow.",
                angry: "I hear how frustrated you are, and your feelings are completely valid. But remember, holding onto a hot coal will only burn your own hand. Take a walk, get some fresh air.",
                love: "Relationships are like maintaining a garden. They take patience, water, and plenty of sunshine. You deserve a love that feels like home. Let time do its healing.",
                tired: "You've been carrying so much, my brave one. It's time to put the heavy bags down. Rest is not a weakness; it's how we heal. Please go get some sleep tonight.",
                happy: "Oh, that makes my heart flutter! I'm so incredibly happy for you! Remember this feeling, bottle it up, and save it for a rainy day. You deserve all the good things.",
                sick: "Oh no, my dear. Make sure you're drinking plenty of warm fluids and getting enough rest. Your body is a temple, give it the time it needs to heal. I'm sending you a big, warm hug.",
                work: "You are working so hard, and I am incredibly proud of you. Don't forget to take breaks. Your worth is not measured by your productivity, but by your beautiful heart.",
                negativeFallbacks: [
                    "I hear you, sweetheart. Sometimes just saying it out loud makes the burden a little lighter. I'm always here to listen.",
                    "That sounds like a heavy thing to carry alone. Remember you don't have to have all the answers right now. Give yourself some grace.",
                    "Oh my dear, life can be so wonderfully complicated. Place your hand on your heart—that's where your truest wisdom lives.",
                    "Have you had a glass of water today? Eaten a good meal? Sometimes our biggest problems just need the simplest care first.",
                ],
                positiveFallbacks: [
                    "That is so wonderful to hear! Your joy is contagious, my dear.",
                    "It sounds like you're having a beautiful day. Let's celebrate that!",
                    "Oh, you have such a bright light in you! Keep shining, sweetheart.",
                    "That brought a big smile to my face. I'm so proud of the person you are.",
                ],
                neutralFallbacks: [
                    "I'm right here with you, dear. Tell me more about that.",
                    "That's very interesting. How does that make you feel deep down?",
                    "Mmhmm, I'm listening. You can always share your thoughts with me.",
                    "Life is indeed a journey full of surprises. What do you think you'll do next?",
                ]
            )
        }

        // ── 4. Match keywords → response ──
        if containsAny(sadKeywords)     { return pool.sad }
        if containsAny(anxiousKeywords) { return pool.anxious }
        if containsAny(angryKeywords)   { return pool.angry }
        if containsAny(loveKeywords)    { return pool.love }
        if containsAny(tiredKeywords)   { return pool.tired }
        if containsAny(happyKeywords)   { return pool.happy }
        if containsAny(sickKeywords)    { return pool.sick }
        if containsAny(workKeywords)    { return pool.work }

        // ── 5. Sentiment fallback (NLTagger works on any language text) ──
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = input
        let (sentiment, _) = tagger.tag(at: input.startIndex, unit: .paragraph, scheme: .sentimentScore)
        let score = Double(sentiment?.rawValue ?? "0") ?? 0.0

        if score <= -0.2 { return pool.negativeFallbacks.randomElement() ?? "" }
        if score >= 0.2  { return pool.positiveFallbacks.randomElement() ?? "" }
        return pool.neutralFallbacks.randomElement() ?? ""
    }
}

struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser { Spacer() }

            Text(message.text)
                .font(.granlyBody)
                .lineSpacing(4)
                .foregroundStyle(message.isUser ? .white : Color.themeText)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    message.isUser
                    ? Color.themeRose
                    : Color.white.opacity(0.8)
                )
                .clipShape(ChatBubbleShape(isUser: message.isUser))
                .shadow(color: Color.black.opacity(0.03), radius: 5, y: 2)

            if !message.isUser { Spacer() }
        }
        .padding(.horizontal)
    }
}

struct ChatBubbleShape: Shape {
    let isUser: Bool

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [
                .topLeft,
                .topRight,
                isUser ? .bottomLeft : .bottomRight
            ],
            cornerRadii: CGSize(width: 16, height: 16)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    AskGrandmaView()
}
