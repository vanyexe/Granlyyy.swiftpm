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
        
        // Specifically find a sweet, comforting English female voice
        let voices = AVSpeechSynthesisVoice.speechVoices()
        let preferredNames = ["Samantha", "Karen", "Moira", "Tessa", "Martha"] // Known good female voices
        
        var selectedVoice: AVSpeechSynthesisVoice?
        
        // 1. Try to find a preferred English female voice
        for name in preferredNames {
            if let voice = voices.first(where: { $0.name == name && $0.language.starts(with: "en") }) {
                selectedVoice = voice
                break
            }
        }
        
        // 2. Fallback to any English female voice
        if selectedVoice == nil {
            selectedVoice = voices.first(where: { $0.language.starts(with: "en") && $0.gender == .female })
        }
        
        // 3. Last fallback
        if selectedVoice == nil {
            selectedVoice = AVSpeechSynthesisVoice(language: "en-US")
        }
        
        utterance.voice = selectedVoice
        
        // Make her sound sweeter, gentler, and authentically older
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.82 // Slightly slower, unhurried pace
        utterance.pitchMultiplier = 1.15 // Higher pitch for a sweeter, softer tone
        utterance.volume = 1.0
        
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
