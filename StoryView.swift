import SwiftUI
import AVFoundation
@preconcurrency import SceneKit

// MARK: - Story Line Model (for binary-search sync engine)
struct StoryLine: Identifiable, Sendable {
    let id: Int
    let text: String
    let startRatio: Double   // 0.0 – 1.0 of total chars
    let endRatio: Double
}

// MARK: - Sync Engine
@MainActor
final class StorySyncEngine {

    private(set) var lines: [StoryLine] = []
    private var startRatios: [Double] = []

    func load(text: String) {
        guard !text.isEmpty else { lines = []; startRatios = []; return }
        let totalChars = Double(text.count)
        var result: [StoryLine] = []
        // Split into sentences using natural language boundaries
        let raw = text.components(separatedBy: CharacterSet(charactersIn: "।.!?।\n"))
                      .map { $0.trimmingCharacters(in: .whitespaces) }
                      .filter { !$0.isEmpty }

        var charCursor = 0
        for (i, sentence) in raw.enumerated() {
            let start = Double(charCursor) / totalChars
            charCursor += sentence.count + 1   // +1 for the delimiter
            let end   = Double(min(charCursor, text.count)) / totalChars
            result.append(StoryLine(id: i, text: sentence, startRatio: start, endRatio: min(end, 1.0)))
        }
        lines = result
        startRatios = result.map { $0.startRatio }
    }

