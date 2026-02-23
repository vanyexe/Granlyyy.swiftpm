import SwiftUI
import AVFoundation
@preconcurrency import SceneKit
// SpeechManager & StoryView use LanguageManager for real-time TTS language switching

struct StoryView: View {
    let mood: Mood
    var storyToLoad: Story?
    @State private var story: Story?
    @StateObject private var speechManager = SpeechManager()
    @State private var animateAvatar = false
    @ObservedObject private var storyManager = StoryManager.shared
    @StateObject private var settings = GrandmaSettings() // Use settings
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var lang: LanguageManager
    
    // Tap Interaction
    @State private var showHeartToast = false
    @State private var toastMessage = "I love you, dear!"
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
                            .font(.granlyHeadline)
                    }
                    Spacer()
                    VStack(spacing: 2) {
                        Text(L10n.t(.tellingFrom))
                            .font(.granlyCaption)
                            .kerning(1)
                            .opacity(0.7)
                        Text(mood.localizedName(for: LanguageManager.shared.selectedLanguage).uppercased())
                            .font(.granlyCaption)
                    }
                    Spacer()
                    
                    // Share button
                    if let story = story {
                        ShareLink(item: "\(story.title)\n\n\(story.content)\n\n— From Granly App") {
                            Image(systemName: "square.and.arrow.up")
                                .font(.granlyHeadline)
                        }
                    } else {
                        Image(systemName: "square.and.arrow.up")
                            .font(.granlyHeadline)
                            .opacity(0.3)
                    }
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 20) // 16 -> 20 (more margin breathing room)
                .padding(.top, 4) // 10 -> 4 (tighter top)
                
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
                        HStack(spacing: 6) {
                            Text(toastMessage)
                                .font(.granlySubheadline)
                            Image(systemName: "heart.fill")
                                .font(.granlySubheadline)
                                .foregroundStyle(Color.themeRose)
                        }
                        .foregroundStyle(Color.themeText)
                        .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.white.opacity(0.9))
                            .clipShape(Capsule())
                            .shadow(radius: 10)
                            .transition(.scale.combined(with: .opacity).combined(with: .move(edge: .bottom)))
                            .offset(y: -80) // Float above head
                    }
                }
                .frame(height: 160) // 220 -> 160 (Much more compact header area)
                .padding(.vertical, 8) // 16 -> 8
                
                // Story Content and Controls
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 18) {
                        if let story = story {
                            let lines = splitToLines(story.content)
                            
                            Text(story.title)
                                .font(.granlyTitle2) // Title -> Title2 (Compact headers)
                                .foregroundStyle(.white)
                                .padding(.bottom, 8) // 16 -> 8
                                .padding(.horizontal, 24) // 16 -> 24
                            
                            ForEach(Array(lines.enumerated()), id: \.offset) { index, line in
                                Text(line)
                                    .font(.granlyHeadline) // 24pt custom -> Headline (Much sleeker reading size)
                                    .foregroundStyle(.white.opacity(0.85)) // Clean non-active look
                                    .padding(.horizontal, 24) // 16 -> 24
                                    .multilineTextAlignment(.leading)
                                    .id(index)
                                    .lineSpacing(4) // Add tighter line spacing for the body lines
                            }
                        } else {
                            ProgressView().tint(.white)
                        }
                    }
                    .padding(.bottom, 40)
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
        let messages = [L10n.t(.toastHehe), L10n.t(.toastILoveYou), L10n.t(.toastYoureDoing), L10n.t(.toastAlwaysHere), L10n.t(.toastOhMy)]
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
}

struct ControlsView: View {
    @ObservedObject var speechManager: SpeechManager
    @ObservedObject var storyManager: StoryManager
    @Binding var story: Story?
    @Binding var animateAvatar: Bool
    let mood: Mood
    
