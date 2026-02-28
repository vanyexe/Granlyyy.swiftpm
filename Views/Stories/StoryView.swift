import SwiftUI
import AVFoundation
@preconcurrency import SceneKit

struct StoryLine: Identifiable, Sendable {
    let id: Int
    let text: String
    let startRatio: Double
    let endRatio: Double
}

@MainActor
final class StorySyncEngine {

    private(set) var lines: [StoryLine] = []
    private var startRatios: [Double] = []

    func load(text: String) {
        guard !text.isEmpty else { lines = []; startRatios = []; return }
        let totalChars = Double(text.count)
        var result: [StoryLine] = []

        let raw = text.components(separatedBy: CharacterSet(charactersIn: "।.!?।\n"))
                      .map { $0.trimmingCharacters(in: .whitespaces) }
                      .filter { !$0.isEmpty }

        var charCursor = 0
        for (i, sentence) in raw.enumerated() {
            let start = Double(charCursor) / totalChars
            charCursor += sentence.count + 1
            let end   = Double(min(charCursor, text.count)) / totalChars
            result.append(StoryLine(id: i, text: sentence, startRatio: start, endRatio: min(end, 1.0)))
        }
        lines = result
        startRatios = result.map { $0.startRatio }
    }

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

    @State private var action:     GrandmaAction    = .idle
    @State private var expression: GrandmaExpression = .neutral
    @State private var waveTrigger    = false
    @State private var showHeartToast = false

    @State private var artworkPulse   = false
    @State private var showFullLyrics = false
    @State private var showMoreMenu   = false
    @State private var showTimerSheet = false

    @State private var syncEngine     = StorySyncEngine()
    @State private var currentLineIdx = 0
    @State private var lastScrolledIndex = -1
    @State private var isUserScrolling   = false

    private var primaryColor: Color  { mood.baseColor }
    private var bgColors:    [Color] { mood.gradientColors(for: colorScheme) }

    private var cardAccent: Color {
        Color(red: 0.45, green: 0.28, blue: 0.14)
    }

    private var softWhite: Color {
        Color(red: 0.98, green: 0.95, blue: 0.90)
    }

    private var creamMuted: Color {
        Color(red: 0.94, green: 0.88, blue: 0.78)
    }

