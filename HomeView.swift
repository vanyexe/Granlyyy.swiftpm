import SwiftUI

enum Tab {
    case stories
    case music
}

struct HomeView: View {
    @State private var selectedTab: Tab = .stories
    @State private var scrollOffset: CGFloat = 0
    @Namespace private var animation
    
    let moods = Mood.allMoods
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background: Premium Mesh Gradient with Parallax
                MeshGradientBackground(scrollOffset: scrollOffset)
                    .ignoresSafeArea()
                
                // Content
                VStack(spacing: 0) {
                    if selectedTab == .stories {
                        StoriesView(moods: moods, scrollOffset: $scrollOffset)
                            .transition(.asymmetric(insertion: .move(edge: .leading).combined(with: .opacity), removal: .move(edge: .trailing).combined(with: .opacity)))
                    } else {
                        MusicView()
                            .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .move(edge: .leading).combined(with: .opacity)))
                    }
                }
                
                // Glassmorphic Custom Bottom Tab Bar
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
    @Binding var scrollOffset: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            // Interactive Parallax Header
            HeaderView(scrollOffset: scrollOffset)
                .zIndex(10)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    // Track scroll offset for background/header effects
                    GeometryReader { geometry in
                        Color.clear.preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .global).minY)
                    }
                    .frame(height: 0)
                    
                    // Horizontal Featured Carousel
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Featured Stories")
                            .font(.title3.bold())
                            .foregroundStyle(Color.themeText)
                            .padding(.horizontal, 24)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(moods.prefix(3)) { featuredMood in
                                    if #available(iOS 17.0, *) {
                                        NavigationLink(value: featuredMood) {
                                            FeaturedStoryCard()
                                                .frame(width: 320)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .scrollTransition { content, phase in
                                            content
                                                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                                                .opacity(phase.isIdentity ? 1 : 0.7)
                                                .rotationEffect(.degrees(phase.isIdentity ? 0 : 2))
                                        }
                                    } else {
                                        NavigationLink(value: featuredMood) {
                                            FeaturedStoryCard()
                                                .frame(width: 320)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                    
                    // Mood Carousel with Scroll Animations
                    VStack(alignment: .leading, spacing: 20) {
                        Text("How are you feeling today?")
                            .font(.title2.bold())
                            .foregroundStyle(Color.themeText)
                            .padding(.horizontal, 24)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(moods) { mood in
                                    if #available(iOS 17.0, *) {
                                        NavigationLink(value: mood) {
                                            MoodCard(mood: mood)
                                                .frame(width: 160)
                                        }
                                        .scrollTransition { content, phase in
                                            content
                                                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                                                .opacity(phase.isIdentity ? 1 : 0.7)
                                                .blur(radius: phase.isIdentity ? 0 : 2)
                                        }
                                    } else {
                                        NavigationLink(value: mood) {
                                            MoodCard(mood: mood)
                                                .frame(width: 160)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 150)
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                scrollOffset = value
            }
        }
    }
}

struct HeaderView: View {
    let scrollOffset: CGFloat
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Good Morning,")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("My Dear")
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .foregroundStyle(Color.themeText)
                    .scaleEffect(max(0.8, 1 + (scrollOffset / 1000)), anchor: .leading)
            }
            Spacer()
            
            HStack(spacing: 16) {
                NavigationLink(destination: MemoriesView()) {
                    Image(systemName: "heart.fill")
                        .font(.title3)
                        .foregroundStyle(Color.themeAccent)
                        .frame(width: 44, height: 44)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 38))
                        .foregroundStyle(Color.themeAccent)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .background(
            Color.themeBackground.opacity(Double(min(1, max(0, -scrollOffset / 50))))
                .blur(radius: 10)
                .ignoresSafeArea()
        )
    }
}

// Preference Key for scroll tracking
struct ScrollOffsetKey: PreferenceKey {
    nonisolated(unsafe) static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// Extension to avoid index out of bounds
extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}


struct FeaturedStoryCard: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.themeAccent.opacity(0.8), Color.purple.opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(
                // Texture or Pattern could go here
                Color.black.opacity(0.05)
            )
            
            VStack(alignment: .leading, spacing: 8) {
                Text("TODAY'S SPECIAL")
                    .font(.caption2.bold())
                    .kerning(1)
                    .foregroundStyle(.white.opacity(0.9))
                
                Text("The Whispering Woods")
                    .font(.custom("Baskerville-Bold", size: 28))
                    .foregroundStyle(.white)
                
                Text("A cozy tale about a forgotten library in the heart of the forest.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
                    .lineLimit(2)
                
                HStack {
                    Text("Read Story")
                        .font(.subheadline.bold())
                    Image(systemName: "play.circle.fill")
                        .font(.title3)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.white)
                .foregroundStyle(Color.themeAccent)
                .clipShape(Capsule())
                .padding(.top, 8)
            }
            .padding(24)
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .shadow(color: Color.themeAccent.opacity(0.3), radius: 15, x: 0, y: 10)
    }
}

struct MoodCard: View {
    let mood: Mood
    @State private var isHovering = false
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(mood.baseColor.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: mood.icon)
                    .font(.system(size: 30))
                    .foregroundStyle(mood.baseColor)
            }
            
            Text(mood.name)
                .font(.headline)
                .foregroundStyle(Color.themeText)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(.white.opacity(0.5), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.03), radius: 10, x: 0, y: 5)
        .scaleEffect(isHovering ? 1.03 : 1.0)
        .onAppear {
            // Micro-animation entry?
        }
    }
}

struct CustomBottomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            TabBarButton(image: "book.closed.fill", text: "Stories", isSelected: selectedTab == .stories) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { selectedTab = .stories }
            }
            
            Spacer()
            
            TabBarButton(image: "music.note.house.fill", text: "Music", isSelected: selectedTab == .music) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { selectedTab = .music }
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 14)
        .background(
            ZStack {
                Capsule()
                    .fill(.ultraThinMaterial)
                Capsule()
                    .stroke(.white.opacity(0.5), lineWidth: 1)
            }
        )
        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
        .padding(.horizontal, 40)
        .padding(.bottom, 25)
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
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(isSelected ? Color.themeAccent : .secondary)
                
                if isSelected {
                    Circle()
                        .fill(Color.themeAccent)
                        .frame(width: 4, height: 4)
                        .transition(.scale)
                }
            }
            .frame(width: 60)
        }
    }
}







