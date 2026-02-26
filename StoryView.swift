import SwiftUI
import AVFoundation
@preconcurrency import SceneKit

// MARK: - Story Player View  (Spotify-inspired)
struct StoryView: View {
    let mood: Mood
    var storyToLoad: Story?

    @State private var story: Story?
    @ObservedObject private var audioService = AudioService.shared
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
    @State private var glowPhase     = false   // ambient background orbs

    // MARK: Color helpers
    private var primaryColor: Color  { mood.baseColor }
    private var bgColors:    [Color] { mood.gradientColors(for: colorScheme) }
    private var textColor:   Color   { .white }
    private var subtleText:  Color   { .white.opacity(0.55) }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {

                // ─── Cinematic Mood Canvas ────────────────────────────────
                // Deep, rich gradient using the mood palette — inspired by Apple Music
                MoodBackgroundView(colors: bgColors, accentColor: primaryColor)
                    .ignoresSafeArea()
                
                // Velvet dark veil: keeps text legible while preserving colour richness
                LinearGradient(
                    colors: [
                        Color.black.opacity(colorScheme == .dark ? 0.62 : 0.28),
                        Color.black.opacity(colorScheme == .dark ? 0.82 : 0.50)
                    ],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()

                // ─── Main content column ─────────────────────────────────
                VStack(spacing: 0) {

                    // ── Top Nav Bar (minimal) ────────────────────────────
                    HStack {
                        Button { dismiss() } label: {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: 38, height: 38)
                                .background(.white.opacity(0.12), in: Circle())
                                .overlay(Circle().stroke(.white.opacity(0.10), lineWidth: 1))
                        }

                        Spacer()

                        Text("Story Time")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white.opacity(0.70))
                            .tracking(0.8)
                            .textCase(.uppercase)

                        Spacer()

                        // Placeholder to balance the HStack
                        Color.clear.frame(width: 38, height: 38)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 20)

                    // ── Avatar Card (Centered Top) ───────────────────────
                    ZStack {
                        let cardSize: CGFloat = min(geo.size.width - 60, 240)
                        
                        // Outer glow
                        Circle()
                            .fill(primaryColor.opacity(artworkPulse ? 0.20 : 0.09))
                            .frame(width: cardSize + 40, height: cardSize + 40)
                            .blur(radius: 32)
                            .scaleEffect(artworkPulse ? 1.05 : 1.00)
                            .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: artworkPulse)

                        GrandmaSceneView(
                            action:     $action,
                            expression: $expression,
                            isSpeaking: $audioService.isPlaying,
                            settings:   settings
                        )
                        .frame(width: cardSize, height: cardSize)
                        // Soft depth shadow
                        .background(
                            RadialGradient(gradient: Gradient(colors: [.black.opacity(0.6), .clear]), center: .center, startRadius: 0, endRadius: cardSize/2 + 20)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: cardSize / 2, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: cardSize / 2, style: .continuous)
                                .stroke(.white.opacity(0.15), lineWidth: 1.5)
                        )
                        .shadow(color: primaryColor.opacity(0.30), radius: 30, x: 0, y: 15)
                        .shadow(color: .black.opacity(0.40), radius: 15, x: 0, y: 10)
                        .scaleEffect(artworkPulse ? 1.02 : 1.0)
                        .animation(.spring(response: 0.8, dampingFraction: 0.6).repeatForever(autoreverses: true), value: artworkPulse)
                        .onTapGesture { handleGrandmaTap() }
                        
