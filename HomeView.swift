import SwiftUI

struct HomeView: View {
    let moods = Mood.allMoods
    @State private var selectedMood: Mood?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBackground.ignoresSafeArea()
                
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
                        NavigationLink(destination: MemoriesView()) { // Open Saved Memories
                            Image(systemName: "heart.text.square")
                                .font(.system(size: 28))
                                .foregroundStyle(Color.themeAccent)
                                .padding(8)
                                .background(Circle().fill(Color.themeAccent.opacity(0.1)))
                        }
                        
                        // Profile Button (User)
                        Button(action: {
                            // User profile action
                        }) {
                            Image("user_profile_image") // Ensure this asset name matches
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.themeAccent, lineWidth: 1))
                                .shadow(radius: 2)
                        }
                        .padding(.trailing, 8)

                        // Grandma Avatar Icon
                        Image("sweet_grandma_avatar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.themeAccent, lineWidth: 1))
                            .shadow(radius: 2)
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
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 20)], spacing: 20) {
                        ForEach(moods) { mood in
                            NavigationLink(value: mood) {
                                MoodCard(mood: mood)
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .navigationDestination(for: Mood.self) { mood in
                StoryView(mood: mood)
            }
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