    var body: some View {
        VStack(spacing: 18) {
            // Scrubber
            VStack(spacing: 8) {
                if speechManager.isPreparingAudio {
                    ProgressView()
                        .tint(Color.themeRose)
                } else {
                    Slider(
                        value: Binding(
                            get: { speechManager.currentTime },
                            set: { newValue in
                                speechManager.scrub(to: newValue)
                            }
                        ),
                        in: 0...max(speechManager.duration, 0.1),
                        onEditingChanged: { editing in
                            if editing {
                                speechManager.scrubbingStarted()
                            } else {
                                speechManager.scrubbingEnded()
                            }
                        }
                    )
                    .tint(Color.themeRose)
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
                        .font(.granlyHeadline)
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
                        .font(.granlyTitle2)
                }
                .frame(maxWidth: .infinity)
                
                // Play/Pause
                Button(action: {
                    if speechManager.isPreparingAudio { return } // Prevent double clicks during TTS render
                    
                    if speechManager.isSpeaking {
                        speechManager.pause()
                        animateAvatar = false
                    } else {
                        if speechManager.duration > 0 && speechManager.currentTime < speechManager.duration {
                           speechManager.resume()
                           animateAvatar = true
                        } else {
                           if let c = story?.content {
                               speechManager.speak(text: c)
                               animateAvatar = true
                           }
                        }
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 66, height: 66)
                        Image(systemName: speechManager.isSpeaking ? "pause.fill" : "play.fill")
                            .font(.granlyTitle)
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
                        .font(.granlyTitle2)
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
                        .font(.granlyHeadline)
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
    
    private func formatProgress() -> String {
        let seconds = Int(speechManager.currentTime)
        return String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
    
    private func formatDuration() -> String {
        let seconds = Int(speechManager.duration)
        return String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
}




// MARK: - Speech Manager
class SpeechManager: NSObject, ObservableObject, AVAudioPlayerDelegate, @unchecked Sendable {
    private var synthesizer = AVSpeechSynthesizer()
    private var audioPlayer: AVAudioPlayer?
    private var progressTimer: Timer?
    private var isScrubbing = false
    private var writeTimer: Timer?
    private var generatedAudioFile: AVAudioFile?
    
    @Published var isSpeaking = false
    @Published var selectedRange: NSRange?
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    @Published var isPreparingAudio = false
    
    override init() {
        super.init()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }
    }
    
    func speak(text: String) {
        stop()
        isPreparingAudio = true
        
        let utterance = AVSpeechUtterance(string: text)
        let code = UserDefaults.standard.string(forKey: "selectedLanguage") ?? AppLanguage.english.rawValue
        let bcp47 = AppLanguage(rawValue: code)?.bcp47 ?? "en-US"
        let allVoices = AVSpeechSynthesisVoice.speechVoices()
        let langPrefix = String(bcp47.prefix(2))
        
        var voice: AVSpeechSynthesisVoice?
        if #available(iOS 16.0, *) {
            voice = allVoices.first(where: { $0.language.starts(with: langPrefix) && $0.gender == .female && $0.quality == .premium })
                ?? allVoices.first(where: { $0.language.starts(with: langPrefix) && $0.gender == .female && $0.quality == .enhanced })
        }
        voice = voice
            ?? allVoices.first(where: { $0.language.starts(with: langPrefix) && $0.gender == .female })
            ?? AVSpeechSynthesisVoice(language: bcp47)
            
        utterance.voice = voice
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.78
        utterance.pitchMultiplier = 1.08
        utterance.volume = 0.95
        
        // Render speech to an audio file
        let fileManager = FileManager.default
        let url = fileManager.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".caf")
        
        synthesizer.write(utterance) { [weak self] (buffer: AVAudioBuffer) in
            guard let self = self, let pcmBuffer = buffer as? AVAudioPCMBuffer else { return }
            
            do {
                if self.generatedAudioFile == nil {
                    self.generatedAudioFile = try AVAudioFile(forWriting: url, settings: pcmBuffer.format.settings, commonFormat: .pcmFormatInt16, interleaved: false)
                }
                try self.generatedAudioFile?.write(from: pcmBuffer)
            } catch {
                print("Error writing buffer: \(error)")
            }
            
            DispatchQueue.main.async {
                self.writeTimer?.invalidate()
                self.writeTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                    self.generatedAudioFile = nil // Close the file to allow reading
                    self.setupAudioPlayer(url: url)
                    self.isPreparingAudio = false
                }
            }
        }
    }
    
    private func setupAudioPlayer(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            duration = audioPlayer?.duration ?? 0
            audioPlayer?.play()
            isSpeaking = true
            startProgressTimer()
        } catch {
            print("Audio player error: \(error)")
        }
    }
    
    func pause() {
        audioPlayer?.pause()
        isSpeaking = false
        stopProgressTimer()
    }
    
    func resume() {
        audioPlayer?.play()
        isSpeaking = true
        startProgressTimer()
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        audioPlayer?.stop()
        audioPlayer = nil
        isSpeaking = false
        isPreparingAudio = false
        currentTime = 0
        duration = 0
        stopProgressTimer()
        writeTimer?.invalidate()
        writeTimer = nil
        generatedAudioFile = nil
    }
    
    // MARK: - Scrubbing
    
    func scrub(to time: TimeInterval) {
        currentTime = max(0, min(time, duration))
        audioPlayer?.currentTime = currentTime
    }
    
    func scrubbingStarted() {
        isScrubbing = true
        audioPlayer?.pause()
    }
    
    func scrubbingEnded() {
        isScrubbing = false
        if isSpeaking {
            audioPlayer?.play()
        }
    }
    
    // MARK: - Timer
    
    private func startProgressTimer() {
        stopProgressTimer()
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self, !self.isScrubbing, let player = self.audioPlayer else { return }
            self.currentTime = player.currentTime
        }
    }
    
    private func stopProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    // MARK: - AVAudioPlayerDelegate
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            self.isSpeaking = false
            self.currentTime = self.duration
            self.stopProgressTimer()
        }
    }
}
