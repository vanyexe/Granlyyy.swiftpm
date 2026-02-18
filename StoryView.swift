import SwiftUI
import AVFoundation
@preconcurrency import SceneKit

struct StoryView: View {
    let mood: Mood
    var storyToLoad: Story?
    @State private var story: Story?
    @StateObject private var speechManager = SpeechManager()
    @State private var animateAvatar = false
    @ObservedObject private var storyManager = StoryManager.shared
    @StateObject private var settings = GrandmaSettings() // Use settings
    @Environment(\.dismiss) private var dismiss
    
    // Tap Interaction
    @State private var showHeartToast = false
    @State private var toastMessage = "I love you, dear! 🤗"
    @State private var waveTrigger = false
    
    // 3D Actions & Expressions
    @State private var action: GrandmaAction = .idle
    @State private var expression: GrandmaExpression = .neutral
    
    // Compute expression based on mood and logic
    private func updateExpressionForMood() {
        switch mood.name.lowercased() {
        case "happy", "excited", "grateful":
            expression = .happy
        case "sad", "lonely":
            expression = .sad
        case "anxious":
            expression = .neutral // Calm
        default:
            expression = .neutral
        }
        
        // If speaking, maybe switch to happy/neutral or keep mood?
        // Let's keep mood as base expression.
    }
    
    private func updateActionForState() {
        if speechManager.isSpeaking {
            action = .tellStory
        } else if waveTrigger {
            action = .wave
        } else {
            action = .idle // or .listen if we had microphone input
        }
    }
    
    // Warm palette
    private var primaryColor: Color { mood.baseColor }
    private var bgGradient: [Color] {
        [primaryColor.opacity(0.6), Color.themeRose.opacity(0.3), Color(red: 0.15, green: 0.10, blue: 0.12)]
    }
    
