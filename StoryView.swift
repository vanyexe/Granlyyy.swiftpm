import SwiftUI
import AVFoundation
@preconcurrency import SceneKit

// MARK: - Story Player View  (Spotify-inspired)
struct StoryView: View {
    let mood: Mood
    var storyToLoad: Story?

    @State private var story: Story?
    @StateObject private var speechManager = SpeechManager()
    @State private var animateAvatar    = false
    @ObservedObject private var storyManager = StoryManager.shared
    @StateObject private var settings   = GrandmaSettings()
    @Environment(\.dismiss)      private var dismiss
    @EnvironmentObject var lang:          LanguageManager
    @Environment(\.colorScheme)  private var colorScheme

    // Avatar state
    @State private var action:     GrandmaAction    = .idle
    @State private var expression: GrandmaExpression = .neutral
    @State private var waveTrigger    = false
    @State private var showHeartToast = false
    @State private var toastMessage   = "I love you, dear!"

    // UI state
    @State private var artworkPulse  = false   // card breathes while speaking

    // MARK: Color helpers
    private var primaryColor: Color  { mood.baseColor }
    private var bgColors:    [Color] { mood.gradientColors(for: colorScheme) }
    private var textColor:   Color   { .white }
    private var subtleText:  Color   { .white.opacity(0.60) }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {

                // ─── Background: muted layered gradient + dark veil ──────
                ZStack {
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: bgColors[0].opacity(0.72), location: 0.00),
                            .init(color: bgColors[1].opacity(0.55), location: 0.50),
                            .init(color: bgColors[2].opacity(0.88), location: 1.00)
                        ]),
                        startPoint: .topLeading,
                        endPoint:   .bottomTrailing
                    )
                    // Dark readability veil
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(colorScheme == .dark ? 0.52 : 0.30),
                            Color.black.opacity(colorScheme == .dark ? 0.74 : 0.46)
                        ]),
                        startPoint: .top,
                        endPoint:   .bottom
                    )
                }
                .ignoresSafeArea()

                // ─── Filter overlays ─────────────────────────────────────
                Group {
                    if settings.filter == .sepia {
                        Color(red: 0.3, green: 0.2, blue: 0.1).opacity(0.22)
                    } else if settings.filter == .noir {
                        Color.black.opacity(0.45)
                    } else if settings.filter == .warm {
                        Color.orange.opacity(0.10)
                    } else if settings.filter == .cool {
                        Color.blue.opacity(0.10)
                    }
                }
                .ignoresSafeArea()
                .allowsHitTesting(false)

                // ─── Main content column ─────────────────────────────────
                VStack(spacing: 0) {

                    // ── Top Nav Bar ──────────────────────────────────────
                    HStack(alignment: .center) {
                        Button { dismiss() } label: {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 17, weight: .semibold))
                                .frame(width: 38, height: 38)
                                .background(.white.opacity(0.12), in: Circle())
                        }

                        Spacer()

                        VStack(spacing: 2) {
                            Text(L10n.t(.tellingFrom).uppercased())
                                .font(.system(size: 9, weight: .bold))
                                .kerning(1.6)
                                .foregroundStyle(subtleText)
                            Text(mood.localizedName(for: lang.selectedLanguage))
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(textColor)
                        }

                        Spacer()

                        if let story = story {
                            ShareLink(item: "\(story.title)\n\n\(story.content)\n\n— From Granly App") {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(width: 38, height: 38)
                                    .background(.white.opacity(0.12), in: Circle())
                            }
                        } else {
                            Color.clear.frame(width: 38, height: 38)
                        }
                    }
                    .foregroundStyle(textColor)
                    .padding(.horizontal, 24)
                    .padding(.top, 10)

                    // ── Artwork Card ─────────────────────────────────────
                    let cardSize: CGFloat = min(geo.size.width - 72, 290)
                    ZStack {
                        // Ambient glow
                        RoundedRectangle(cornerRadius: 28)
                            .fill(primaryColor.opacity(0.42))
                            .frame(width: cardSize + 20, height: cardSize + 20)
                            .blur(radius: 44)
                            .scaleEffect(artworkPulse ? 1.10 : 1.00)
                            .animation(.easeInOut(duration: 0.4), value: artworkPulse)

                        // Grandma SceneKit view
                        GrandmaSceneView(
                            action:     $action,
                            expression: $expression,
                            isSpeaking: $speechManager.isSpeaking,
                            settings:   settings
                        )
                        .frame(width: cardSize, height: cardSize)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(.white.opacity(0.14), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.50), radius: 32, x: 0, y: 18)
                        .scaleEffect(artworkPulse ? 1.025 : 1.00)
                        .animation(.easeInOut(duration: 0.4), value: artworkPulse)
                        .onTapGesture { handleGrandmaTap() }

                        // Heart toast
                        if showHeartToast {
                            HStack(spacing: 5) {
                                Text(toastMessage).font(.system(size: 13, weight: .medium))
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.themeRose)
                            }
                            .foregroundStyle(Color.black.opacity(0.82))
                            .padding(.horizontal, 14).padding(.vertical, 8)
                            .background(.white.opacity(0.92), in: Capsule())
                            .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 4)
                            .transition(.scale.combined(with: .opacity))
                            .offset(y: -(cardSize * 0.48))
                        }
                    }
                    .padding(.top, 22)

                    // ── Story Title + Mood subtitle ──────────────────────
                    VStack(spacing: 6) {
                        if let story = story {
                            Text(story.title)
                                .font(.system(size: 21, weight: .bold))
                                .foregroundStyle(textColor)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 28)
                        } else {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.white.opacity(0.20))
                                .frame(width: 160, height: 18)
                        }
                        HStack(spacing: 5) {
                            Image(systemName: mood.icon)
                                .font(.system(size: 11))
                                .foregroundStyle(primaryColor)
                            Text(mood.localizedName(for: lang.selectedLanguage))
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(subtleText)
                        }
                    }
                    .padding(.top, 16)

                    // ── Story Text — always visible, karaoke-style highlight ──────
                    if let story = story {
                        ProgressHighlightTextView(
                            text: story.content,
                            speakingRange: speechManager.speakingRange,
                            accentColor: primaryColor
                        )
                        .frame(maxHeight: 200)
                        .background(.black.opacity(0.18), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    }

                    Spacer(minLength: 0)

                    // ── Controls ─────────────────────────────────────────
                    ControlsView(
                        speechManager: speechManager,
                        storyManager:  storyManager,
                        story:         $story,
                        animateAvatar: $animateAvatar,
                        mood:          mood,
                        accentColor:   primaryColor
                    )
                } // VStack
            } // ZStack
        } // GeometryReader
        .navigationBarBackButtonHidden(true)
        .onAppear {
            story = storyToLoad ?? StoryManager.shared.getStory(for: mood)
            let n = UserDefaults.standard.integer(forKey: "storiesRead")
            UserDefaults.standard.set(n + 1, forKey: "storiesRead")
            updateExpressionForMood()
        }
        .onChange(of: speechManager.isSpeaking) { speaking in
            animateAvatar = speaking
            updateActionForState()
            withAnimation(.easeInOut(duration: 0.4)) { artworkPulse = speaking }
        }
        .onChange(of: waveTrigger) { _ in updateActionForState() }
        .onDisappear { speechManager.stop() }
    }

    // MARK: - Helpers
    private func updateExpressionForMood() {
        switch mood.name.lowercased() {
        case "happy", "excited", "grateful": expression = .happy
        case "sad", "lonely":               expression = .sad
        default:                            expression = .neutral
        }
    }

    private func updateActionForState() {
        if speechManager.isSpeaking { action = .tellStory }
        else if waveTrigger         { action = .wave }
        else                        { action = .idle }
    }

    private func handleGrandmaTap() {
        let msgs = [L10n.t(.toastHehe), L10n.t(.toastILoveYou), L10n.t(.toastYoureDoing), L10n.t(.toastAlwaysHere), L10n.t(.toastOhMy)]
        toastMessage = msgs.randomElement()!
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        waveTrigger.toggle()
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) { showHeartToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation { showHeartToast = false }
        }
    }
}

