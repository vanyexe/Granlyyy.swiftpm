import SwiftUI

struct ProfileView: View {
    @StateObject private var languageManager = LanguageManager()
    @AppStorage("grandmaName") private var grandmaName = "Granly"
    @AppStorage("userName") private var userName = "My Dear"
    
    // Mock avatars for now
    let avatars = ["sweet_grandma_avatar", "cool_grandma_avatar", "wise_grandma_avatar"]
    @State private var selectedAvatar = "sweet_grandma_avatar"
    
    var body: some View {
        Form {
            // User Profile Section
            Section {
                HStack {
                    Image("user_profile_image") // Placeholder
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.themeAccent, lineWidth: 2))
                    
                    VStack(alignment: .leading) {
                        Text(userName)
                            .font(.headline)
                        Text("Edit Profile")
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                }
                .padding(.vertical, 8)
                
                TextField("Your Name", text: $userName)
                
                NavigationLink(destination: MemoriesView()) {
                    Label("Saved Memories", systemImage: "heart.text.square")
                        .foregroundStyle(Color.themeAccent)
                }
            } header: {
                Text("You")
            }
            
            // Grandma Settings
            Section {
                TextField("Grandma's Name", text: $grandmaName)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(avatars, id: \.self) { avatar in
                            VStack {
                                Image(avatar) // Using system images if assets missing for now in preview? No, use asset names.
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(selectedAvatar == avatar ? Color.themeAccent : Color.clear, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        selectedAvatar = avatar
                                    }
                                
                                if selectedAvatar == avatar {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(Color.themeAccent)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            } header: {
                Text("Your Grandma")
            }
            
            // App Settings
            Section {
                Picker("Language", selection: $languageManager.selectedLanguageCode) {
                    ForEach(AppLanguage.allCases) { language in
                        Text(language.displayName).tag(language.rawValue)
                    }
                }
                .pickerStyle(.navigationLink)
            } header: {
                Text("Settings")
            }
            
            Section {
                Link("Privacy Policy", destination: URL(string: "https://www.example.com")!)
                Link("Terms of Service", destination: URL(string: "https://www.example.com")!)
                Text("Version 1.0.0")
                    .foregroundStyle(.secondary)
            } header: {
                Text("About")
            }
        }
        .navigationTitle("Profile & Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

