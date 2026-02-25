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
    @EnvironmentObject var lang: LanguageManager
    
    // For Navigation
    @State private var showWisdomSheet = false
    @State private var showSurpriseStory = false
    @State private var surpriseStory: Story?
    @State private var showMemoriesSheet = false
    @State private var showAllStories = false
    
    let moods = Mood.allMoods
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                // Shared background applied to the Home Tab content
                homeContent
                    .tag(Tab.stories)
                    .tabItem { Label(L10n.t(.home), systemImage: "house.fill") }
                
                MemoryBoxView()
                    .tag(Tab.memories)
                    .tabItem { Label(L10n.t(.memories), systemImage: "heart.fill") }
                    
                RecipeListView()
                    .tag(Tab.recipes)
                    .tabItem { Label(L10n.t(.recipes), systemImage: "fork.knife") }
                
                DigitalGrandmaWisdomView()
                    .tag(Tab.wisdom)
                    .tabItem { Label(L10n.t(.wisdom), systemImage: "leaf.fill") }
                
                ProfileView()
                    .tag(Tab.profile)
                    .tabItem { Label(L10n.t(.profile), systemImage: "person.circle.fill") }
            }
            .id(lang.selectedLanguage.rawValue) // Force tab item label refresh on language change
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
                        Text(L10n.t(.myDear))
                            .font(.granlyTitle2)
                            .foregroundStyle(Color.themeText)
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.themeWarm.opacity(0.3))
                            .frame(width: 50, height: 50)
                        Text("👵🏻")
                            .font(.granlyTitle)
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
                            .onTapGesture { selectedTab = .wisdom }
                        
                        // Featured Stories — Premium Hero Cards
                        VStack(alignment: .leading, spacing: 14) {
                            // Section Header
                            HStack(alignment: .center, spacing: 8) {
                                // Decorative accent
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(
                                        LinearGradient(colors: [Color.themeRose, Color.themeGold],
                                                       startPoint: .top, endPoint: .bottom)
                                    )
                                    .frame(width: 4, height: 22)
                                
                                Text(L10n.t(.featuredForYou))
                                    .font(.granlyHeadline)
                                    .foregroundStyle(Color.themeText)
                                
                                Spacer()
                                
                                // "See All" pill — navigates to AllStoriesView
                                NavigationLink(destination: AllStoriesView()) {
                                    Text(L10n.t(.seeAll))
                                        .font(.system(size: 12, weight: .bold, design: .rounded))
                                        .foregroundStyle(Color.themeRose)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Color.themeRose.opacity(0.12))
                                        .clipShape(Capsule())
                                }
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 14) {
                                    ForEach(0..<4, id: \.self) { i in
                                        let mood = moods[i]
                                        let story = StoryManager.shared.getStory(for: mood)
                                        NavigationLink(destination: StoryView(mood: mood, storyToLoad: story)) {
                                            FeaturedStoryCard(mood: mood, storyTitle: story.title, index: i)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 6)
                            }
                        }
                        
                        // Quick Actions
                        HStack(spacing: 12) {
                            QuickActionButton(icon: "sparkles", title: L10n.t(.surpriseMe), color: .purple) {
                                if let randomMood = Mood.allMoods.randomElement() {
                                    surpriseStory = StoryManager.shared.getRandomStory(for: randomMood)
                                    showSurpriseStory = true
                                }
                            }
                            QuickActionButton(icon: "heart.fill", title: L10n.t(.favorites), color: .red) {
                                selectedTab = .memories
                            }
                            QuickActionButton(icon: "lightbulb.fill", title: L10n.t(.dailyWisdom), color: .yellow) {
                                selectedTab = .wisdom
                            }
                        }
                        .padding(.horizontal)
                        
                        // Mood Grid
                        VStack(alignment: .leading, spacing: 16) {
                            Text(L10n.t(.howAreYouFeeling))
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
        if hour < 12 { return L10n.t(.greetingMorning) }
        if hour < 18 { return L10n.t(.greetingAfternoon) }
        return L10n.t(.greetingEvening)
    }
}

// MARK: - Components
struct DailyQuoteCard: View {
    @EnvironmentObject var lang: LanguageManager
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(L10n.t(.dailyInspiration))
                    .font(.granlyCaption)
                    .foregroundStyle(.white.opacity(0.8))
                Text(L10n.t(.dailyQuoteText))
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
    @EnvironmentObject var lang: LanguageManager
    
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
    @EnvironmentObject var lang: LanguageManager
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: mood.icon)
                .font(.system(size: 28))
                .foregroundStyle(mood.baseColor)
            
            Text(mood.localizedName(for: lang.selectedLanguage))
                .font(.granlyBodyBold)
                .foregroundStyle(Color.themeText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .glassCard(cornerRadius: 16)
    }
}

struct FeaturedStoryCard: View {
    let mood: Mood
    let storyTitle: String
    let index: Int
    @EnvironmentObject var lang: LanguageManager
    
    // Each card gets a unique gradient personality
    private var cardGradient: [Color] {
        switch index % 4 {
        case 0: return [Color(red: 0.85, green: 0.35, blue: 0.45), Color(red: 0.55, green: 0.15, blue: 0.35)]
        case 1: return [Color(red: 0.30, green: 0.55, blue: 0.75), Color(red: 0.15, green: 0.25, blue: 0.55)]
        case 2: return [Color(red: 0.45, green: 0.70, blue: 0.45), Color(red: 0.20, green: 0.45, blue: 0.30)]
        default: return [Color(red: 0.70, green: 0.50, blue: 0.25), Color(red: 0.45, green: 0.25, blue: 0.10)]
        }
    }
    
    @State private var appear = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Rich gradient background
            LinearGradient(
                colors: cardGradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Decorative circle (top-right corner accent)
            Circle()
                .fill(.white.opacity(0.08))
                .frame(width: 120, height: 120)
                .offset(x: 70, y: -55)
            Circle()
                .fill(.white.opacity(0.05))
                .frame(width: 70, height: 70)
                .offset(x: 20, y: -85)
            
            // Content overlay
            VStack(alignment: .leading, spacing: 0) {
                // Top Row: icon + reading time badge
                HStack(alignment: .top) {
                    // Mood icon in frosted bubble
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.22))
                            .frame(width: 36, height: 36)
                        Image(systemName: mood.icon)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    // Reading time pill
                    HStack(spacing: 3) {
                        Image(systemName: "clock")
                            .font(.system(size: 9, weight: .bold))
                        Text("3 " + L10n.t(.readMin))
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                    }
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.white.opacity(0.18))
                    .clipShape(Capsule())
                }
                
                Spacer()
                
                // Bottom: mood tag + title
                VStack(alignment: .leading, spacing: 5) {
                    // Mood label — distinct capsule tag
                    Text(mood.localizedName(for: lang.selectedLanguage).uppercased())
                        .font(.system(size: 9, weight: .black, design: .rounded))
                        .tracking(1.5)
                        .foregroundStyle(.white.opacity(0.75))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(.white.opacity(0.15))
                        .clipShape(Capsule())
                    
                    // Story title
                    Text(storyTitle)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                }
            }
            .padding(14)
        }
        .frame(width: 170, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        // Rich layered shadow for depth
        .shadow(color: cardGradient[1].opacity(0.45), radius: 14, x: 0, y: 8)
        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
        // Subtle scale on appear
        .scaleEffect(appear ? 1.0 : 0.92)
        .opacity(appear ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.7).delay(Double(index) * 0.08), value: appear)
        .onAppear { appear = true }
    }
}