// MARK: - Mood Background (reusable)
struct MoodBackgroundView: View {
    let colors:      [Color]
    let accentColor: Color
    @State private var shimmerPhase = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: colors[0], location: 0.00),
                    .init(color: colors[1], location: 0.50),
                    .init(color: colors[2], location: 1.00)
                ]),
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Ellipse()
                .fill(RadialGradient(gradient: Gradient(colors: [accentColor.opacity(shimmerPhase ? 0.35 : 0.18), accentColor.opacity(0)]),
                                     center: .center, startRadius: 0, endRadius: 220))
                .frame(width: 340, height: 260)
                .offset(x: shimmerPhase ? 20 : -20, y: shimmerPhase ? -80 : -100)
                .blur(radius: 30).allowsHitTesting(false)

            Ellipse()
                .fill(RadialGradient(gradient: Gradient(colors: [colors[1].opacity(shimmerPhase ? 0.28 : 0.14), colors[1].opacity(0)]),
                                     center: .center, startRadius: 0, endRadius: 180))
                .frame(width: 280, height: 200)
                .offset(x: shimmerPhase ? -30 : 30, y: shimmerPhase ? 320 : 300)
                .blur(radius: 25).allowsHitTesting(false)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) { shimmerPhase = true }
        }
    }
}

// MARK: - Controls View  (Spotify-style bottom panel)
struct ControlsView: View {
    @ObservedObject var speechManager: SpeechManager
    @ObservedObject var storyManager:  StoryManager
    @Binding var story:        Story?
    @Binding var animateAvatar: Bool
    let mood:        Mood
    let accentColor: Color

