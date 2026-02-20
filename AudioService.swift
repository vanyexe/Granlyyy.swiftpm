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
    
    override init() {
        super.init()
    }
    
    private func setupAudioSessionIfNeeded() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func readText(_ text: String) {
        if isPlaying {
            stopAudio()
            // If clicking play on new text while old is playing, start the new one
            if currentlyPlayingContent != text {
                startReading(text)
            }
        } else {
            startReading(text)
        }
    }
    
    private func startReading(_ text: String) {
        setupAudioSessionIfNeeded()
        
        let utterance = AVSpeechUtterance(string: text)
        
        // Specifically find the most realistic, sweet English female voice
        let voices = AVSpeechSynthesisVoice.speechVoices()
        var selectedVoice: AVSpeechSynthesisVoice?
        
        // 1. Try to find a "Premium" or "Enhanced" quality female voice
        if #available(iOS 16.0, *) {
            // First, try for the highest possible realism (Premium)
            selectedVoice = voices.first(where: {
                $0.language.starts(with: "en") &&
                $0.gender == .female &&
                $0.quality == .premium
            })
            
            // If no premium, try enhanced
            if selectedVoice == nil {
                selectedVoice = voices.first(where: {
                    $0.language.starts(with: "en") &&
                    $0.gender == .female &&
                    $0.quality == .enhanced
                })
            }
        }
        
        // 2. Try known good female names if high-quality ones aren't available
        let preferredNames = ["Zoe", "Samantha", "Karen", "Moira", "Tessa", "Martha"]
        if selectedVoice == nil {
            for name in preferredNames {
                if let voice = voices.first(where: { $0.name == name && $0.language.starts(with: "en") }) {
                    selectedVoice = voice
                    break
                }
            }
        }
        
        // 3. Last fallback
        if selectedVoice == nil {
            selectedVoice = voices.first(where: { $0.language.starts(with: "en") && $0.gender == .female }) ?? AVSpeechSynthesisVoice(language: "en-US")
        }
        
        utterance.voice = selectedVoice
        
        // Make her sound sweeter, gentler, and authentically older with a real storytelling cadence
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.80 // Slightly slower, relaxing storytelling pace
        utterance.pitchMultiplier = 1.10 // Slightly higher pitch for sweetness without sounding unnatural
        utterance.volume = 1.0
        // Adding a slight pre-utterance delay makes it feel like she's taking a breath before speaking
        utterance.preUtteranceDelay = 0.5
        
        currentlyPlayingContent = text
        isPlaying = true
        synthesizer.speak(utterance)
    }
    
    func stopAudio() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        isPlaying = false
        currentlyPlayingContent = nil
    }
    
    // MARK: - AVSpeechSynthesizerDelegate
    
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        Task { @MainActor in
            self.isPlaying = false
            self.currentlyPlayingContent = nil
        }
    }
    
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in
            self.isPlaying = false
            self.currentlyPlayingContent = nil
        }
    }
}
