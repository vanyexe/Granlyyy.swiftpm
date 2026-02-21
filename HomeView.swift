import SwiftUI

enum Tab {
    case stories
    case memories
    case recipes
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
            TabView(selection: $selectedTab) {
                // Shared background applied to the Home Tab content
                homeContent
                    .tag(Tab.stories)
                    .tabItem { Label("Home", systemImage: "house.fill") }
                
                MemoryBoxView()
                    .tag(Tab.memories)
                    .tabItem { Label("Memories", systemImage: "heart.fill") }
                    
                RecipeListView()
                    .tag(Tab.recipes)
                    .tabItem { Label("Recipes", systemImage: "fork.knife") }
                
                DigitalGrandmaWisdomView()
                    .tag(Tab.wisdom)
                    .tabItem { Label("Wisdom", systemImage: "leaf.fill") }
                
                ProfileView()
                    .tag(Tab.profile)
                    .tabItem { Label("Profile", systemImage: "person.circle.fill") }
            }
            .tint(Color.themeRose)
            .navigationDestination(isPresented: $showSurpriseStory) {
                if let story = surpriseStory {
                    StoryView(mood: Mood.allMoods.randomElement()!, storyToLoad: story)
                }
            }
        }
    }
    
    private var homeContent: some View {
        ZStack {
            MeshGradientBackground(scrollOffset: scrollOffset)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header moved inside home tab
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(greeting)
                            .font(.granlySubheadline)
                            .foregroundStyle(.secondary)
                        Text("My Dear") // Ideally fetch from Profile
                            .font(.granlyTitle2)
                            .foregroundStyle(Color.themeText)
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.themeWarm.opacity(0.3))
                            .frame(width: 50, height: 50)
                        Image(systemName: "eyeglasses")
                            .font(.granlyTitle)
                            .foregroundStyle(Color.themeRose)
                    }
                    .shadow(radius: 4)
                    .onTapGesture { // Now taps navigate within the TabView or trigger a sheet
                        selectedTab = .profile
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .background(.ultraThinMaterial)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Daily Quote Card
                        DailyQuoteCard()
                            .padding(.horizontal)
                            .onTapGesture {
                                selectedTab = .wisdom
                            }
                        
                        // Featured Stories
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Featured for You")
                                .font(.granlyHeadline)
                                .foregroundStyle(Color.themeText)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(0..<4, id: \.self) { i in
                                        let mood = moods[i]
                                        let story = StoryManager.shared.getStory(for: mood)
                                        NavigationLink(destination: StoryView(mood: mood, storyToLoad: story)) {
                                            FeaturedStoryCard(mood: mood, storyTitle: story.title)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 4)
                            }
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
                                .font(.granlyHeadline)
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
                        .padding(.bottom, 40)
                    }
                    .padding(.top, 20)
                }
            }
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
                    .font(.granlyCaption)
                    .foregroundStyle(.white.opacity(0.8))
                Text("\"Keep your face always toward the sunshine and shadows will fall behind you.\"")
                    .font(.granlyHeadline)
                    .foregroundStyle(.white)
            }
            Spacer()
            Image(systemName: "quote.opening")
                .font(.system(size: 32)) // Reduced from 40
                .foregroundStyle(.white.opacity(0.2))
        }
        .padding(16) // Reduced from 20
        .background(
            LinearGradient(colors: [Color.themeRose, Color.themeWarm], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16)) // Tighter corners
        .shadow(color: Color.themeRose.opacity(0.4), radius: 8, x: 0, y: 4) // Smaller shadow
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) { // 8 -> 6
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 38, height: 38) // 44 -> 38
                    .overlay(
                        Image(systemName: icon)
                            .font(.granlySubheadline) // Headline -> Subheadline
                            .foregroundStyle(color)
                    )
                
                Text(title)
                    .font(.system(size: 11, weight: .bold, design: .rounded)) // Custom small crisp text
                    .foregroundStyle(Color.themeText)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10) // 12 -> 10
            .glassCard(cornerRadius: 14) // 16 -> 14
        }
    }
}

struct MoodCard: View {
    let mood: Mood
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: mood.icon)
                .font(.system(size: 28)) // 32 -> 28
                .foregroundStyle(mood.baseColor)
            
            Text(mood.name)
                .font(.granlyBodyBold) // Headline -> BodyBold
                .foregroundStyle(Color.themeText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20) // 24 -> 20
        .glassCard(cornerRadius: 16) // 20 -> 16
    }
}

struct FeaturedStoryCard: View {
    let mood: Mood
    let storyTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) { // Tighter spacing
            HStack {
                Image(systemName: mood.icon)
                    .font(.system(size: 14)) // Explicit small icon
                    .foregroundStyle(.white)
                    .padding(6) // 8 -> 6
                    .background(mood.baseColor.opacity(0.8))
                    .clipShape(Circle())
                Spacer()
                Text("3 min")
                    .font(.system(size: 10, weight: .bold, design: .rounded)) // Crisp tiny rounded
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
            }
            
            Spacer()
            
            Text(storyTitle)
                .font(.granlyBodyBold) // Headline -> BodyBold
                .foregroundStyle(Color.themeText)
                .lineLimit(2)
            
            Text(mood.name.uppercased())
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .tracking(1) // Premium letter spacing
                .foregroundStyle(mood.baseColor)
        }
        .padding(14) // 16 -> 14
        .frame(width: 140, height: 160) // 160x180 -> 140x160 (more compact horizontal scroll)
        .glassCard(cornerRadius: 16) // 20 -> 16
    }
}
