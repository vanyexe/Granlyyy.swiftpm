import SwiftUI

enum Tab {
    case stories
    case memories
    case wisdom
    case profile
}

struct HomeView: View {
    @State private var selectedTab: Tab = .stories
    @State private var scrollOffset: CGFloat = 0
    @Namespace private var animation
    
    // For Navigation
    @State private var showWisdomSheet = false
    @State private var showSurpriseStory = false
    @State private var surpriseStory: Story?
    @State private var showMemoriesSheet = false
    
    let moods = Mood.allMoods
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                MeshGradientBackground(scrollOffset: scrollOffset)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(greeting)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("My Dear") // Ideally fetch from Profile
                                .font(.custom("Baskerville-Bold", size: 28))
                                .foregroundStyle(Color.themeText)
                        }
                        Spacer()
                        Text("👵")
                            .font(.system(size: 50))
                            .shadow(radius: 4)
                            .onTapGesture {
                                selectedTab = .profile
                            }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .background(.ultraThinMaterial)
                    
                    // Main Content
                    TabView(selection: $selectedTab) {
                        homeContent
                            .tag(Tab.stories)
                            .tabItem { Label("Home", systemImage: "house.fill") }
                        
                        MemoriesView()
                            .tag(Tab.memories)
                            .tabItem { Label("Memories", systemImage: "heart.fill") }
                        
                        DailyWisdomView()
                            .tag(Tab.wisdom)
                            .tabItem { Label("Wisdom", systemImage: "leaf.fill") }
                        
                        ProfileView()
                            .tag(Tab.profile)
                            .tabItem { Label("Profile", systemImage: "person.circle.fill") }
                    }
                    .tint(Color.themeRose)
                }
            }
            .navigationDestination(isPresented: $showSurpriseStory) {
                if let story = surpriseStory {
                    StoryView(mood: Mood.allMoods.randomElement()!, storyToLoad: story)
                }
            }
        }
    }
    
    private var homeContent: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Daily Quote Card
                DailyQuoteCard()
                    .padding(.horizontal)
                    .onTapGesture {
                        selectedTab = .wisdom
                    }
                
                // Quick Actions
                HStack(spacing: 12) {
                    QuickActionButton(icon: "sparkles", title: "Surprise Me", color: .purple) {
                        // Pick random story from random mood
                        if let randomMood = Mood.allMoods.randomElement() {
                            surpriseStory = StoryManager.shared.getRandomStory(for: randomMood)
                            showSurpriseStory = true
                        }
                    }
                    QuickActionButton(icon: "heart.fill", title: "Favorites", color: .red) {
                        selectedTab = .memories
                    }
                    QuickActionButton(icon: "lightbulb.fill", title: "Daily Wisdom", color: .yellow) {
                        selectedTab = .wisdom
                    }
                }
                .padding(.horizontal)
                
                // Mood Grid
                VStack(alignment: .leading, spacing: 16) {
                    Text("How are you feeling?")
                        .font(.title3.bold())
                        .foregroundStyle(Color.themeText)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(moods) { mood in
                            NavigationLink(destination: StoryListView(mood: mood)) {
                                MoodCard(mood: mood)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Featured Stories
                VStack(alignment: .leading, spacing: 16) {
                    Text("Featured for You")
                        .font(.title3.bold())
                        .foregroundStyle(Color.themeText)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(0..<3) { i in
                                let mood = moods[i]
                                let story = StoryManager.shared.getStory(for: mood)
                                NavigationLink(destination: StoryView(mood: mood, storyToLoad: story)) {
                                    FeaturedStoryCard(mood: mood, storyTitle: story.title)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 40)
            }
            .padding(.top, 20)
        }
    }
    
    // Time-aware greeting
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "Good Morning," }
        if hour < 18 { return "Good Afternoon," }
        return "Good Evening,"
    }
}

// MARK: - Components
struct DailyQuoteCard: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Daily Inspiration")
                    .font(.caption.bold())
                    .foregroundStyle(.white.opacity(0.8))
                Text("\"Keep your face always toward the sunshine and shadows will fall behind you.\"")
                    .font(.system(size: 18, weight: .semibold, design: .serif))
                    .foregroundStyle(.white)
            }
            Spacer()
            Image(systemName: "quote.opening")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.2))
        }
        .padding(20)
        .background(
            LinearGradient(colors: [Color.themeRose, Color.themeWarm], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.themeRose.opacity(0.4), radius: 10, x: 0, y: 5)
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: icon)
                            .font(.headline)
                            .foregroundStyle(color)
                    )
                
                Text(title)
                    .font(.caption.bold())
                    .foregroundStyle(Color.themeText)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .glassCard(cornerRadius: 16)
        }
    }
}

struct MoodCard: View {
    let mood: Mood
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: mood.icon)
                .font(.system(size: 32))
                .foregroundStyle(mood.baseColor)
            
            Text(mood.name)
                .font(.headline)
                .foregroundStyle(Color.themeText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .glassCard(cornerRadius: 20)
    }
}

struct FeaturedStoryCard: View {
    let mood: Mood
    let storyTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: mood.icon)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(mood.baseColor.opacity(0.8))
                    .clipShape(Circle())
                Spacer()
                Text("3 min")
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
            }
            
            Spacer()
            
            Text(storyTitle)
                .font(.headline)
                .foregroundStyle(Color.themeText)
                .lineLimit(2)
            
            Text(mood.name)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(width: 160, height: 180)
        .glassCard(cornerRadius: 20)
    }
}
