import SwiftUI

extension Color {
    // Warm Light Mode Palette
    static let granlyCream = Color(red: 0.98, green: 0.95, blue: 0.91)
    static let granlyRose = Color(red: 0.89, green: 0.52, blue: 0.55)
    static let granlyGold = Color(red: 0.85, green: 0.65, blue: 0.35)
    static let granlyTextLight = Color(red: 0.25, green: 0.15, blue: 0.12)
    
    // Dark Mode Palette
    static let granlyDarkBg = Color(red: 0.10, green: 0.08, blue: 0.14)
    static let granlyDarkAccent = Color(red: 0.92, green: 0.50, blue: 0.45)
    static let granlyTextDark = Color(red: 0.97, green: 0.94, blue: 0.90)
    
    // Adaptive Colors
    static let themeBackground = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.10, green: 0.08, blue: 0.14, alpha: 1) // Deep blackberry
            : UIColor(red: 0.98, green: 0.95, blue: 0.91, alpha: 1) // Warm old paper cream
    })
    
    static let themeAccent = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.92, green: 0.50, blue: 0.45, alpha: 1) // Vibrant coral
            : UIColor(red: 0.88, green: 0.45, blue: 0.40, alpha: 1) // Deep elegant coral
    })
    
    static let themeText = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.97, green: 0.94, blue: 0.90, alpha: 1) // Warm ivory
            : UIColor(red: 0.25, green: 0.15, blue: 0.12, alpha: 1) // Rich espresso
    })
    
    static let themeWarm = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.85, green: 0.55, blue: 0.35, alpha: 1) // Amber / Burnt Orange
            : UIColor(red: 0.96, green: 0.76, blue: 0.55, alpha: 1) // Soft apricot
    })
    
    static let themeGold = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.90, green: 0.75, blue: 0.40, alpha: 1) // Glowing gold
            : UIColor(red: 0.85, green: 0.65, blue: 0.35, alpha: 1) // Antique gold
    })
    
    static let themeRose = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.85, green: 0.45, blue: 0.50, alpha: 1) // Deep magenta-rose
            : UIColor(red: 0.89, green: 0.52, blue: 0.55, alpha: 1) // Soft dusty rose
    })
    
    static let themeCard = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(white: 1.0, alpha: 0.10)
            : UIColor(white: 1.0, alpha: 0.70)
    })
    
    static let themeGreen = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.35, green: 0.55, blue: 0.45, alpha: 1) // Deep forest/emerald
            : UIColor(red: 0.50, green: 0.65, blue: 0.55, alpha: 1) // Soft sage
    })
}
