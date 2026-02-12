import SwiftUI
import Foundation

struct MusicView: View {
    @StateObject private var audioManager = AudioManager.shared
    
    let tracks = [
        MusicTrack(title: "Calm Forest", artist: "Nature Sounds", duration: "3:45", fileName: "calm_forest"),
        MusicTrack(title: "Ocean Breeze", artist: "Sleep Well", duration: "4:20", fileName: "ocean_breeze"),
        MusicTrack(title: "Piano Dreams", artist: "Classical Vibes", duration: "2:55", fileName: "piano_dreams"),
        MusicTrack(title: "Rainy Day", artist: "Cozy Corners", duration: "5:10", fileName: "rainy_day"),
        MusicTrack(title: "Soft Lo-Fi", artist: "Chill Beats", duration: "3:30", fileName: "soft_lofi")
    ]
    
    @State private var selectedTrack: MusicTrack?
    
    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Relaxing Sounds")
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundStyle(Color.themeText)
                    Text("Soothe your mind for better stories")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                // Track List
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(tracks) { track in
                            MusicTrackCard(
                                track: track,
                                isSelected: audioManager.currentTrack == track.fileName,
                                isPlaying: audioManager.isPlaying && audioManager.currentTrack == track.fileName
                            )
                            .onTapGesture {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    if audioManager.currentTrack == track.fileName {
                                        audioManager.togglePlayPause()
                                    } else {
                                        selectedTrack = track
                                        audioManager.play(fileName: track.fileName)
                                    }
                                }
                            }
                        }
                    }
                    .padding(24)
                    .padding(.bottom, 120) // Space for mini player and bottom bar
                }
            }
            
            // Now Playing Floating Bar (Mini Player)
            if let track = selectedTrack, audioManager.currentTrack == track.fileName {
                VStack {
                    Spacer()
                    
                    HStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.themeAccent.opacity(0.15))
                                .frame(width: 48, height: 48)
                            
                            Image(systemName: "music.quarternote.3")
                                .font(.title3)
                                .foregroundStyle(Color.themeAccent)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(track.title)
                                .font(.headline)
                                .foregroundStyle(Color.themeText)
                            Text(track.artist)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Button(action: { audioManager.togglePlayPause() }) {
                                Image(systemName: audioManager.isPlaying ? "pause.fill" : "play.fill")
                                    .font(.title3)
                                    .foregroundStyle(Color.themeText)
                                    .frame(width: 44, height: 44)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 10)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 100) // Above tab bar
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

struct MusicTrack: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let artist: String
    let duration: String
    let fileName: String
}

struct MusicTrackCard: View {
    let track: MusicTrack
    let isSelected: Bool
    let isPlaying: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Album Art Placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.themeAccent : Color.secondary.opacity(0.1))
                    .frame(width: 56, height: 56)
                
                if isSelected && isPlaying {
                    HStack(spacing: 2) {
                        ForEach(0..<3) { i in
                            WaveformBar(isSelected: isSelected)
                                .animation(.easeInOut(duration: 0.5).repeatForever().delay(Double(i) * 0.1), value: isPlaying)
                        }
                    }
                } else {
                    Image(systemName: isSelected ? "pause.fill" : "play.fill")
                        .foregroundStyle(isSelected ? .white : Color.themeAccent)
                        .font(.title3.bold())
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(track.title)
                    .font(.headline)
                    .foregroundStyle(isSelected ? Color.themeAccent : Color.themeText)
                Text(track.artist)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(track.duration)
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
                .padding(.trailing, 4)
        }
        .padding(12)
        .background(isSelected ? Color.themeAccent.opacity(0.05) : Color.clear)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.themeAccent.opacity(0.3) : .white.opacity(0.4), lineWidth: 1)
        )
        .scaleEffect(isSelected ? 1.02 : 1.0)
    }
}

struct WaveformBar: View {
    let isSelected: Bool
    @State private var height: CGFloat = 10
    
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(isSelected ? .white : Color.themeAccent)
            .frame(width: 4, height: height)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                    height = CGFloat.random(in: 15...25)
                }
            }
    }
}

