import AVFoundation
import SwiftUI
import Combine

@MainActor
final class AudioService: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    static let shared = AudioService()

    private lazy var synthesizer: AVSpeechSynthesizer = {
        let synth = AVSpeechSynthesizer()
        synth.delegate = self
        return synth
    }()

    @Published var isPlaying = false
    @Published var isPreparingAudio = false
    @Published var currentlyPlayingContent: String? = nil
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    @Published var speakingRange: NSRange? = nil

    private var totalCharCount: Int = 0
    private var progressTimer: Timer?
    @Published var isScrubbing = false
    private var wasPlayingBeforeScrub = false
    private var currentText: String = ""

    override init() {
        super.init()
        setupAudioSessionIfNeeded()
    }

    private func setupAudioSessionIfNeeded() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [.duckOthers, .allowBluetoothHFP])
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("AudioService: Failed to set up audio session: \(error)")
        }
    }

    func readText(_ text: String, languageOverride: AppLanguage? = nil) {
        let language = languageOverride ?? {
            let code = UserDefaults.standard.string(forKey: "selectedLanguage") ?? AppLanguage.english.rawValue
            return AppLanguage(rawValue: code) ?? .english
        }()
        
        if isPlaying && currentlyPlayingContent == text {
            pauseAudio()
        } else {
            startReading(text, language: language)
        }
    }

    func startReading(_ text: String, language: AppLanguage) {
        stopAudio()
        speakingRange = nil
        currentText = text
        totalCharCount = text.count
        
        // Accurate duration estimation: ~130 WPM, adjust words/char ratio based on language
        let wordsPerSec = (130.0 * 0.78) / 60.0
        let charsPerWord: Double
        switch language {
        case .hindi:
            charsPerWord = 3.0 // Hindi often has fewer characters per word
        default:
            // Since .chinese might not exist in the AppLanguage enum, 
            // if we need to support it later, its bcp47 code could be checked.
            if language.rawValue == "zh" || language.bcp47.starts(with: "zh") {
                charsPerWord = 1.0 // Chinese characters encode more meaning per character
            } else {
                charsPerWord = 5.0
            }
        }
        let charsPerSec = wordsPerSec * charsPerWord
        duration = TimeInterval(totalCharCount) / charsPerSec
        currentTime = 0
        currentlyPlayingContent = text

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = bestGrandmaVoice(for: language)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.78
        utterance.pitchMultiplier = 1.08
        utterance.volume = 0.95
        utterance.preUtteranceDelay = 0.1

        setupAudioSessionIfNeeded()
        synthesizer.speak(utterance)
        isPlaying = true
        startProgressTimer()
    }

    func pauseAudio() {
        if synthesizer.isSpeaking {
            synthesizer.pauseSpeaking(at: .word)
            isPlaying = false
            stopProgressTimer()
        }
    }

    func resumeAudio() {
        if synthesizer.isPaused {
            setupAudioSessionIfNeeded()
            synthesizer.continueSpeaking()
            isPlaying = true
            startProgressTimer()
        }
    }

    func stopAudio() {
        synthesizer.stopSpeaking(at: .immediate)
        isPlaying = false
        isPreparingAudio = false
        currentlyPlayingContent = nil
        currentTime = 0
        duration = 0
        speakingRange = nil
        stopProgressTimer()
    }

    // MARK: - Scrubbing Logic

    func scrub(to time: TimeInterval) {
        guard duration > 0 else { return }
        let ratio = max(0, min(1, time / duration))
        currentTime = time
        
        let charOffset = Int(Double(totalCharCount) * ratio)
        guard charOffset < currentText.count else { return }
        
        let idx = currentText.index(currentText.startIndex, offsetBy: charOffset)
        let remaining = String(currentText[idx...])
        let wasPlaying = isPlaying
        
        synthesizer.stopSpeaking(at: .immediate)
        
        if wasPlaying {
            let utterance = AVSpeechUtterance(string: remaining)
            utterance.voice = bestGrandmaVoice(for: currentLanguage())
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.78
            utterance.pitchMultiplier = 1.08
            utterance.volume = 0.95
            synthesizer.speak(utterance)
        }
    }

    func scrubbingStarted() {
        isScrubbing = true
        wasPlayingBeforeScrub = isPlaying
        if isPlaying { pauseAudio() }
    }

    func scrubbingEnded() {
        isScrubbing = false
        if wasPlayingBeforeScrub { resumeAudio() }
    }

    private func currentLanguage() -> AppLanguage {
        let code = UserDefaults.standard.string(forKey: "selectedLanguage") ?? AppLanguage.english.rawValue
        return AppLanguage(rawValue: code) ?? .english
    }

    // MARK: - Voice Selection

    private func bestGrandmaVoice(for language: AppLanguage) -> AVSpeechSynthesisVoice? {
        let allVoices = AVSpeechSynthesisVoice.speechVoices()
        let bcp47 = language.bcp47
        let langPrefix = String(bcp47.prefix(2))

        if #available(iOS 16.0, *) {
            if let v = allVoices.first(where: { $0.language.starts(with: langPrefix) && $0.gender == .female && $0.quality == .premium }) { return v }
            if let v = allVoices.first(where: { $0.language.starts(with: langPrefix) && $0.gender == .female && $0.quality == .enhanced }) { return v }
        }

        return allVoices.first(where: { $0.language.starts(with: langPrefix) && $0.gender == .female })
            ?? allVoices.first(where: { $0.language.starts(with: langPrefix) })
            ?? AVSpeechSynthesisVoice(language: bcp47)
            ?? AVSpeechSynthesisVoice(language: "en-US")
    }

    // MARK: - Progress Tracking

    private func startProgressTimer() {
        stopProgressTimer()
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            Task { @MainActor in
                guard let self = self, self.isPlaying, !self.isScrubbing, self.duration > 0 else { return }
                let newTime = min(self.currentTime + 0.1, self.duration)
                if newTime > self.currentTime {
                    self.currentTime = newTime
                }
            }
        }
    }

    private func stopProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    }

    // MARK: - AVSpeechSynthesizerDelegate

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        Task { @MainActor in
            self.isPlaying = true
            self.isPreparingAudio = false
            self.startProgressTimer()
        }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        Task { @MainActor in
            guard !self.isScrubbing, self.totalCharCount > 0 else { return }
            // Sync currentTime with actual spoken range for better precision
            let ratio = Double(characterRange.location) / Double(self.totalCharCount)
            self.currentTime = self.duration * ratio
            self.speakingRange = characterRange
        }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        Task { @MainActor in
            self.isPlaying = false
            self.currentTime = self.duration
            self.speakingRange = nil
            self.stopProgressTimer()
        }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        Task { @MainActor in self.isPlaying = false }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        Task { @MainActor in
            self.isPlaying = true
            self.startProgressTimer()
        }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in
            self.isPlaying = false
            self.speakingRange = nil
            self.stopProgressTimer()
        }
    }
}
