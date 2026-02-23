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
    @Published var currentlyPlayingContent: String? = nil

    override init() { super.init() }

    private func setupAudioSessionIfNeeded() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AudioService: Failed to set up audio session: \(error)")
        }
    }

    func readText(_ text: String, languageOverride: AppLanguage? = nil) {
        let language = languageOverride ?? {
            let code = UserDefaults.standard.string(forKey: "selectedLanguage") ?? AppLanguage.english.rawValue
            return AppLanguage(rawValue: code) ?? .english
        }()
        if isPlaying {
            stopAudio()
            if currentlyPlayingContent != text {
                startReading(text, language: language)
            }
        } else {
            startReading(text, language: language)
        }
    }

    private func startReading(_ text: String, language: AppLanguage) {
        setupAudioSessionIfNeeded()

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = bestGrandmaVoice(for: language)

        // ── Warm Grandmother Voice Parameters ──────────────────────────
        // Slightly slower pace = cozy storytelling cadence
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.78
        // Softly higher pitch = warmth without sounding robotic
        utterance.pitchMultiplier = 1.08
        // Full warm volume
        utterance.volume = 0.95
        // Breath pause before speaking — makes it feel human
        utterance.preUtteranceDelay = 0.55
        // Short natural pause at end
        utterance.postUtteranceDelay = 0.2

        currentlyPlayingContent = text
        isPlaying = true
        synthesizer.speak(utterance)
    }

    // MARK: - Voice Selection (per language)

    private func bestGrandmaVoice(for language: AppLanguage) -> AVSpeechSynthesisVoice? {
        let allVoices = AVSpeechSynthesisVoice.speechVoices()
        let bcp47 = language.bcp47
        let langPrefix = String(bcp47.prefix(2)) // "hi", "en", "es", etc.

        // Priority 1: Premium female voice in the target language
        if #available(iOS 16.0, *) {
            if let v = allVoices.first(where: {
                $0.language.starts(with: langPrefix) && $0.gender == .female && $0.quality == .premium
            }) { return v }

            // Priority 2: Enhanced female voice
            if let v = allVoices.first(where: {
                $0.language.starts(with: langPrefix) && $0.gender == .female && $0.quality == .enhanced
            }) { return v }
        }

        // Priority 3: Any female voice in the language
        if let v = allVoices.first(where: {
            $0.language.starts(with: langPrefix) && $0.gender == .female
        }) { return v }

        // Priority 4: English premium female fallback names (if no localized voice available)
        if langPrefix != "en" {
            let preferredNames = ["Zoe", "Samantha", "Karen", "Moira", "Tessa", "Martha"]
            for name in preferredNames {
                if let v = allVoices.first(where: { $0.name == name && $0.language.starts(with: "en") }) {
                    return v
                }
            }
        }

        // Priority 5: Native language default voice
        if let v = AVSpeechSynthesisVoice(language: bcp47) { return v }

        // Final fallback
        return AVSpeechSynthesisVoice(language: "en-US")
    }

    func stopAudio() {
        if synthesizer.isSpeaking { synthesizer.stopSpeaking(at: .immediate) }
        isPlaying = false
        currentlyPlayingContent = nil
    }

    // MARK: - AVSpeechSynthesizerDelegate
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        Task { @MainActor in self.isPlaying = false; self.currentlyPlayingContent = nil }
    }
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in self.isPlaying = false; self.currentlyPlayingContent = nil }
    }
}