    /// O(log n) binary search
    func findIndex(for ratio: Double) -> Int {
        guard !startRatios.isEmpty else { return 0 }
        var lo = 0, hi = startRatios.count - 1
        while lo <= hi {
            let mid = (lo + hi) / 2
            if startRatios[mid] <= ratio {
                if mid + 1 < startRatios.count && startRatios[mid + 1] <= ratio {
                    lo = mid + 1
                } else {
                    return mid
                }
            } else {
                hi = mid - 1
            }
        }
        return max(0, min(startRatios.count - 1, lo))
    }
}

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

    // UI state
    @State private var artworkPulse   = false
    @State private var showFullLyrics = false
    @State private var showMoreMenu   = false

    // Sync engine
    @State private var syncEngine     = StorySyncEngine()
    @State private var currentLineIdx = 0
    @State private var lastScrolledIndex = -1
    @State private var isUserScrolling   = false

    // MARK: Color helpers
    private var primaryColor: Color  { mood.baseColor }
    private var bgColors:    [Color] { mood.gradientColors(for: colorScheme) }

    // Card background colour — warm amber like Spotify's lyrics card
    private var cardAccent: Color {
        Color(red: 0.76, green: 0.40, blue: 0.12)
    }

    // Derived current char ratio from AudioService
    private var currentRatio: Double {
        guard audioService.duration > 0 else { return 0 }
        return min(1, max(0, audioService.currentTime / audioService.duration))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {

                // ── Cinematic Mood Canvas ──────────────────────────────
                MoodBackgroundView(colors: bgColors, accentColor: primaryColor)
                    .ignoresSafeArea()
                // Velvet veil
                LinearGradient(
                    colors: [Color.black.opacity(0.55), Color.black.opacity(0.80)],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()

                // ── Main scroll content ────────────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // 1. TOP HEADER ─────────────────────────────────
                        topHeader
                            .padding(.top, geo.safeAreaInsets.top + 4)
                            .padding(.bottom, 16)

                        // 2. 3D MODEL (album-art area) ──────────────────
                        let cardSize: CGFloat = {
                            let w = max(geo.size.width, 0)
                            return max(min(w - 64, 300), 120)
                        }()
                        avatarCard(size: cardSize)
                            .padding(.horizontal, 32)
                            .padding(.bottom, 24)

                        // 3. TITLE ROW ──────────────────────────────────
                        if let story = story {
                            titleRow(story: story)
                                .padding(.horizontal, 28)
                                .padding(.bottom, 20)
                        }

                        // 4. SEEK BAR ───────────────────────────────────
                        seekBarSection
                            .padding(.horizontal, 28)
                            .padding(.bottom, 20)

                        // 5. PLAYBACK CONTROLS ──────────────────────────
                        controlsRow
                            .padding(.horizontal, 20)
                            .padding(.bottom, 16)

                        // 6. UTILITY BAR ────────────────────────────────
                        utilityBar
                            .padding(.horizontal, 28)
                            .padding(.bottom, 24)

                        // 7. STORY PREVIEW CARD ─────────────────────────
                        if let story = story, !syncEngine.lines.isEmpty {
                            storyPreviewCard(story: story)
                                .padding(.horizontal, 16)
                                .padding(.bottom, geo.safeAreaInsets.bottom + 24)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showFullLyrics) {
            if let story = story {
                StoryLyricsFullView(
                    story: story,
                    audioService: audioService,
                    syncEngine: syncEngine,
                    accentColor: cardAccent
                )
            }
        }
        .onAppear {
            story = storyToLoad ?? StoryManager.shared.getStory(for: mood)
            UserDefaults.standard.set(
                UserDefaults.standard.integer(forKey: "storiesRead") + 1,
                forKey: "storiesRead"
            )
            updateExpressionForMood()
            if let s = story { syncEngine.load(text: s.content) }
        }
        .onChange(of: story?.content) { content in
            if let content = content { syncEngine.load(text: content) }
        }
        .onChange(of: audioService.speakingRange) { _ in
            let idx = syncEngine.findIndex(for: currentRatio)
            if idx != currentLineIdx { currentLineIdx = idx }
        }
        .onChange(of: audioService.isPlaying) { speaking in
            animateAvatar = speaking
            updateActionForState()
            withAnimation(.easeInOut(duration: 0.5)) { artworkPulse = speaking }
        }
        .onChange(of: waveTrigger) { _ in updateActionForState() }
        .onDisappear { audioService.stopAudio() }
    }

    // MARK: ── 1. Top Header ─────────────────────────────────────────
    private var topHeader: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.down")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 38, height: 38)
                    .background(.white.opacity(0.10), in: Circle())
            }
            Spacer()
            VStack(spacing: 2) {
                Text("PLAYING FROM YOUR LIBRARY")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.60))
                    .tracking(0.8)
                Text("Grandma's Stories")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }
            Spacer()
            Menu {
                Button { showMoreMenu = false } label: { Label("Share Story", systemImage: "square.and.arrow.up") }
                Button(role: .destructive) { audioService.stopAudio() } label: { Label("Stop Playback", systemImage: "stop.fill") }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 38, height: 38)
                    .background(.white.opacity(0.10), in: Circle())
            }
        }
        .padding(.horizontal, 20)
    }

    // MARK: ── 2. Avatar Card ─────────────────────────────────────────
    private func avatarCard(size: CGFloat) -> some View {
        ZStack {
            // Ambient glow
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(primaryColor.opacity(artworkPulse ? 0.22 : 0.10))
                .frame(width: size + 24, height: size + 24)
                .blur(radius: 28)
                .scaleEffect(artworkPulse ? 1.04 : 1.0)
                .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: artworkPulse)

            GrandmaSceneView(
                action:     $action,
                expression: $expression,
                isSpeaking: $audioService.isPlaying,
                settings:   settings
            )
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.white.opacity(0.12), lineWidth: 1.5)
            )
            .shadow(color: primaryColor.opacity(0.30), radius: 28, x: 0, y: 14)
            .shadow(color: .black.opacity(0.50), radius: 18, x: 0, y: 10)
            .scaleEffect(artworkPulse ? 1.018 : 1.0)
            .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: artworkPulse)
            .onTapGesture { handleGrandmaTap() }

            // Heart pop-up toast
            if showHeartToast {
                Image(systemName: "heart.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(Color.themeRose)
                    .shadow(radius: 8)
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }

    // MARK: ── 3. Title Row ───────────────────────────────────────────
    private func titleRow(story: Story) -> some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(story.title)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                Text("Narrated by Grandma")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white.opacity(0.60))
            }
            Spacer()
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                    storyManager.toggleLike(for: story)
                }
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            } label: {
                let liked = storyManager.isLiked(story: story)
                Image(systemName: liked ? "heart.fill" : "heart")
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundStyle(liked ? Color.themeRose : .white.opacity(0.60))
                    .scaleEffect(liked ? 1.12 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: liked)
            }
            .padding(.top, 2)
        }
    }

    // MARK: ── 4. Seek Bar ────────────────────────────────────────────
    private var seekBarSection: some View {
        VStack(spacing: 8) {
            if audioService.isPreparingAudio {
                HStack {
                    Text("Preparing story…")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white.opacity(0.50))
                    Spacer()
                    ProgressView().tint(.white.opacity(0.5)).scaleEffect(0.7)
                }
            } else {
                GeometryReader { g in
                    let totalW = max(g.size.width, 1)
                    let filled = totalW * CGFloat(max(0, min(1, currentRatio)))
                    ZStack(alignment: .leading) {
                        // Track
                        Capsule()
                            .fill(.white.opacity(0.22))
                            .frame(height: 4)
                        // Fill
                        Capsule()
                            .fill(.white)
                            .frame(width: filled, height: 4)
                        // Thumb
                        Circle()
                            .fill(.white)
                            .frame(width: 16, height: 16)
                            .shadow(color: .black.opacity(0.35), radius: 6)
                            .offset(x: filled.isFinite ? max(0, filled - 8) : 0)
                            .scaleEffect(audioService.isScrubbing ? 1.45 : 1.0)
                            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: audioService.isScrubbing)
                    }
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { v in
                                let ratio = max(0, min(1, v.location.x / totalW))
                                audioService.scrubbingStarted()
                                audioService.scrub(to: audioService.duration * ratio)
                            }
                            .onEnded { _ in audioService.scrubbingEnded() }
                    )
                }
                .frame(height: 14)
            }

            HStack {
                Text(fmtTime(audioService.currentTime))
                Spacer()
                Text(fmtTime(audioService.duration))
            }
            .font(.system(size: 13, weight: .medium).monospacedDigit())
            .foregroundStyle(.white.opacity(0.60))
        }
    }

    // MARK: ── 5. Controls ────────────────────────────────────────────
    private var controlsRow: some View {
        HStack(alignment: .center, spacing: 0) {

            // Shuffle
            Button {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                audioService.stopAudio(); animateAvatar = false
                story = StoryManager.shared.getRandomStory(for: mood)
            } label: {
                Image(systemName: "shuffle")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white.opacity(0.70))
            }
            .frame(maxWidth: .infinity)

            // Restart
            Button {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                audioService.stopAudio(); animateAvatar = false
                if let c = story?.content {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                        audioService.readText(c); animateAvatar = true
                    }
                }
            } label: {
                Image(systemName: "backward.end.fill")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)

            // Play / Pause
            Button {
                guard !audioService.isPreparingAudio else { return }
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                if audioService.isPlaying {
                    audioService.pauseAudio(); animateAvatar = false
                } else if audioService.duration > 0 && audioService.currentTime < audioService.duration {
                    audioService.resumeAudio(); animateAvatar = true
                } else if let c = story?.content {
                    audioService.readText(c); animateAvatar = true
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 72, height: 72)
                        .shadow(color: .black.opacity(0.25), radius: 12, y: 5)
                    if audioService.isPreparingAudio {
                        ProgressView().tint(.black).scaleEffect(1.0)
                    } else {
                        Image(systemName: audioService.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 30, weight: .black))
                            .foregroundStyle(.black)
                            .offset(x: audioService.isPlaying ? 0 : 3)
                    }
                }
            }
            .frame(maxWidth: .infinity)

            // +15s forward
            Button {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                audioService.scrub(to: min(audioService.duration, audioService.currentTime + 15))
            } label: {
                Image(systemName: "goforward.15")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)

            // Timer
            Button {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } label: {
                Image(systemName: "timer")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.white.opacity(0.60))
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: ── 6. Utility Bar ─────────────────────────────────────────
    private var utilityBar: some View {
        HStack {
            Image(systemName: "hifispeaker.2")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white.opacity(0.50))

            Spacer()

            if let s = story {
                ShareLink(item: "\(s.title)\n\n\(s.content)\n\n— From Granly") {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white.opacity(0.50))
                }
            }

            Spacer()

            Button {
                showFullLyrics = true
            } label: {
                Image(systemName: "list.bullet")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white.opacity(0.50))
            }
        }
    }

    // MARK: ── 7. Story Preview Card ──────────────────────────────────
    private func storyPreviewCard(story: Story) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // Card header
            HStack {
                Text("STORY PREVIEW")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.75))
                    .tracking(0.8)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 18)
            .padding(.bottom, 14)

            // Lines preview (5 lines max)
            let previewLines = Array(syncEngine.lines.prefix(currentLineIdx + 5).suffix(5))
            VStack(alignment: .leading, spacing: 8) {
                ForEach(previewLines) { line in
                    let state = lineState(for: line.id)
                    Text(line.text)
                        .font(.system(size: 15, weight: state == .active ? .semibold : .regular))
                        .foregroundStyle(.white.opacity(
                            state == .active ? 1.0 :
                            state == .passed ? 0.38 : 0.62
                        ))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .animation(.easeInOut(duration: 0.25), value: currentLineIdx)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)

            // Show Full Story button
            Button {
                showFullLyrics = true
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } label: {
                Text("Show Full Story")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(cardAccent)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 9)
                    .background(.white, in: Capsule())
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(cardAccent)
        )
    }

    // MARK: - Line state helper
    private enum LineState { case passed, active, upcoming }
    private func lineState(for id: Int) -> LineState {
        if id < currentLineIdx  { return .passed }
        if id == currentLineIdx { return .active }
        return .upcoming
    }

    // MARK: - Helpers
    private func fmtTime(_ t: TimeInterval) -> String {
        let s = max(0, Int(t)); return String(format: "%d:%02d", s / 60, s % 60)
    }

    private func seekBarWidth(totalWidth: CGFloat) -> CGFloat {
        guard audioService.duration > 0, totalWidth > 0 else { return 0 }
        return totalWidth * CGFloat(currentRatio)
    }

    private func updateExpressionForMood() {
        switch mood.name.lowercased() {
        case "happy", "excited", "grateful": expression = .happy
        case "sad", "lonely":               expression = .sad
        default:                            expression = .neutral
        }
    }

    private func updateActionForState() {
        if audioService.isPlaying { action = .tellStory }
        else if waveTrigger        { action = .wave }
        else                       { action = .idle }
    }

    private func handleGrandmaTap() {
        let msgs = [L10n.t(.toastHehe), L10n.t(.toastILoveYou), L10n.t(.toastYoureDoing), L10n.t(.toastAlwaysHere), L10n.t(.toastOhMy)]
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        waveTrigger.toggle()
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) { showHeartToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation { showHeartToast = false }
        }
    }
}