                        // Heart toast 
                        if showHeartToast {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 34))
                                .foregroundStyle(Color.themeRose)
                                .shadow(radius: 6)
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .padding(.bottom, 16)

                    // ── Story Title + Mood Pill ─────────────────────────
                    if let story = story {
                        VStack(spacing: 10) {

                            // Title
                            Text(story.title)
                                .font(.system(size: 24, weight: .heavy, design: .rounded))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .shadow(color: primaryColor.opacity(0.55), radius: 10, y: 4)
                                .padding(.horizontal, 28)

                            // Mood pill
                            HStack(spacing: 6) {
                                Image(systemName: mood.icon)
                                    .font(.system(size: 11, weight: .semibold))
                                Text(mood.localizedName(for: lang.selectedLanguage))
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                            }
                            .foregroundStyle(primaryColor)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(primaryColor.opacity(0.18))
                                    .overlay(Capsule().stroke(primaryColor.opacity(0.35), lineWidth: 1))
                            )
                        }
                        .padding(.bottom, 16)
                    }

                    // ── Full Screen Karaoke Text Panel (Lyrics View) ─────────────────
                    if let story = story {
                        ProgressHighlightTextView(
                            text: story.content,
                            speakingRange: audioService.speakingRange,
                            accentColor: primaryColor
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 4)
                    }


                    Spacer(minLength: 0)

                    // ── Controls ─────────────────────────────────────────
                    ControlsView(
                        audioService:  audioService,
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
        .onChange(of: audioService.isPlaying) { speaking in
            animateAvatar = speaking
            updateActionForState()
            withAnimation(.easeInOut(duration: 0.5)) { artworkPulse = speaking }
        }
        .onChange(of: waveTrigger) { _ in updateActionForState() }
        .onDisappear { audioService.stopAudio() }
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
        if audioService.isPlaying { action = .tellStory }
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
    @ObservedObject var audioService: AudioService
    @ObservedObject var storyManager: StoryManager
    @Binding var story:        Story?
    @Binding var animateAvatar: Bool
    let mood:        Mood
    let accentColor: Color

    @State private var playPressed = false

    var body: some View {
        VStack(spacing: 0) {

            // Hairline divider
            Rectangle()
                .fill(.white.opacity(0.07))
                .frame(height: 0.5)

            VStack(spacing: 22) {

                // ── Progress bar ─────────────────────────────────────
                VStack(spacing: 6) {
                    if audioService.isPreparingAudio {
                        HStack {
                            Text("Preparing…")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(.white.opacity(0.45))
                            Spacer()
                            ProgressView().tint(.white.opacity(0.45)).scaleEffect(0.65)
                        }
                        .padding(.horizontal, 26)
                    } else {
                        GeometryReader { g in
                            let filled = progressWidth(totalWidth: g.size.width)
                            ZStack(alignment: .leading) {
                                // Track
                                Capsule()
                                    .fill(.white.opacity(0.15))
                                    .frame(height: 5)

                                // Gradient fill
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [accentColor.opacity(0.85), accentColor],
                                            startPoint: .leading, endPoint: .trailing
                                        )
                                    )
                                    .frame(width: filled, height: 5)
                                    .shadow(color: accentColor.opacity(audioService.isPlaying ? 0.6 : 0.0), radius: 6, x: 0, y: 0)
                                // Thumb
                                Circle()
                                    .fill(.white)
                                    .frame(width: 16, height: 16)
                                    .shadow(color: accentColor.opacity(0.7), radius: 8)
                                    .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 2)
                                    .offset(x: filled.isFinite ? max(0, filled - 8) : 0)
                                    .scaleEffect(audioService.isScrubbing ? 1.2 : 1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: audioService.isScrubbing)
                            }
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { v in
                                        let ratio = max(0, min(1, v.location.x / g.size.width))
                                        audioService.scrubbingStarted()
                                        audioService.scrub(to: audioService.duration * ratio)
                                    }
                                    .onEnded { _ in audioService.scrubbingEnded() }
                            )
                        }
                        .frame(height: 14)
                        .padding(.horizontal, 26)
                    }

                    HStack {
                        Text(fmt(audioService.currentTime))
                        Spacer()
                        Text(fmt(audioService.duration))
                    }
                    .font(.system(size: 10, weight: .medium).monospacedDigit())
                    .foregroundStyle(.white.opacity(0.38))
                    .padding(.horizontal, 26)
                }
                .padding(.top, 16)

                // ── Like / Share / Next Row ───────────────────────────
                HStack(spacing: 0) {

                    // Like
                    Button {
                        if let s = story {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                storyManager.toggleLike(for: s)
                            }
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: liked ? "heart.fill" : "heart")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(liked ? Color.themeRose : .white.opacity(0.75))
                                .scaleEffect(liked ? 1.15 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: liked)
                            Text(liked ? "Liked" : "Like")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(.white.opacity(0.45))
                        }
                    }
                    .frame(maxWidth: .infinity)

                    // Share
                    if let s = story {
                        ShareLink(item: "\(s.title)\n\n\(s.content)\n\n— From Granly") {
                            VStack(spacing: 4) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.75))
                                Text("Share")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundStyle(.white.opacity(0.45))
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }

                    // Next (shuffle)
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        audioService.stopAudio()
                        animateAvatar = false
                        story = StoryManager.shared.getRandomStory(for: mood)
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: "shuffle")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.75))
                            Text("Next")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(.white.opacity(0.45))
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 16)

                // ── Playback Buttons ─────────────────────────────────
                HStack(alignment: .center, spacing: 32) {

                    Spacer()

                    // Backward skip
                    Button { scrubRelative(by: -15) } label: {
                        Image(systemName: "gobackward.15")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.white.opacity(0.75))
                    }

                    // ── Large Play / Pause ──
                    Button { handlePlayPause() } label: {
                        ZStack {
                            // Layered shadow for depth
                            Circle()
                                .fill(accentColor.opacity(0.4))
                                .frame(width: 90, height: 90)
                                .blur(radius: 20)
                            
                            // Frosted Glass Effect inside button
                            Circle()
                                .fill(.white)
                                .frame(width: 74, height: 74)
                                .shadow(color: accentColor.opacity(0.6), radius: 20, x: 0, y: 8)
                                .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 6)
                            
                            Image(systemName: audioService.isPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 28, weight: .black))
                                .foregroundStyle(.black.opacity(0.85))
                                .offset(x: audioService.isPlaying ? 0 : 2)
                        }
                        .scaleEffect(playPressed ? 0.88 : (audioService.isPlaying ? 1.03 : 1.00))
                        .animation(.spring(response: 0.25, dampingFraction: 0.55), value: playPressed)
                        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: audioService.isPlaying)
                    }

                    // Forward skip
                    Button { scrubRelative(by: 15) } label: {
                        Image(systemName: "goforward.15")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.white.opacity(0.75))
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)

                // ── Like / Share / Next Row (below play button) ───────
                HStack(spacing: 0) {

                    // Like
                    Button {
                        if let s = story {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                storyManager.toggleLike(for: s)
                            }
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: liked ? "heart.fill" : "heart")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(liked ? Color.themeRose : .white.opacity(0.75))
                                .scaleEffect(liked ? 1.15 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: liked)
                            Text(liked ? "Liked" : "Like")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(.white.opacity(0.45))
                        }
                    }
                    .frame(maxWidth: .infinity)

                    // Share
                    if let s = story {
                        ShareLink(item: "\(s.title)\n\n\(s.content)\n\n— From Granly") {
                            VStack(spacing: 4) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.75))
                                Text("Share")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundStyle(.white.opacity(0.45))
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }

                    // Next (shuffle to random story)
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        audioService.stopAudio()
                        animateAvatar = false
                        story = StoryManager.shared.getRandomStory(for: mood)
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: "shuffle")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.75))
                            Text("Next")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(.white.opacity(0.45))
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 36)
            }
        }
        .background {
            ZStack {
                // Deep translucent base
                Color.black.opacity(0.28)
                // Frosted glass
                VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
            }
            .overlay(alignment: .top) {
                // Hairline separator with a subtle gradient fade
                LinearGradient(
                    colors: [.white.opacity(0.12), .white.opacity(0.04)],
                    startPoint: .leading, endPoint: .trailing
                )
                .frame(height: 0.5)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }

    // MARK: Computed helpers
    private var liked: Bool {
        guard let s = story else { return false }
        return storyManager.isLiked(story: s)
    }

    private func progressWidth(totalWidth: CGFloat) -> CGFloat {
        guard
            totalWidth.isFinite,
            totalWidth > 0,
            audioService.duration.isFinite,
            audioService.duration > 0,
            audioService.currentTime.isFinite
        else {
            return 0
        }

        let progress = audioService.currentTime / audioService.duration
        let clampedProgress = max(0, min(1, progress))

        return totalWidth * CGFloat(clampedProgress)
    }
    
    private func fmt(_ t: TimeInterval) -> String {
        let s = Int(t); return String(format: "%d:%02d", s / 60, s % 60)
    }

    private func handlePlayPause() {
        if audioService.isPreparingAudio { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        playPressed = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { playPressed = false }

        if audioService.isPlaying {
            audioService.pauseAudio(); animateAvatar = false
        } else if audioService.duration > 0 && audioService.currentTime < audioService.duration {
            audioService.resumeAudio(); animateAvatar = true
        } else if let c = story?.content {
            audioService.readText(c); animateAvatar = true
        }
    }

    private func scrubRelative(by seconds: TimeInterval) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        let newTime = max(0, min(audioService.duration, audioService.currentTime + seconds))
        audioService.scrub(to: newTime)
    }

    private func restart() {
        audioService.stopAudio(); animateAvatar = false
        if let c = story?.content {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                audioService.readText(c); animateAvatar = true
            }
        }
    }
}

