import SwiftUI

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
    
    // Simple mocked responses based on keywords
    private func generateGrandmaResponse(to input: String) -> String {
        let lower = input.lowercased()
        if lower.contains("sad") || lower.contains("cry") || lower.contains("depressed") {
            return "Oh honey, come sit here with me. It's okay to feel sad. Even the sky has to cry sometimes to make the flowers grow. Take a deep breath. You are loved, so very loved."
        } else if lower.contains("anxious") || lower.contains("worried") || lower.contains("stress") {
            return "Take a deep breath with me, right now. In... and out... Good. Now, remember we can only control what's in front of us today. Leave tomorrow's worries for tomorrow. You are stronger than you know."
        } else if lower.contains("angry") || lower.contains("mad") || lower.contains("frustrated") {
            return "I hear how frustrated you are, and your feelings are completely valid. But remember, holding onto a hot coal will only burn your own hand. Take a walk, get some fresh air, and let the heat pass before you decide what to do next."
        } else if lower.contains("love") || lower.contains("relationship") || lower.contains("friend") {
            return "Relationships are like maintaining a garden. They take patience, water, and plenty of sunshine. If someone isn't treating you kindly, remember your worth. You deserve a love that feels like home."
        } else if lower.contains("tired") || lower.contains("exhausted") || lower.contains("burnout") {
            return "You've been carrying so much, my brave one. It's time to put the heavy bags down. Even the strongest bears hibernate during winter. Rest is not a weakness; it's how we heal. Please go get some sleep tonight."
        } else {
            let fallbacks = [
                "I hear you, sweetheart. Sometimes just saying it out loud makes the burden a little lighter. I'm always here to listen.",
                "That sounds like a heavy thing to carry alone. Remember you don't have to have all the answers right now. Give yourself some grace.",
                "Oh my dear, life can be so wonderfully complicated. Whenever you feel lost, place your hand on your heart—that's where your truest wisdom lives.",
                "Have you had a glass of water today? Eaten a good meal? Sometimes our biggest problems just need the simplest care first."
            ]
            return fallbacks.randomElement() ?? ""
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
                            .frame(width: 50, height: 50)
                        Text("👵🏻")
                            .font(.title)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Chat with Grandma")
                            .font(.title3.bold())
                            .foregroundStyle(Color.themeText)
                        Text("Online • Ready to listen")
                            .font(.caption)
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
                            .font(.title3)
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
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
                .font(.body)
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