// MARK: - Full-Screen Story Lyrics Sheet
struct StoryLyricsFullView: View {
    let story: Story
    @ObservedObject var audioService: AudioService
    let syncEngine: StorySyncEngine
    let accentColor: Color

    @Environment(\.dismiss) private var dismiss
    @State private var currentLineIdx    = 0
    @State private var lastScrolledIndex = -1
    @State private var isUserScrolling   = false

    private var currentRatio: Double {
        guard audioService.duration > 0 else { return 0 }
        return min(1, max(0, audioService.currentTime / audioService.duration))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 28) {
                            ForEach(syncEngine.lines) { line in
                                let state = lineState(for: line.id)
                                Text(line.text)
                                    .font(.system(size: 28, weight: state == .active ? .heavy : .bold, design: .rounded))
                                    .foregroundStyle(.white.opacity(
                                        state == .active ? 1.0 :
                                        state == .passed ? 0.35 : 0.55
                                    ))
                                    .multilineTextAlignment(.leading)
                                    .animation(.easeInOut(duration: 0.25), value: currentLineIdx)
                                    .id(line.id)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 32)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        // User scroll suppression gesture
                        .gesture(
                            DragGesture()
                                .onChanged { _ in isUserScrolling = true }
                                .onEnded { _ in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                        isUserScrolling = false
                                    }
                                }
                        )
                    }
                    .onChange(of: currentLineIdx) { newIdx in
                        guard newIdx != lastScrolledIndex, !isUserScrolling, !syncEngine.lines.isEmpty else { return }
                        lastScrolledIndex = newIdx
                        withAnimation(.easeInOut(duration: 0.35)) {
                            proxy.scrollTo(newIdx, anchor: .center)
                        }
                    }
                }
            }
            .navigationTitle(story.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 8) {
                        if audioService.isPlaying {
                            Image(systemName: "waveform")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(accentColor)
                        }
                        Text(audioService.isPlaying ? "Playing" : "Paused")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.white.opacity(0.55))
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(.white.opacity(0.55))
                    }
                }
            }
        }
        .onChange(of: audioService.speakingRange) { _ in
            let idx = syncEngine.findIndex(for: currentRatio)
            if idx != currentLineIdx { currentLineIdx = idx }
        }
    }

    private enum LineState { case passed, active, upcoming }
    private func lineState(for id: Int) -> LineState {
        if id < currentLineIdx  { return .passed }
        if id == currentLineIdx { return .active }
        return .upcoming
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
                    .init(color: colors.first ?? .black, location: 0),
                    .init(color: colors.last ?? .black,  location: 1)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Ellipse()
                .fill(RadialGradient(gradient: Gradient(colors: [accentColor.opacity(shimmerPhase ? 0.35 : 0.18), accentColor.opacity(0)]),
                                     center: .center, startRadius: 0, endRadius: 220))
                .frame(width: 340, height: 260)
                .offset(x: shimmerPhase ? 20 : -20, y: shimmerPhase ? -80 : -100)
                .blur(radius: 30).allowsHitTesting(false)

            Ellipse()
                .fill(RadialGradient(gradient: Gradient(colors: [
                    (colors.count > 1 ? colors[1] : accentColor).opacity(shimmerPhase ? 0.28 : 0.14),
                    (colors.count > 1 ? colors[1] : accentColor).opacity(0)
                ]),
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

// MARK: - Visual Effect Blur
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}


