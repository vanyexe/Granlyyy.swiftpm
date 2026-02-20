import SwiftUI

extension Font {
    // MARK: - Warm Thematic Typography (Granly)
    
    /// Large, elegant serif font for main headers and titles.
    static var granlyTitle: Font {
        .custom("Baskerville", size: 36, relativeTo: .largeTitle).weight(.bold)
    }
    
    /// Medium serif font for section headers and important secondary titles.
    static var granlyTitle2: Font {
        .custom("Baskerville", size: 28, relativeTo: .title2).weight(.bold)
    }
    
    /// Smaller serif font for card headers or inline titles.
    static var granlyHeadline: Font {
        .custom("Baskerville", size: 22, relativeTo: .headline).weight(.semibold)
    }
    
    /// Main body font. Using system rounded or a slightly warmer variant for readability.
    static var granlyBody: Font {
        .system(size: 18, weight: .regular, design: .serif)
    }
    
    /// Emphasized body font.
    static var granlyBodyBold: Font {
        .system(size: 18, weight: .bold, design: .serif)
    }
    
    /// Subheadline for secondary descriptive text.
    static var granlySubheadline: Font {
        .system(size: 16, weight: .medium, design: .serif)
    }
    
    /// Small caption font for metadata or hints.
    static var granlyCaption: Font {
        .system(size: 14, weight: .regular, design: .serif)
    }
}
