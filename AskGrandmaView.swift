import SwiftUI
import NaturalLanguage

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct AskGrandmaView: View {
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hello my dear! What's on your heart today? You can tell me anything.", isUser: false)
    ]
    @State private var isThinking = false
    
    // ML sentiment analysis and keyword matching
    private func generateGrandmaResponse(to input: String) -> String {
        let lower = input.lowercased()
        
        // 1. Core ML Sentiment Analysis via NLTagger
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = input
        let (sentiment, _) = tagger.tag(at: input.startIndex, unit: .paragraph, scheme: .sentimentScore)
        let sentimentScore = Double(sentiment?.rawValue ?? "0") ?? 0.0
        
        // 2. Keyword Matching for Contextual Responses
        if lower.contains("sad") || lower.contains("cry") || lower.contains("depressed") {
            return "Oh honey, come sit here with me. It's okay to feel sad. Even the sky has to cry sometimes to make the flowers grow. Take a deep breath. You are loved, so very loved."
        } else if lower.contains("anxious") || lower.contains("worried") || lower.contains("stress") {
            return "Take a deep breath with me, right now. In... and out... Good. Now, remember we can only control what's in front of us today. Leave tomorrow's worries for tomorrow."
        } else if lower.contains("angry") || lower.contains("mad") || lower.contains("frustrated") {
            return "I hear how frustrated you are, and your feelings are completely valid. But remember, holding onto a hot coal will only burn your own hand. Take a walk, get some fresh air."
        } else if lower.contains("love") || lower.contains("relationship") || lower.contains("friend") || lower.contains("breakup") {
            return "Relationships are like maintaining a garden. They take patience, water, and plenty of sunshine. You deserve a love that feels like home. Let time do its healing."
        } else if lower.contains("tired") || lower.contains("exhausted") || lower.contains("burnout") || lower.contains("sleep") {
            return "You've been carrying so much, my brave one. It's time to put the heavy bags down. Rest is not a weakness; it's how we heal. Please go get some sleep tonight."
        } else if lower.contains("happy") || lower.contains("good") || lower.contains("excited") || lower.contains("great") {
            return "Oh, that makes my heart flutter! I'm so incredibly happy for you! Remember this feeling, bottle it up, and save it for a rainy day. You deserve all the good things."
        } else if lower.contains("sick") || lower.contains("ill") || lower.contains("hurt") || lower.contains("pain") {
            return "Oh no, my dear. Make sure you're drinking plenty of warm fluids and getting enough rest. Your body is a temple, give it the time it needs to heal. I'm sending you a big, warm hug."
        } else if lower.contains("school") || lower.contains("job") || lower.contains("work") || lower.contains("study") {
            return "You are working so hard, and I am incredibly proud of you. Don't forget to take breaks. Your worth is not measured by your productivity, but by your beautiful heart."
        }
        
        // 3. Generative Fallbacks based on Core ML Sentiment Score
        if sentimentScore <= -0.2 {
            // Negative sentiment
            let negativeFallbacks = [
                "I hear you, sweetheart. Sometimes just saying it out loud makes the burden a little lighter. I'm always here to listen.",
                "That sounds like a heavy thing to carry alone. Remember you don't have to have all the answers right now. Give yourself some grace.",
                "Oh my dear, life can be so wonderfully complicated. Place your hand on your heart—that's where your truest wisdom lives.",
                "Have you had a glass of water today? Eaten a good meal? Sometimes our biggest problems just need the simplest care first."
            ]
            return negativeFallbacks.randomElement() ?? ""
        } else if sentimentScore >= 0.2 {
            // Positive sentiment
            let positiveFallbacks = [
                "That is so wonderful to hear! Your joy is contagious, my dear.",
                "It sounds like you're having a beautiful day. Let's celebrate that!",
                "Oh, you have such a bright light in you! Keep shining, sweetheart.",
                "That brought a big smile to my face. I'm so proud of the person you are."
            ]
            return positiveFallbacks.randomElement() ?? ""
        } else {
            // Neutral sentiment
            let neutralFallbacks = [
                "I'm right here with you, dear. Tell me more about that.",
                "That's very interesting. How does that make you feel deep down?",
                "Mmhmm, I'm listening. You can always share your thoughts with me.",
                "Life is indeed a journey full of surprises. What do you think you'll do next?"
            ]
            return neutralFallbacks.randomElement() ?? ""
        }
    }
    
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
                            .frame(width: 44, height: 44) // 50 -> 44
                        Text("👵🏻")
                            .font(.granlyTitle2) // Title -> Title2
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Chat with Grandma")
                            .font(.granlyHeadline)
                            .foregroundStyle(Color.themeText)
                        Text("Online • Ready to listen")
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
                                    Text("Grandma is typing...")
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
                    TextField("Tell Grandma what's on your mind...", text: $messageText)
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
                            .frame(width: 44, height: 44) // 50 -> 44
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
    }
    
    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(text: messageText, isUser: true)
        messages.append(userMessage)
        
        let userInput = messageText
        messageText = ""
        isThinking = true
        
        // Simulate thinking delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5...3.0)) {
            isThinking = false
            let response = generateGrandmaResponse(to: userInput)
            messages.append(ChatMessage(text: response, isUser: false))
        }
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