// MARK: - Spotify-Style Scrolling Lyrics View
/// Spoken lines = bright white. Upcoming = dimmed.
/// Smoothly auto-scrolls line by line to keep the active line visible.
@MainActor
struct ProgressHighlightTextView: View {
    let text: String
    let speakingRange: NSRange?
    let accentColor: Color

    /// We break the story text into lines for Spotify-like tracking
    @State private var textSegments: [(id: Int, text: String, startIdx: Int, endIdx: Int)] = []
    
    // Derived state for the current line being spoken
    private var activeSegmentID: Int? {
        guard let s = speakingRange else { return nil }
        let location = s.location
        // Find whichever segment contains the start of the current word
        if let current = textSegments.first(where: { location >= $0.startIdx && location < $0.endIdx })?.id {
            return current
        }
        // Fallback to most recent spoken text
        return textSegments.last(where: { location >= $0.startIdx })?.id
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 32) { // Spotify style gap between lines
                    // Padding to allow scrolling the first line to the middle
                    Color.clear.frame(height: 60)
                    
                    ForEach(textSegments, id: \.id) { segment in
                        let status = segmentStatus(segment)
                        Text(segment.text)
                            .font(.system(size: 28, weight: .bold, design: .rounded)) // Elegant, massive text
                            .lineSpacing(6)
                            .multilineTextAlignment(.center)
                            // Bright white if active, slightly dimmed if passed, faded if upcoming
                            .foregroundColor(status == .active ? .white : (status == .passed ? .white.opacity(0.55) : .white.opacity(0.30)))
                            .shadow(color: .black.opacity(status == .active ? 0.4 : 0), radius: 6, x: 0, y: 3)
                            .id(segment.id)
                            .animation(.easeInOut(duration: 0.35), value: activeSegmentID)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    // Padding at the bottom to allow the last line to scroll up fully
                    Color.clear.frame(height: 250)
                }
                .padding(.horizontal, 24)
            }
            .onAppear {
                buildSegments()
            }
            .onChange(of: text) { _ in
                buildSegments()
            }
            // Auto-scroll logic: scroll softly to centered active line
            .onChange(of: activeSegmentID) { newID in
                if let newID = newID {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        proxy.scrollTo(newID, anchor: .center)
                    }
                }
            }
        }
    }
    
    enum SegmentStatus { case passed, active, upcoming }
    
    private func segmentStatus(_ segment: (id: Int, text: String, startIdx: Int, endIdx: Int)) -> SegmentStatus {
        guard let activeID = activeSegmentID else { return .upcoming }
        if segment.id < activeID { return .passed }
        if segment.id == activeID { return .active }
        return .upcoming
    }

    /// Breaks the text apart into localized sentences (or newline separated)
    private func buildSegments() {
        var segments: [(id: Int, text: String, startIdx: Int, endIdx: Int)] = []
        
        let nsText = text as NSString
        var currentPosition = 0
        var idCounter = 0
        
        // We'll split by double newlines or single newlines to get nice chunks.
        let paragraphs = text.components(separatedBy: .newlines).filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        
        // Since we need exact `NSRange` locations relative to the original text, we find their ranges
        for paragraph in paragraphs {
            let pString = paragraph.trimmingCharacters(in: .whitespaces)
            let searchRange = NSRange(location: currentPosition, length: nsText.length - currentPosition)
            let foundRange = nsText.range(of: pString, options: [], range: searchRange)
            
            if foundRange.location != NSNotFound {
                segments.append((
                    id: idCounter,
                    text: pString,
                    startIdx: foundRange.location,
                    endIdx: foundRange.location + foundRange.length
                ))
                currentPosition = foundRange.location + foundRange.length
                idCounter += 1
            }
        }
        
        self.textSegments = segments
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


