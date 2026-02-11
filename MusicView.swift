import SwiftUI

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
            Color.themeBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Relaxing Sounds")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.themeText)
                        Text("Soothe your mind")
                            .font(.subheadline)
                            .foregroundStyle(Color.themeText.opacity(0.7))
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Track List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(tracks) { track in
                            MusicTrackCard(
                                track: track,
                                isSelected: audioManager.currentTrack == track.fileName,
                                isPlaying: audioManager.isPlaying && audioManager.currentTrack == track.fileName
                            )
                            .onTapGesture {
                                if audioManager.currentTrack == track.fileName {
                                    audioManager.togglePlayPause()
                                } else {
                                    selectedTrack = track
                                    audioManager.play(fileName: track.fileName)
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 80) // Space for bottom bar
                }
            }
            
            // Now Playing Floating Bar (Mini Player)
            if let track = selectedTrack, audioManager.currentTrack == track.fileName {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "music.note.list")
                            .frame(width: 40, height: 40)
                            .background(Color.themeAccent.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .foregroundStyle(Color.themeAccent)
                        
                        VStack(alignment: .leading) {
                            Text(track.title)
                                .font(.headline)
                                .foregroundStyle(Color.themeText)
                            Text(track.artist)
                                .font(.caption)
                                .foregroundStyle(Color.themeText.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        Button(action: { 
                            audioManager.togglePlayPause()
                        }) {
                            Image(systemName: audioManager.isPlaying ? "pause.fill" : "play.fill")
                                .font(.title2)
                                .foregroundStyle(Color.themeAccent)
                        }
                    }
                    .padding()
                    .background(Color.themeBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding(.horizontal)
                    .padding(.bottom, 90) // Above tab bar
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(), value: selectedTrack)
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
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(isSelected ? Color.themeAccent : Color.gray.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: isSelected && isPlaying ? "waveform" : "play.fill")
                    .foregroundStyle(isSelected ? Color.white : Color.themeAccent)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(track.title)
                    .font(.headline)
                    .foregroundStyle(Color.themeText)
                Text(track.artist)
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            
            Text(track.duration)
                .font(.caption)
                .foregroundStyle(Color.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.themeAccent : Color.clear, lineWidth: 2)
        )
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}
