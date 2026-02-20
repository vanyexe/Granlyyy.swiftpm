import SwiftUI

struct RecipeListView: View {
    let recipes = RecipeData.comfortRecipes
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Grandma's Kitchen")
                                .font(.system(size: 36, weight: .bold, design: .serif))
                                .foregroundStyle(Color.themeText)
                            
                            Text("Comfort food for the soul.")
                                .font(.title3)
                                .foregroundStyle(Color.themeRose)
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        // Recipe Grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(recipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeCard(recipe: recipe)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(recipe.color.opacity(0.15))
                    .frame(width: 60, height: 60)
                
                Image(systemName: recipe.iconName)
                    .font(.title)
                    .foregroundStyle(recipe.color)
            }
            .padding(.top, 16)
            
            VStack(spacing: 4) {
                Text(recipe.title)
                    .font(.headline.bold())
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.themeText)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.caption2)
                    Text(recipe.cookTime)
                        .font(.caption.bold())
                }
                .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.themeCard)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header Image
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(LinearGradient(colors: [recipe.color, recipe.color.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 250)
                    
                    Image(systemName: recipe.iconName)
                        .font(.system(size: 80))
                        .foregroundStyle(.white.opacity(0.9))
                        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Title and Timing
                VStack(alignment: .leading, spacing: 12) {
                    Text(recipe.title)
                        .font(.system(size: 32, weight: .bold, design: .serif))
                        .foregroundStyle(Color.themeText)
                    
                    HStack(spacing: 16) {
                        TimingBadge(icon: "scissors", text: "Prep: \(recipe.prepTime)")
                        TimingBadge(icon: "flame.fill", text: "Cook: \(recipe.cookTime)")
                    }
                }
                .padding(.horizontal)
                
                // Backstory
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "quote.opening")
                            .font(.title2)
                            .foregroundStyle(recipe.color)
                        Text("Grandma Says...")
                            .font(.title3.bold())
                            .foregroundStyle(Color.themeText)
                    }
                    
                    Text(recipe.backstory)
                        .font(.body.italic())
                        .lineSpacing(6)
                        .foregroundStyle(Color.themeText.opacity(0.8))
                        .padding()
                        .background(recipe.color.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal)
                
                // Ingredients
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ingredients")
                        .font(.title2.bold())
                        .foregroundStyle(Color.themeText)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            HStack(alignment: .top, spacing: 12) {
                                Circle()
                                    .fill(recipe.color)
                                    .frame(width: 8, height: 8)
                                    .padding(.top, 6)
                                Text(ingredient)
                                    .font(.body)
                                    .foregroundStyle(Color.themeText)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.themeCard)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal)
                
                // Instructions
                VStack(alignment: .leading, spacing: 16) {
                    Text("Instructions")
                        .font(.title2.bold())
                        .foregroundStyle(Color.themeText)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, step in
                            HStack(alignment: .top, spacing: 16) {
                                Text("\(index + 1)")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .frame(width: 28, height: 28)
                                    .background(recipe.color)
                                    .clipShape(Circle())
                                
                                Text(step)
                                    .font(.body)
                                    .lineSpacing(4)
                                    .foregroundStyle(Color.themeText)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.themeCard)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .background(Color.themeBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.themeText)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct TimingBadge: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundStyle(Color.themeRose)
            Text(text)
                .font(.subheadline.bold())
                .foregroundStyle(Color.themeText)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.themeCard)
        .clipShape(Capsule())
    }
}

#Preview {
    RecipeListView()
}
