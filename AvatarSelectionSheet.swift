import SwiftUI
import PhotosUI

@MainActor
struct AvatarSelectionSheet: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("profileAvatarType") private var avatarType = "default"
    @AppStorage("profileAvatarValue") private var avatarValue = ""
    @AppStorage("customProfileImageData") private var customImageData: Data = Data()
    
    @State private var selectedItem: PhotosPickerItem?
    
    let symbols = [
        "heart.fill", "star.fill", "moon.stars.fill", "leaf.fill", 
        "book.fill", "cup.and.saucer.fill", "pawprint.fill", "music.note"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                MeshGradientBackground()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // ── Current Avatar Preview ───────────────────────────
                        VStack(spacing: 12) {
                            Text("Current Preview")
                                .font(.granlyCaption)
                                .foregroundStyle(.secondary)
                            
                            ProfileAvatarView(size: 100)
                                .shadow(radius: 10)
                        }
                        .padding(.top, 20)
                        
                        // ── Selection Options ───────────────────────────────
                        VStack(spacing: 20) {
                            
                            // 1. Gallery Picker
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                galleryPickerLabel
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task { @MainActor in
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        // Resize if possible or just store
                                        customImageData = data
                                        avatarType = "gallery"
                                        dismiss()
                                    }
                                }
                            }
                            
                            // 2. Themed Symbols
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Themed Icons")
                                    .font(.granlyCaption)
                                    .foregroundStyle(.secondary)
                                    .padding(.leading, 10)
                                
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 15) {
                                    ForEach(symbols, id: \.self) { symbol in
                                        Button(action: {
                                            avatarType = "symbol"
                                            avatarValue = symbol
                                            dismiss()
                                        }) {
                                            symbolButton(symbol)
                                        }
                                    }
                                }
                                .padding()
                                .glassCard(cornerRadius: 16)
                            }
                            
                            // 3. Reset to Default
                            Button(action: {
                                avatarType = "default"
                                dismiss()
                            }) {
                                Text("Reset to Default Grandma")
                                    .font(.granlyBodyBold)
                                    .foregroundStyle(.secondary)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Change Profile Picture")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(Color.themeRose)
                }
            }
        }
    }
    
    // ── Helper View Builders for Isolation ──────────────────────────────────
    
    @ViewBuilder
    private var galleryPickerLabel: some View {
        HStack {
            Image(systemName: "photo.on.rectangle")
                .foregroundStyle(.blue)
            Text("Choose from Gallery")
                .font(.granlyBodyBold)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .glassCard(cornerRadius: 16)
    }
    
    @ViewBuilder
    private func symbolButton(_ symbol: String) -> some View {
        ZStack {
            Circle()
                .fill(avatarValue == symbol && avatarType == "symbol" ? Color.themeRose : Color.themeRose.opacity(0.1))
                .frame(width: 50, height: 50)
            
            Image(systemName: symbol)
                .font(.title3)
                .foregroundStyle(avatarValue == symbol && avatarType == "symbol" ? .white : Color.themeRose)
        }
    }
}

/// Helper View to display the correct avatar based on settings
@MainActor
struct ProfileAvatarView: View {
    let size: CGFloat
    @AppStorage("profileAvatarType") private var avatarType = "default"
    @AppStorage("profileAvatarValue") private var avatarValue = ""
    @AppStorage("customProfileImageData") private var customImageData: Data = Data()
    
    var body: some View {
        Group {
            if avatarType == "gallery", let uiImage = UIImage(data: customImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if avatarType == "symbol" {
                ZStack {
                    Circle()
                        .fill(Color.themeRose.opacity(0.15))
                    Image(systemName: avatarValue)
                        .font(.system(size: size * 0.4))
                        .foregroundStyle(Color.themeRose)
                }
            } else {
                Image("grandma_avatar_circle")
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(Circle().stroke(.white, lineWidth: 3))
    }
}