    @State private var playPressed = false

    var body: some View {
        VStack(spacing: 0) {

            // Thin separator
            Rectangle()
                .fill(.white.opacity(0.09))
                .frame(height: 0.5)

            VStack(spacing: 18) {

                // ── Slim progress bar ────────────────────────────────
                VStack(spacing: 5) {
                    if speechManager.isPreparingAudio {
                        HStack {
                            Text("Preparing…")
                                .font(.system(size: 11))
                                .foregroundStyle(.white.opacity(0.55))
                            Spacer()
                            ProgressView().tint(.white.opacity(0.55)).scaleEffect(0.7)
                        }
                        .padding(.horizontal, 24)
                    } else {
                        GeometryReader { g in
                            let filled = progressWidth(totalWidth: g.size.width)
                            ZStack(alignment: .leading) {
                                Capsule().fill(.white.opacity(0.16)).frame(height: 3)
                                Capsule().fill(accentColor).frame(width: filled, height: 3)
                                Circle()
                                    .fill(.white)
                                    .frame(width: 14, height: 14)
                                    .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 1)
                                    .offset(x: max(0, filled - 7))
                            }
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { v in
                                        let ratio = max(0, min(1, v.location.x / g.size.width))
                                        speechManager.scrubbingStarted()
                                        speechManager.scrub(to: speechManager.duration * ratio)
                                    }
                                    .onEnded { _ in speechManager.scrubbingEnded() }
                            )
                        }
                        .frame(height: 14)
                        .padding(.horizontal, 24)
                    }

                    HStack {
                        Text(fmt(speechManager.currentTime))
                        Spacer()
                        Text(fmt(speechManager.duration))
                    }
                    .font(.system(size: 10, weight: .medium).monospacedDigit())
                    .foregroundStyle(.white.opacity(0.50))
                    .padding(.horizontal, 24)
                }
                .padding(.top, 14)

                // ── Playback buttons ─────────────────────────────────
                HStack(alignment: .center, spacing: 0) {

                    // Heart
                    Button {
                        if let s = story {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                storyManager.toggleLike(for: s)
                            }
                        }
                    } label: {
                        Image(systemName: liked ? "heart.fill" : "heart")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(liked ? Color.themeRose : .white.opacity(0.75))
                    }
                    .frame(maxWidth: .infinity)

                    // Restart
                    Button {
                        restart()
                    } label: {
                        Image(systemName: "backward.end.fill")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.88))
                    }
                    .frame(maxWidth: .infinity)

                    // ── Large Play / Pause ──
                    Button { handlePlayPause() } label: {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 68, height: 68)
                                .shadow(color: .black.opacity(0.28), radius: 14, x: 0, y: 7)
                            Image(systemName: speechManager.isSpeaking ? "pause.fill" : "play.fill")
                                .font(.system(size: 27, weight: .bold))
                                .foregroundStyle(.black.opacity(0.83))
                                .offset(x: speechManager.isSpeaking ? 0 : 2)
                        }
                        .scaleEffect(playPressed ? 0.91 : 1.00)
                        .animation(.spring(response: 0.22, dampingFraction: 0.6), value: playPressed)
                    }
                    .frame(maxWidth: .infinity)

                    // Stop
                    Button {
                        speechManager.stop()
                        animateAvatar = false
                    } label: {
                        Image(systemName: "stop.circle")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.88))
                    }
                    .frame(maxWidth: .infinity)

                    // Shuffle / next
                    Button {
                        speechManager.stop()
                        animateAvatar = false
                        story = StoryManager.shared.getRandomStory(for: mood)
                    } label: {
                        Image(systemName: "shuffle")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.75))
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 30)
            }
        }
        .background(
            ZStack {
                Color.black.opacity(0.34)
                VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
            }
            .ignoresSafeArea(edges: .bottom)
        )
    }

    // MARK: Computed helpers
    private var liked: Bool {
        guard let s = story else { return false }
        return storyManager.isLiked(story: s)
    }

    private func progressWidth(totalWidth: CGFloat) -> CGFloat {
        guard speechManager.duration > 0 else { return 0 }
        return totalWidth * CGFloat(speechManager.currentTime / speechManager.duration)
    }

    private func fmt(_ t: TimeInterval) -> String {
        let s = Int(t); return String(format: "%d:%02d", s / 60, s % 60)
    }

    private func handlePlayPause() {
        if speechManager.isPreparingAudio { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        playPressed = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { playPressed = false }

        if speechManager.isSpeaking {
            speechManager.pause(); animateAvatar = false
        } else if speechManager.duration > 0 && speechManager.currentTime < speechManager.duration {
            speechManager.resume(); animateAvatar = true
        } else if let c = story?.content {
            speechManager.speak(text: c); animateAvatar = true
        }
    }

    private func restart() {
        speechManager.stop(); animateAvatar = false
        if let c = story?.content {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                speechManager.speak(text: c); animateAvatar = true
            }
        }
    }
}