    var body: some View {
        ZStack {
            // Warm Gradient Background
            LinearGradient(
                gradient: Gradient(colors: bgGradient),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
             // Apply Camera Filter overlay
             if settings.filter.colorFilter != nil {
                 Color.clear // Placeholder for actual CIFilter application in a real app, 
                 // using simple overlays for now:
             }
             if settings.filter == .sepia {
                 Color(red: 0.3, green: 0.2, blue: 0.1).opacity(0.3).ignoresSafeArea().allowsHitTesting(false)
             } else if settings.filter == .noir {
                 Color.black.opacity(0.4).saturation(0).ignoresSafeArea().allowsHitTesting(false)
             } else if settings.filter == .warm {
                 Color.orange.opacity(0.15).ignoresSafeArea().allowsHitTesting(false)
             } else if settings.filter == .cool {
                 Color.blue.opacity(0.15).ignoresSafeArea().allowsHitTesting(false)
             }
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.down")
                            .font(.title3.bold())
                    }
                    Spacer()
                    VStack(spacing: 2) {
                        Text("TELLING FROM")
                            .font(.caption2.bold())
                            .kerning(1)
                            .opacity(0.7)
                        Text(mood.name.uppercased())
                            .font(.caption.bold())
                    }
                    Spacer()
                    
                    // Share button
                    if let story = story {
                        ShareLink(item: "\(story.title)\n\n\(story.content)\n\n— From Granly App 💛") {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title3.bold())
                        }
                    } else {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title3.bold())
                            .opacity(0.3)
                    }
                }
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Grandma View
                ZStack {
                    Circle()
                        .fill(primaryColor.opacity(0.3))
                        .blur(radius: 40)
                    
                    GrandmaSceneView(
                        action: $action,
                        expression: $expression,
                        isSpeaking: $speechManager.isSpeaking,
                        settings: settings
                    )
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.white.opacity(0.15), lineWidth: 1))
                        .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 10)
                        .onTapGesture {
                            handleGrandmaTap()
                        }
                    
                    // Floating Toast
                    if showHeartToast {
                        Text(toastMessage)
                            .font(.subheadline.bold())
                            .foregroundStyle(Color.themeText)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.white.opacity(0.9))
                            .clipShape(Capsule())
                            .shadow(radius: 10)
                            .transition(.scale.combined(with: .opacity).combined(with: .move(edge: .bottom)))
                            .offset(y: -80) // Float above head
                            .zIndex(1)
                    }
                }
                .frame(height: 220)
                .padding(.vertical, 16)
                
                // Story Content and Controls (Same as before)
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 18) {
                            if let story = story {
                                let lines = splitToLines(story.content)
                                
                                Text(story.title)
                                    .font(.system(size: 30, weight: .bold, design: .serif))
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 16)
                                    .padding(.horizontal)
                                
                                ForEach(Array(lines.enumerated()), id: \.offset) { index, line in
                                    let isActive = isLineActive(index: index, lines: lines)
                                    
                                    Text(line)
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundStyle(isActive ? .white : .white.opacity(0.30))
                                        .padding(.horizontal)
                                        .multilineTextAlignment(.leading)
                                        .scaleEffect(isActive ? 1.01 : 1.0, anchor: .leading)
                                        .id(index)
                                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isActive)
                                }
                            } else {
                                ProgressView().tint(.white)
                            }
                        }
                        .padding(.bottom, 40)
                    }
                    .onChange(of: speechManager.spokenRange) { range in
                        guard let range = range, let story = story else { return }
                        let lines = splitToLines(story.content)
                        if let index = activeLineIndex(for: range, in: lines) {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                proxy.scrollTo(index, anchor: .center)
                            }
                        }
                    }
                }
                
                // Controls View
                ControlsView(speechManager: speechManager, storyManager: storyManager, story: $story, animateAvatar: $animateAvatar, mood: mood)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if let s = storyToLoad {
                story = s
            } else {
                story = StoryManager.shared.getStory(for: mood)
            }
            // Increment stories read
            let count = UserDefaults.standard.integer(forKey: "storiesRead")
            UserDefaults.standard.set(count + 1, forKey: "storiesRead")
        }
        .onChange(of: speechManager.isSpeaking) { speaking in
            animateAvatar = speaking
            updateActionForState()
        }
        .onChange(of: waveTrigger) { _ in updateActionForState() }
        .onAppear {
             updateExpressionForMood()
        }
        .onDisappear { speechManager.stop() }
    }
    
    // MARK: - Tap Handler
    private func handleGrandmaTap() {
        let messages = ["Hehe! 💕", "I love you, dear! 🤗", "You're doing great! ✨", "Always here for you 💛", "Oh my! How sweet 🌸"]
        toastMessage = messages.randomElement()!
        
        // Haptics
        let gen = UIImpactFeedbackGenerator(style: .medium)
        gen.impactOccurred()
        
        // Trigger Wave via Binding
        waveTrigger.toggle()
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            showHeartToast = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation { showHeartToast = false }
        }
    }
    
    // MARK: - Helpers
    private func splitToLines(_ content: String) -> [String] {
        content.components(separatedBy: CharacterSet(charactersIn: ".!?\n"))
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
    private func activeLineIndex(for range: NSRange, in lines: [String]) -> Int? {
        guard let story = story else { return nil }
        var currentOffset = 0
        for (index, line) in lines.enumerated() {
            if let lineRange = story.content.range(of: line, range: story.content.index(story.content.startIndex, offsetBy: currentOffset)..<story.content.endIndex) {
                let start = story.content.distance(from: story.content.startIndex, to: lineRange.lowerBound)
                let end = story.content.distance(from: story.content.startIndex, to: lineRange.upperBound)
                if range.location >= start && range.location <= end { return index }
                currentOffset = end
            }
        }
        return nil
    }
    
    private func isLineActive(index: Int, lines: [String]) -> Bool {
        guard let range = speechManager.spokenRange else { return false }
        return activeLineIndex(for: range, in: lines) == index
    }
}

struct ControlsView: View {
    @ObservedObject var speechManager: SpeechManager
    @ObservedObject var storyManager: StoryManager
    @Binding var story: Story?
    @Binding var animateAvatar: Bool
    let mood: Mood
    