    private var currentRatio: Double {
        guard audioService.duration > 0 else { return 0 }
        return min(1, max(0, audioService.currentTime / audioService.duration))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {

                MoodBackgroundView(colors: bgColors, accentColor: primaryColor)
                    .ignoresSafeArea()

                LinearGradient(
                    colors: [
                        Color(red: 0.10, green: 0.06, blue: 0.03).opacity(0.40),
                        Color(red: 0.08, green: 0.05, blue: 0.02).opacity(0.68)
                    ],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        topHeader
                            .padding(.top, 16)
                            .padding(.bottom, 8)
                            .padding(.horizontal, 24)

                        let avatarSize = min(geo.size.width - 48, 360)
                        avatarCard(size: max(avatarSize, 100))
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 28)

                        if let story = story {
                            titleRow(story: story)
                                .padding(.horizontal, 24)
                                .padding(.bottom, 20)
                        }

                        seekBarSection
                            .padding(.horizontal, 24)
                            .padding(.bottom, 20)

                        controlsRow
                            .padding(.horizontal, 24)
                            .padding(.bottom, 20)

                        utilityBar
                            .padding(.horizontal, 24)
                            .padding(.bottom, 28)

                        if let story = story, !syncEngine.lines.isEmpty {
                            storyPreviewCard(story: story)
                                .padding(.horizontal, 16)
                                .padding(.bottom, geo.safeAreaInsets.bottom + 24)
                        }
                    }
                    .frame(maxWidth: min(geo.size.width, 500))
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
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

    private var topHeader: some View {
        HStack(alignment: .center, spacing: 0) {

            Button { dismiss() } label: {
                Image(systemName: "chevron.down")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(softWhite)
                    .frame(width: 40, height: 40)
                    .background(.white.opacity(0.16), in: Circle())
            }

            VStack(spacing: 2) {
                Text(L10n.t(.playingFromLibrary))
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(creamMuted.opacity(0.80))
                    .tracking(0.8)
                Text(L10n.t(.grandmasStories))
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(softWhite)
            }
            .frame(maxWidth: .infinity)

            Menu {
                if let s = story {
                    ShareLink(item: "\(s.title)\n\n\(s.content)\n\n— From Granly") {
                        Label(L10n.t(.shareStory), systemImage: "square.and.arrow.up")
                    }
                }
                Button(role: .destructive) { audioService.stopAudio() } label: { Label(L10n.t(.stopPlayback), systemImage: "stop.fill") }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(softWhite)
                    .frame(width: 40, height: 40)
                    .background(.white.opacity(0.16), in: Circle())
            }
        }
    }

    private func avatarCard(size: CGFloat) -> some View {
        ZStack {

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
                    .stroke(softWhite.opacity(0.18), lineWidth: 1.5)
            )
            .shadow(color: primaryColor.opacity(0.30), radius: 28, x: 0, y: 14)
            .shadow(color: .black.opacity(0.50), radius: 18, x: 0, y: 10)
            .scaleEffect(artworkPulse ? 1.018 : 1.0)
            .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: artworkPulse)
            .onTapGesture { handleGrandmaTap() }

            if showHeartToast {
                Image(systemName: "heart.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(Color.themeRose)
                    .shadow(radius: 8)
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }

    private func titleRow(story: Story) -> some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 5) {
                Text(story.title)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(softWhite)
                    .lineLimit(2)
                Text(L10n.t(.narratedByGrandma))
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(creamMuted.opacity(0.80))
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
                    .foregroundStyle(liked ? Color.themeRose : creamMuted.opacity(0.72))
                    .scaleEffect(liked ? 1.12 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: liked)
            }
        }
    }

    private var seekBarSection: some View {
        VStack(spacing: 6) {
            if audioService.isPreparingAudio {
                HStack {
                    Text(L10n.t(.preparingStory))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white.opacity(0.50))
                    Spacer()
                    ProgressView().tint(.white.opacity(0.5)).scaleEffect(0.7)
                }
                .frame(height: 14)
            } else {
                GeometryReader { g in
                    let totalW = max(g.size.width, 1)
                    let filled = totalW * CGFloat(max(0, min(1, currentRatio)))
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(.white.opacity(0.22))
                            .frame(height: 4)
                        Capsule()
                            .fill(.white)
                            .frame(width: max(0, filled), height: 4)
                        Circle()
                            .fill(.white)
                            .frame(width: 16, height: 16)
                            .shadow(color: .black.opacity(0.35), radius: 6)
                            .offset(x: (filled.isFinite && filled >= 8) ? filled - 8 : 0)
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
                .frame(height: 16)
            }

            HStack {
                Text(fmtTime(audioService.currentTime))
                Spacer()
                Text(fmtTime(audioService.duration))
            }
            .font(.system(size: 13, weight: .medium).monospacedDigit())
            .foregroundStyle(creamMuted.opacity(0.78))
        }
    }

    private var controlsRow: some View {
        HStack(alignment: .center, spacing: 0) {

            Button {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                audioService.stopAudio(); animateAvatar = false
                story = StoryManager.shared.getRandomStory(for: mood)
            } label: {
                Image(systemName: "shuffle")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(creamMuted.opacity(0.78))
                    .frame(width: 44, height: 44)
            }
            .frame(maxWidth: .infinity)

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
                    .foregroundStyle(softWhite)
                    .frame(width: 44, height: 44)
            }
            .frame(maxWidth: .infinity)

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
                        .fill(softWhite)
                        .frame(width: 72, height: 72)
                        .shadow(color: Color(red:0.12,green:0.07,blue:0.03).opacity(0.38), radius: 14, y: 6)
                    if audioService.isPreparingAudio {
                        ProgressView()
                            .tint(Color(red: 0.25, green: 0.15, blue: 0.08))
                            .scaleEffect(1.0)
                    } else {
                        Image(systemName: audioService.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 30, weight: .black))
                            .foregroundStyle(Color(red: 0.20, green: 0.12, blue: 0.06))
                            .offset(x: audioService.isPlaying ? 0 : 3)
                    }
                }
            }
            .frame(maxWidth: .infinity)

            Button {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                audioService.scrub(to: min(audioService.duration, audioService.currentTime + 15))
            } label: {
                Image(systemName: "goforward.15")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(softWhite)
                    .frame(width: 44, height: 44)
            }
            .frame(maxWidth: .infinity)

            Button {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                showTimerSheet = true
            } label: {
                Image(systemName: "timer")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(creamMuted.opacity(0.72))
                    .frame(width: 44, height: 44)
            }
            .frame(maxWidth: .infinity)
            .confirmationDialog(L10n.t(.sleepTimer), isPresented: $showTimerSheet, titleVisibility: .visible) {
                Button(L10n.t(.timer5Min)) { audioService.startSleepTimer(minutes: 5) }
                Button(L10n.t(.timer15Min)) { audioService.startSleepTimer(minutes: 15) }
                Button(L10n.t(.timer30Min)) { audioService.startSleepTimer(minutes: 30) }
                Button(L10n.t(.turnOffTimer), role: .destructive) { audioService.cancelSleepTimer() }
                Button(L10n.t(.cancel), role: .cancel) {}
            } message: {
                Text(L10n.t(.stopPlaybackAfter))
            }
        }
    }

    private var utilityBar: some View {
        HStack(alignment: .center, spacing: 0) {

            Button {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                audioService.toggleMute()
            } label: {
                Image(systemName: audioService.isMuted ? "speaker.slash.fill" : "hifispeaker.2")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(creamMuted.opacity(0.68))
                    .frame(maxWidth: .infinity)
            }

            if let s = story {
                ShareLink(item: "\(s.title)\n\n\(s.content)\n\n— From Granly") {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(creamMuted.opacity(0.68))
                }
                .frame(maxWidth: .infinity)
            } else {
                Spacer().frame(maxWidth: .infinity)
            }

            Button { showFullLyrics = true } label: {
                Image(systemName: "list.bullet")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(creamMuted.opacity(0.68))
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func storyPreviewCard(story: Story) -> some View {
        VStack(alignment: .leading, spacing: 0) {

            HStack {
                Text(L10n.t(.storyPreview))
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(creamMuted.opacity(0.85))
                    .tracking(0.8)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 18)
            .padding(.bottom, 14)

            let previewLines = Array(syncEngine.lines.prefix(currentLineIdx + 5).suffix(5))
            VStack(alignment: .leading, spacing: 8) {
                ForEach(previewLines) { line in
                    let state = lineState(for: line.id)
                    Text(line.text)
                        .font(.system(size: 15, weight: state == .active ? .semibold : .regular))
                        .foregroundStyle(
                            state == .active ? AnyShapeStyle(softWhite) :
                            state == .passed ? AnyShapeStyle(creamMuted.opacity(0.40)) :
                                              AnyShapeStyle(creamMuted.opacity(0.68))
                        )
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .animation(.easeInOut(duration: 0.25), value: currentLineIdx)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)

            Button {
                showFullLyrics = true
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } label: {
                Text(L10n.t(.showFullStory))
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
                .shadow(color: Color(red:0.06,green:0.04,blue:0.02).opacity(0.55), radius: 18, x: 0, y: 8)
        )
    }

    private enum LineState { case passed, active, upcoming }
    private func lineState(for id: Int) -> LineState {
        if id < currentLineIdx  { return .passed }
        if id == currentLineIdx { return .active }
        return .upcoming
    }

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

                Color(red: 0.08, green: 0.05, blue: 0.03).ignoresSafeArea()

                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 28) {
                            ForEach(syncEngine.lines) { line in
                                let state = lineState(for: line.id)
                                Text(line.text)
                                    .font(.system(size: 28, weight: state == .active ? .heavy : .bold, design: .rounded))
                                    .foregroundStyle(
                                        state == .active
                                            ? Color(red:0.98,green:0.95,blue:0.90)
                                            : state == .passed
                                                ? Color(red:0.90,green:0.82,blue:0.70).opacity(0.38)
                                                : Color(red:0.94,green:0.88,blue:0.78).opacity(0.60)
                                    )
                                    .multilineTextAlignment(.leading)
                                    .animation(.easeInOut(duration: 0.25), value: currentLineIdx)
                                    .id(line.id)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 32)
                        .frame(maxWidth: .infinity, alignment: .leading)

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
            .toolbarBackground(Color(red: 0.08, green: 0.05, blue: 0.03), for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 8) {
                        if audioService.isPlaying {
                            Image(systemName: "waveform")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(accentColor)
                        }
                        Text(audioService.isPlaying ? L10n.t(.playing) : L10n.t(.paused))
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

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