// MARK: - Karaoke-style cumulative progress highlight
/// Renders the story text with all already-spoken characters highlighted.
/// Spoken = full white/accent. Current word = glow. Remaining = dim.
@MainActor
struct ProgressHighlightTextView: View {
    let text: String
    let speakingRange: NSRange?
    let accentColor: Color

    // The character position up to which text has been spoken
    private var spokenUpTo: Int {
        guard let range = speakingRange else { return 0 }
        return range.location + range.length
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                // We use a Text built from AttributedString for smooth rendering
                Text(buildAttributedString())
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .lineSpacing(7)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 14)
                    .id("storyText")
                    .animation(.easeInOut(duration: 0.18), value: spokenUpTo)
            }
            .onChange(of: spokenUpTo) { _ in
                withAnimation(.easeInOut(duration: 0.25)) {
                    proxy.scrollTo("storyText", anchor: .bottom)
                }
            }
        }
    }

    private func buildAttributedString() -> AttributedString {
        var attributed = AttributedString(text)
        let nsString = text as NSString
        let totalLength = nsString.length
        let upTo = min(spokenUpTo, totalLength)

        // ── Past / spoken segment: bright, readable ──────────────────
        if upTo > 0 {
            let pastEnd = attributed.index(attributed.startIndex, offsetByCharacters: upTo)
            let pastRange = attributed.startIndex ..< pastEnd
            attributed[pastRange].foregroundColor = UIColor.white
        }

        // ── Current word: accent-colored glow ────────────────────────
        if let speaking = speakingRange {
            let wordStart = min(speaking.location, totalLength)
            let wordEnd   = min(speaking.location + speaking.length, totalLength)
            if wordStart < wordEnd {
                let si = attributed.index(attributed.startIndex, offsetByCharacters: wordStart)
                let ei = attributed.index(attributed.startIndex, offsetByCharacters: wordEnd)
                let wordRange = si ..< ei
                attributed[wordRange].foregroundColor = UIColor(accentColor)
            }
        }

        // ── Remaining / upcoming: dimmed ─────────────────────────────
        if upTo < totalLength {
            let futureStart = attributed.index(attributed.startIndex, offsetByCharacters: upTo)
            let futureRange = futureStart ..< attributed.endIndex
            attributed[futureRange].foregroundColor = UIColor.white.withAlphaComponent(0.35)
        }

        return attributed
    }
}

