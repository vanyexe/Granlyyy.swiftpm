import AVFoundation
import SwiftUI
import Combine

class AudioService: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    static let shared = AudioService()
    
    private let synthesizer = AVSpeechSynthesizer()
    
    @Published var isPlaying = false
    @Published var currentlyPlayingContent: String? = nil
    
    override init() {
        super.init()
        synthesizer.delegate = self
        setupAudioSession()
    }
    
    private func setupAudioSession() {
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
        let utterance = AVSpeechUtterance(string: text)
        
        // Try to find a warm, comforting English voice (e.g., Samantha or a UK voice for a "Grandma" feel)
        if let englishVoice = AVSpeechSynthesisVoice(language: "en-GB") ?? AVSpeechSynthesisVoice(language: "en-US") {
            utterance.voice = englishVoice
        }
        
        // Adjust these to sound softer and older
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.85 // Slightly slower
        utterance.pitchMultiplier = 0.9 // Slightly lower pitch
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
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isPlaying = false
            self.currentlyPlayingContent = nil
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isPlaying = false
            self.currentlyPlayingContent = nil
        }
    }
}
