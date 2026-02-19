import SwiftUI

extension Color {
    // Warm Light Mode Palette
    static let granlyCream = Color(red: 0.99, green: 0.96, blue: 0.91)
    static let granlyRose = Color(red: 0.92, green: 0.58, blue: 0.55)
    static let granlyGold = Color(red: 0.95, green: 0.82, blue: 0.55)
    static let granlyTextLight = Color(red: 0.28, green: 0.18, blue: 0.16)
    
    // Dark Mode Palette
    static let granlyDarkBg = Color(red: 0.10, green: 0.08, blue: 0.12)
    static let granlyDarkAccent = Color(red: 0.85, green: 0.55, blue: 0.50)
    static let granlyTextDark = Color(red: 0.95, green: 0.90, blue: 0.85)
    
    // Adaptive Colors
    static let themeBackground = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.10, green: 0.08, blue: 0.12, alpha: 1)
            : UIColor(red: 0.99, green: 0.96, blue: 0.91, alpha: 1)
    })
    
    static let themeAccent = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.90, green: 0.55, blue: 0.50, alpha: 1)
            : UIColor(red: 0.90, green: 0.50, blue: 0.45, alpha: 1)
    })
    
    static let themeText = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.95, green: 0.90, blue: 0.85, alpha: 1)
            : UIColor(red: 0.28, green: 0.18, blue: 0.16, alpha: 1)
    })
    
    static let themeWarm = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.95, green: 0.75, blue: 0.50, alpha: 1)
            : UIColor(red: 0.95, green: 0.82, blue: 0.55, alpha: 1)
    })
    
    static let themeGold = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.90, green: 0.78, blue: 0.45, alpha: 1)
            : UIColor(red: 0.88, green: 0.75, blue: 0.40, alpha: 1)
    })
    
    static let themeRose = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.85, green: 0.50, blue: 0.55, alpha: 1)
            : UIColor(red: 0.92, green: 0.58, blue: 0.55, alpha: 1)
    })
    
    static let themeCard = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(white: 1, alpha: 0.08)
            : UIColor(white: 1, alpha: 0.65)
    })
    
    static let themeGreen = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 0.35, green: 0.62, blue: 0.50, alpha: 1)
            : UIColor(red: 0.45, green: 0.72, blue: 0.60, alpha: 1)
    })
}