    var body: some View {
        VStack(spacing: 18) {
            // Progress Bar
            VStack(spacing: 8) {
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .frame(height: 4)
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [Color.themeRose, Color.themeWarm],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: progressWidth(totalWidth: UIScreen.main.bounds.width - 40), height: 4)
                }
                
                HStack {
                    Text(formatProgress())
                    Spacer()
                    Text(formatDuration())
                }
                .font(.caption2.monospacedDigit())
                .foregroundStyle(.white.opacity(0.6))
            }
            .padding(.horizontal)
            
            // Buttons
            HStack(spacing: 0) {
                // Shuffle
                Button(action: {
                    speechManager.stop()
                    animateAvatar = false
                    story = StoryManager.shared.getRandomStory(for: mood)
                }) {
                    Image(systemName: "shuffle")
                        .font(.title3)
                        .foregroundStyle(Color.themeWarm)
                }
                .frame(maxWidth: .infinity)
                
                // Restart
                Button(action: {
                    speechManager.stop()
                    animateAvatar = false
                    if let c = story?.content {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            speechManager.speak(text: c)
                            animateAvatar = true
                        }
                    }
                }) {
                    Image(systemName: "backward.end.fill")
                        .font(.title2)
                }
                .frame(maxWidth: .infinity)
                
                // Play/Pause
                Button(action: {
                    if speechManager.isSpeaking {
                        speechManager.pause()
                        animateAvatar = false
                    } else {
                        if let c = story?.content {
                            speechManager.speak(text: c)
                            animateAvatar = true
                        }
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 66, height: 66)
                        Image(systemName: speechManager.isSpeaking ? "pause.fill" : "play.fill")
                            .font(.title.bold())
                            .foregroundStyle(Color(red: 0.15, green: 0.10, blue: 0.12))
                            .offset(x: speechManager.isSpeaking ? 0 : 2)
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Stop / Skip
                Button(action: {
                    speechManager.stop()
                    animateAvatar = false
                }) {
                    Image(systemName: "stop.fill")
                        .font(.title2)
                }
                .frame(maxWidth: .infinity)
                
                // Heart
                Button(action: {
                    if let s = story {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            storyManager.toggleLike(for: s)
                        }
                    }
                }) {
                    Image(systemName: (story != nil && storyManager.isLiked(story: story!)) ? "heart.fill" : "heart")
                        .font(.title3)
                        .foregroundStyle((story != nil && storyManager.isLiked(story: story!)) ? Color.themeRose : .white)
                }
                .frame(maxWidth: .infinity)
            }
            .foregroundStyle(.white)
            .padding(.bottom, 20)
        }
        .padding(.top, 8)
        .background(
            Color(red: 0.15, green: 0.10, blue: 0.12).opacity(0.9)
                .blur(radius: 20)
                .ignoresSafeArea()
        )
    }
    
    private func progressWidth(totalWidth: CGFloat) -> CGFloat {
        guard let range = speechManager.spokenRange, let total = story?.content.count, total > 0 else { return 0 }
        return CGFloat(range.location) / CGFloat(total) * totalWidth
    }
    
    private func formatProgress() -> String {
        guard let range = speechManager.spokenRange else { return "0:00" }
        let seconds = range.location / 15
        return String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
    
    private func formatDuration() -> String {
        guard let total = story?.content.count else { return "0:00" }
        let seconds = total / 15
        return String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
}




// MARK: - Speech Manager
class SpeechManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate, @unchecked Sendable {
    private var synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking = false
    @Published var spokenRange: NSRange?
    
    override init() {
        super.init()
        synthesizer.delegate = self
        
        // Configure audio session
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }
    }
    
    func speak(text: String) {
        stop()
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.45
        utterance.pitchMultiplier = 1.1
        utterance.volume = 1.0
        
        synthesizer.speak(utterance)
        isSpeaking = true
    }
    
    func pause() {
        if synthesizer.isSpeaking {
            synthesizer.pauseSpeaking(at: .immediate)
            isSpeaking = false
        }
    }
    
    func stop() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        isSpeaking = false
        spokenRange = nil
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        isSpeaking = true
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
        spokenRange = nil
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        spokenRange = characterRange
    }
}
