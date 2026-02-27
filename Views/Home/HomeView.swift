import SwiftUI

enum Tab {
    case stories
    case memories
    case activities
    case wisdom
    case profile
}

@MainActor
struct HomeView: View {
    @State private var selectedTab: Tab = .stories
    @State private var scrollOffset: CGFloat = 0
    @Namespace private var animation
    @EnvironmentObject var lang: LanguageManager
    
    // For Navigation
    @State private var showSurpriseStory = false
    @State private var surpriseStory: Story?
    
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
                    
                CozyActivitiesView()
                    .tag(Tab.activities)
                    .tabItem { Label(L10n.t(.cozyActivities), systemImage: "sun.max.fill") }
                
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
                    VStack(alignment: .trailing, spacing: 4) {
                        ProfileAvatarView(size: 52)
                            .shadow(color: .black.opacity(0.12), radius: 6)
                            .onTapGesture {
                                withAnimation {
                                    selectedTab = .profile
                                }
                            }
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
@MainActor
struct DailyQuoteCard: View {
    @EnvironmentObject var lang: LanguageManager
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(L10n.t(.dailyInspiration))
                    .font(.granlyCaption)
                    .foregroundStyle(.white.opacity(0.75))
                Text(L10n.t(.dailyQuoteText))
                    .font(.granlyHeadline)
                    .foregroundStyle(.white)
                    .lineSpacing(3)
            }
            Spacer()
            Image(systemName: "quote.opening")
                .font(.system(size: 24))
                .foregroundStyle(.white.opacity(0.18))
        }
        .padding(16)
        .background(
            LinearGradient(colors: [Color.themeRose, Color.themeWarm], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: Color.themeRose.opacity(0.30), radius: 6, x: 0, y: 3)
    }
}

@MainActor
struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    @EnvironmentObject var lang: LanguageManager
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Circle()
                    .fill(color.opacity(0.12))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(color)
                    )

                Text(title)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.themeText)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .glassCard(cornerRadius: 14)
        }
    }
}

@MainActor
struct MoodCard: View {
    let mood: Mood
    @EnvironmentObject var lang: LanguageManager
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: mood.icon)
                .font(.system(size: 36))
                .foregroundStyle(mood.baseColor)

            Text(mood.localizedName(for: lang.selectedLanguage))
                .font(.granlyBodyBold)
                .foregroundStyle(Color.themeText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .glassCard(cornerRadius: 16)
    }
}

@MainActor
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
                .frame(width: 150, height: 150)
                .offset(x: 90, y: -65)
            Circle()
                .fill(.white.opacity(0.05))
                .frame(width: 90, height: 90)
                .offset(x: 30, y: -95)
            
            // Content overlay
            VStack(alignment: .leading, spacing: 0) {
                // Top Row: icon + reading time badge
                HStack(alignment: .top) {
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.20))
                            .frame(width: 36, height: 36)
                        Image(systemName: mood.icon)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 10, weight: .semibold))
                        Text("3 " + L10n.t(.readMin))
                            .font(.system(size: 11, weight: .semibold, design: .rounded))
                    }
                    .foregroundStyle(.white.opacity(0.88))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.white.opacity(0.16))
                    .clipShape(Capsule())
                }

                Spacer()

                VStack(alignment: .leading, spacing: 6) {
                    Text(mood.localizedName(for: lang.selectedLanguage).uppercased())
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .tracking(1.4)
                        .foregroundStyle(.white.opacity(0.70))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.white.opacity(0.13))
                        .clipShape(Capsule())

                    Text(storyTitle)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 2)
                }
            }
            .padding(12)
        }
        .frame(width: 180, height: 210)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: cardGradient[1].opacity(0.35), radius: 12, x: 0, y: 8)
        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
        .scaleEffect(appear ? 1.0 : 0.94)
        .opacity(appear ? 1 : 0)
        .animation(.spring(response: 0.45, dampingFraction: 0.75).delay(Double(index) * 0.07), value: appear)
        .onAppear { appear = true }
    }
}
