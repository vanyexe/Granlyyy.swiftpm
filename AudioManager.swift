import Foundation
import AVFoundation

@MainActor
class AudioManager: ObservableObject {
    static let shared = AudioManager()
    
    @Published var isPlaying = false
    @Published var currentTrack: String?
    
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func play(fileName: String) {
        // Stop current playback if any
        audioPlayer?.stop()
        
        // Try to find the audio file in the bundle
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("⚠️ Audio file '\(fileName).mp3' not found in bundle. Please add audio files to your project.")
            // Still update state to show UI feedback
            currentTrack = fileName
            isPlaying = true
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            currentTrack = fileName
            isPlaying = true
            print("✅ Playing: \(fileName)")
        } catch {
            print("Failed to play audio: \(error)")
        }
    }
    
    func pause() {
        audioPlayer?.pause()
        isPlaying = false
    }
    
    func resume() {
        audioPlayer?.play()
        isPlaying = true
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
        currentTrack = nil
    }
    
    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            resume()
        }
    }
}
