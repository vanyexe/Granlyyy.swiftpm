import SwiftUI

extension Color {
    // Light Mode Palette
    static let granlyCream = Color(red: 0.98, green: 0.96, blue: 0.93)
    static let granlyPink = Color(red: 0.95, green: 0.76, blue: 0.78)
    static let granlyTextLight = Color(red: 0.3, green: 0.2, blue: 0.2)
    
    // Dark Mode Palette
    static let granlyDarkBg = Color(red: 0.1, green: 0.1, blue: 0.15)
    static let granlyDarkAccent = Color(red: 0.6, green: 0.4, blue: 0.5)
    static let granlyTextDark = Color(red: 0.9, green: 0.85, blue: 0.8)
    
    // Semantic Colors
    static var backgroundTheme: Color {
        return themeBackground
    }
    
    // Adaptive Colors
    static let themeBackground = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ?
            UIColor(red: 0.1, green: 0.1, blue: 0.15, alpha: 1) :
            UIColor(red: 0.98, green: 0.96, blue: 0.93, alpha: 1)
    })
    
    static let themeAccent = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ?
            UIColor(red: 0.8, green: 0.6, blue: 0.7, alpha: 1) :
            UIColor(red: 0.95, green: 0.60, blue: 0.65, alpha: 1)
    })
    
    static let themeText = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ?
            UIColor(red: 0.95, green: 0.90, blue: 0.85, alpha: 1) :
            UIColor(red: 0.35, green: 0.25, blue: 0.25, alpha: 1)
    })
}


