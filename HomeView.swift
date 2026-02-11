import SwiftUI


enum Tab {
    case stories
    case music
}

struct HomeView: View {
    @State private var selectedTab: Tab = .stories
    @Namespace private var animation // For potential advanced animations
    
    let moods = Mood.allMoods
    @State private var selectedMood: Mood?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBackground.ignoresSafeArea()
                
                // Main Content Switching
                VStack(spacing: 0) {
                    if selectedTab == .stories {
                        StoriesView(moods: moods)
                            .transition(.opacity) // Simple fade
                    } else {
                        MusicView()
                            .transition(.opacity)
                    }
                }
                
                // Bottom Tab Bar
                VStack {
                    Spacer()
                    CustomBottomTabBar(selectedTab: $selectedTab)
                }
            }
            .navigationDestination(for: Mood.self) { mood in
                StoryView(mood: mood)
            }
        }
    }
}

struct StoriesView: View {
    let moods: [Mood]
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                VStack(alignment: .leading) {
                    Text("Good Morning,")
                        .font(.subheadline)
                        .foregroundStyle(Color.themeText.opacity(0.7))
                    Text("My Dear")
                        .font(.custom("Baskerville-Bold", size: 34))
                        .foregroundStyle(Color.themeText)
                }
                Spacer()
                
                // Saved Memories Button
                NavigationLink(destination: MemoriesView()) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.themeAccent)
                        .padding(10)
                        .background(Circle().fill(Color.themeAccent.opacity(0.1)))
                }
                .padding(.trailing, 8)
                
                // New Unified Profile Button
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.crop.circle") // Placeholder until we use the selected avatar
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .foregroundStyle(Color.themeAccent)
                        .padding(4)
                        .background(Circle().fill(Color.themeAccent.opacity(0.1)))
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            // Question
            Text("How are you feeling today?")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(Color.themeText)
                .padding(.top, 20)
            
            // Mood Grid
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 20)], spacing: 20) {
                    ForEach(moods) { mood in
                        NavigationLink(value: mood) {
                            MoodCard(mood: mood)
                        }
                    }
                }
                .padding()
                .padding(.bottom, 80) // Space for bottom bar
            }
        }
    }
}

struct CustomBottomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            TabBarButton(image: "book.fill", text: "Stories", isSelected: selectedTab == .stories) {
                withAnimation { selectedTab = .stories }
            }
            
            Spacer()
            
            TabBarButton(image: "music.note", text: "Music", isSelected: selectedTab == .music) {
                withAnimation { selectedTab = .music }
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 16)
        .background(
            Capsule()
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 60)
        .padding(.bottom, 20)
    }
}

struct TabBarButton: View {
    let image: String
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: image)
                    .font(.system(size: 24))
                    .foregroundStyle(isSelected ? Color.themeAccent : Color.gray)
                
//                Text(text)
//                    .font(.caption2)
//                    .foregroundStyle(isSelected ? Color.themeAccent : Color.gray)
            }
            .scaleEffect(isSelected ? 1.2 : 1.0)
            .animation(.spring(), value: isSelected)
        }
    }
}

struct MoodCard: View {
    let mood: Mood
    
    var body: some View {
        VStack {
            Image(systemName: mood.icon)
                .font(.system(size: 40))
                .foregroundStyle(mood.baseColor)
                .padding(.bottom, 8)
            
            Text(mood.name)
                .font(.headline)
                .foregroundStyle(Color.themeText)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(Color.themeBackground)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.themeAccent.opacity(0.2), lineWidth: 1)
        )
    }
}






