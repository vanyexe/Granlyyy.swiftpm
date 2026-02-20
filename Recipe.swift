import Foundation
import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let backstory: String
    let ingredients: [String]
    let instructions: [String]
    let prepTime: String
    let cookTime: String
    let iconName: String
    let color: Color
}

struct RecipeData {
    static let comfortRecipes: [Recipe] = [
        Recipe(
            title: "Rainy Day Tomato Soup",
            backstory: "Whenever the sky turned grey and the rain started tapping on the kitchen window, I would pull out the big iron pot. This soup isn't just about tomatoes; it's about warming your hands on the bowl and feeling safe inside.",
            ingredients: [
                "2 cans (28oz) whole San Marzano tomatoes",
                "1 large yellow onion, diced",
                "4 cloves garlic, smashed",
                "1/2 cup heavy cream",
                "1/4 cup fresh basil leaves",
                "2 tbsp olive oil",
                "1 tbsp butter",
                "Salt and black pepper to taste"
            ],
            instructions: [
                "In a large pot, melt the butter with the olive oil over medium heat.",
                "Add the diced onion and smashed garlic. Cook until soft and fragrant, about 5-7 minutes.",
                "Pour in the tomatoes (juices and all). Crush them gently with a wooden spoon.",
                "Bring to a simmer, cover, and let it cook on low heat for 30 minutes.",
                "Remove from heat. Add the fresh basil and carefully blend the soup until smooth using an immersion blender.",
                "Stir in the heavy cream and season with salt and pepper.",
                "Serve piping hot with a gooey grilled cheese sandwich."
            ],
            prepTime: "10 mins",
            cookTime: "40 mins",
            iconName: "cup.and.saucer.fill",
            color: .themeRose
        ),
        Recipe(
            title: "Warm Cinnamon Cookies",
            backstory: "The secret to these cookies isn't the cinnamon, my dear—it's letting the dough rest. Sometimes the best things in life require a little bit of patience. The smell alone will make your heart feel ten times lighter.",
            ingredients: [
                "2 3/4 cups all-purpose flour",
                "1 cup unsalted butter, softened",
                "1 1/2 cups white sugar",
                "2 large eggs",
                "2 tsp cream of tartar",
                "1 tsp baking soda",
                "1/2 tsp salt",
                "For rolling: 3 tbsp sugar + 1 tbsp cinnamon"
            ],
            instructions: [
                "Preheat your oven to 350°F (175°C) and line a baking sheet with parchment paper.",
                "In a large bowl, cream together the softened butter and 1 1/2 cups of sugar until light and fluffy.",
                "Beat in the eggs, one at a time.",
                "In a separate bowl, whisk together the flour, cream of tartar, baking soda, and salt.",
                "Gradually blend the dry ingredients into the butter mixture until quite smooth.",
                "In a small bowl, mix the 3 tablespoons of sugar and 1 tablespoon of cinnamon together.",
                "Roll the dough into small, 1-inch balls, then roll them entirely in the cinnamon-sugar mixture.",
                "Place them two inches apart on the baking sheet.",
                "Bake for 8-10 minutes. They should be very soft in the center when you take them out. Let them rest."
            ],
            prepTime: "15 mins",
            cookTime: "10 mins",
            iconName: "star.fill",
            color: .themeWarm
        ),
        Recipe(
            title: "Sunday Roast Chicken",
            backstory: "Every Sunday afternoon, the entire house would smell of rosemary and roasting chicken. It was our signal that it was time to put away our work, sit around the table, and just be a family.",
            ingredients: [
                "1 whole chicken (4-5 lbs)",
                "1/4 cup olive oil or melted butter",
                "1 lemon, halved",
                "1 whole head of garlic, cut in half horizontally",
                "A large bunch of fresh rosemary and thyme",
                "Generous salt and black pepper",
                "4 carrots and 4 potatoes, roughly chopped"
            ],
            instructions: [
                "Preheat your oven to 425°F (220°C).",
                "Pat the chicken completely dry inside and out with paper towels. (This makes the skin crispy!)",
                "Generously salt and pepper the inside of the chicken cavity. Stuff the cavity with the lemon halves, garlic head, and fresh herbs.",
                "Tie the legs together with kitchen twine and tuck the wing tips under the body.",
                "Rub the outside of the chicken all over with olive oil, salt, and pepper.",
                "Place the chopped carrots and potatoes at the bottom of a roasting pan. Toss with a little oil and salt.",
                "Place the chicken on top of the vegetables.",
                "Roast for about 1 hour and 15 minutes, or until the juices run clear.",
                "Let it rest for 15 minutes before carving. This step is crucial!"
            ],
            prepTime: "20 mins",
            cookTime: "1 hr 15 mins",
            iconName: "flame.fill",
            color: .themeGold
        ),
        Recipe(
            title: "Healing Ginger Tea",
            backstory: "Whenever you feel a sniffle coming on, or your stomach is a bit unsettled, this was my go-to remedy. It's sharp, sweet, and feels like a warm hug from the inside out.",
            ingredients: [
                "2-inch piece of fresh ginger root, peeled and thinly sliced",
                "4 cups of water",
                "1/2 lemon, juiced",
                "2-3 tablespoons of raw honey",
                "1 cinnamon stick (optional)"
            ],
            instructions: [
                "Bring the 4 cups of water to a rolling boil in a small saucepan.",
                "Add the sliced ginger and the cinnamon stick if using.",
                "Lower the heat and let it gently simmer for 15-20 minutes, depending on how strong you like it.",
                "Remove from heat and carefully strain the tea into a large mug.",
                "Stir in the fresh lemon juice and honey while it's still hot.",
                "Sip it slowly while wrapped in a favorite blanket."
            ],
            prepTime: "5 mins",
            cookTime: "20 mins",
            iconName: "leaf.fill",
            color: .themeGreen
        )
    ]
}