// MARK: - Thin UIKit blur wrapper  (avoids heavy background modifier)
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

// MARK: - Speech Manager  (direct AVSpeechSynthesizer — no file writing, no glitches)
/// Uses AVSpeechSynthesizer.speak() directly — pause/resume/stop via synthesizer API.
/// Progress is approximated from character position (willSpeakRange delegate).
class SpeechManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate, @unchecked Sendable {

    // MARK: Published state
    @Published var isSpeaking:       Bool         = false
    @Published var isPreparingAudio: Bool         = false   // kept for ControlsView compatibility
    @Published var currentTime:      TimeInterval = 0
    @Published var duration:         TimeInterval = 0
    @Published var speakingRange:    NSRange?     = nil

    // MARK: Internals
    private let synthesizer = AVSpeechSynthesizer()
    private var totalCharCount: Int  = 0
    private var progressTimer: Timer?
    private var isScrubbing          = false
    private var wasPlayingBeforeScrub = false
    private var currentText: String  = ""

    // MARK: - Init / Deinit
    override init() {
        super.init()
        synthesizer.delegate = self
        configureAudioSession()
        registerInterruptionObserver()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        progressTimer?.invalidate()
        synthesizer.stopSpeaking(at: .immediate)
    }

    // MARK: - Audio Session
    private func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .spokenAudio, options: [.duckOthers, .allowBluetoothHFP])
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("SpeechManager: audio session error — \(error)")
        }
    }

    private func registerInterruptionObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleInterruption(_:)),
            name:     AVAudioSession.interruptionNotification,
            object:   AVAudioSession.sharedInstance()
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleRouteChange(_:)),
            name:     AVAudioSession.routeChangeNotification,
            object:   AVAudioSession.sharedInstance()
        )
    }

    @objc private func handleInterruption(_ notification: Notification) {
        guard let info = notification.userInfo,
              let typeValue = info[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else { return }
        let optionsValue = info[AVAudioSessionInterruptionOptionKey] as? UInt
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if type == .began {
                self.synthesizer.pauseSpeaking(at: .word)
                self.isSpeaking = false
                self.stopProgressTimer()
            } else {
                if let val = optionsValue {
                    let opts = AVAudioSession.InterruptionOptions(rawValue: val)
                    if opts.contains(.shouldResume) { self.resume() }
                }
            }
        }
    }

    @objc private func handleRouteChange(_ notification: Notification) {
        guard let info = notification.userInfo,
              let reasonValue = info[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else { return }
        if reason == .oldDeviceUnavailable {
            DispatchQueue.main.async { [weak self] in self?.pause() }
        }
    }

    // MARK: - Public API

    func speak(text: String, languageBCP47: String? = nil) {
        stop()
        speakingRange    = nil
        let bcp47        = languageBCP47 ?? resolvedBCP47()
        currentText      = text
        totalCharCount   = text.count
        // Estimate duration: average 130 words/min, ~5 chars/word, at 0.78× rate
        let wordsPerSec  = (130.0 * 0.78) / 60.0
        let charsPerSec  = wordsPerSec * 5.0
        duration         = TimeInterval(totalCharCount) / charsPerSec
        currentTime      = 0

        let utterance             = AVSpeechUtterance(string: text)
        utterance.voice           = bestVoice(for: bcp47)
        utterance.rate            = AVSpeechUtteranceDefaultSpeechRate * 0.78
        utterance.pitchMultiplier = 1.08
        utterance.volume          = 0.95
        utterance.preUtteranceDelay = 0.1

        do { try AVAudioSession.sharedInstance().setActive(true) } catch {}
        synthesizer.speak(utterance)
    }

    func pause() {
        guard synthesizer.isSpeaking else { return }
        synthesizer.pauseSpeaking(at: .word)
        isSpeaking = false
        stopProgressTimer()
    }

    func resume() {
        guard synthesizer.isPaused else { return }
        do { try AVAudioSession.sharedInstance().setActive(true) } catch {}
        synthesizer.continueSpeaking()
        isSpeaking = true
        startProgressTimer()
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking       = false
        isPreparingAudio = false
        currentTime      = 0
        duration         = 0
        speakingRange    = nil
        stopProgressTimer()
    }

    /// Scrubbing is text-position based — we restart from a proportional offset into the text.
    func scrub(to time: TimeInterval) {
        let ratio   = duration > 0 ? max(0, min(1, time / duration)) : 0
        currentTime = time
        // Restart speech from estimated character position
        let charOffset = Int(ratio * Double(totalCharCount))
        guard charOffset < currentText.count else { return }
        let idx        = currentText.index(currentText.startIndex, offsetBy: charOffset)
        let remaining  = String(currentText[idx...])
        let wasPlaying = isSpeaking
        synthesizer.stopSpeaking(at: .immediate)
        if wasPlaying {
            let bcp47 = resolvedBCP47()
            let u = AVSpeechUtterance(string: remaining)
            u.voice           = bestVoice(for: bcp47)
            u.rate            = AVSpeechUtteranceDefaultSpeechRate * 0.78
            u.pitchMultiplier = 1.08
            u.volume          = 0.95
            synthesizer.speak(u)
        }
    }

    func scrubbingStarted() {
        isScrubbing = true
        wasPlayingBeforeScrub = isSpeaking
        if isSpeaking { synthesizer.pauseSpeaking(at: .word) }
    }

    func scrubbingEnded() {
        isScrubbing = false
        if wasPlayingBeforeScrub { synthesizer.continueSpeaking(); startProgressTimer() }
    }

    // MARK: - AVSpeechSynthesizerDelegate

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { [weak self] in
            self?.isSpeaking       = true
            self?.isPreparingAudio = false
            self?.startProgressTimer()
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        guard !isScrubbing, totalCharCount > 0 else { return }
        let ratio = Double(characterRange.location) / Double(totalCharCount)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.currentTime = self.duration * ratio
            self.speakingRange = characterRange
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.isSpeaking  = false
            self.currentTime = self.duration
            self.speakingRange = nil
            self.stopProgressTimer()
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { [weak self] in self?.isSpeaking = false }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { [weak self] in
            self?.isSpeaking = true
            self?.startProgressTimer()
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.isSpeaking  = false
            self.speakingRange = nil
            self.stopProgressTimer()
        }
    }

    // MARK: - Private helpers

    private func resolvedBCP47() -> String {
        let code = UserDefaults.standard.string(forKey: "selectedLanguage") ?? AppLanguage.english.rawValue
        return AppLanguage(rawValue: code)?.bcp47 ?? "en-US"
    }

    private func bestVoice(for bcp47: String) -> AVSpeechSynthesisVoice? {
        let all    = AVSpeechSynthesisVoice.speechVoices()
        let prefix = String(bcp47.prefix(2))
        var voice: AVSpeechSynthesisVoice?
        if #available(iOS 16.0, *) {
            voice = all.first(where: { $0.language.starts(with: prefix) && $0.gender == .female && $0.quality == .premium })
                 ?? all.first(where: { $0.language.starts(with: prefix) && $0.gender == .female && $0.quality == .enhanced })
        }
        return voice
            ?? all.first(where: { $0.language.starts(with: prefix) && $0.gender == .female })
            ?? all.first(where: { $0.language.starts(with: prefix) })
            ?? AVSpeechSynthesisVoice(language: bcp47)
    }

    private func startProgressTimer() {
        stopProgressTimer()
        // Fine-grained UI updates between willSpeakRange callbacks
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self, self.isSpeaking, !self.isScrubbing, self.duration > 0 else { return }
            // Gently nudge currentTime forward between delegate callbacks
            let newTime = min(self.currentTime + 0.1, self.duration)
            if newTime > self.currentTime {
                self.currentTime = newTime
            }
        }
    }

    private func stopProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
}

