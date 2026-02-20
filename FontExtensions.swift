import SwiftUI

extension Font {
    // MARK: - Warm Thematic Typography (Granly)
    
    /// Large, striking, modern rounded font for main headers. Feels premium, friendly, and cozy.
    static var granlyTitle: Font {
        .system(size: 38, weight: .heavy, design: .rounded)
    }
    
    /// Bold, engaging font for section headers.
    static var granlyTitle2: Font {
        .system(size: 28, weight: .bold, design: .rounded)
    }
    
    /// Smooth, semi-bold font for card headers or inline titles.
    static var granlyHeadline: Font {
        .system(size: 22, weight: .semibold, design: .rounded)
    }
    
    /// Main body font. Rounded, slightly medium weight for a highly readable, premium feel (like top wellness apps).
    static var granlyBody: Font {
        .system(size: 18, weight: .medium, design: .rounded)
    }
    
    /// Emphasized body font.
    static var granlyBodyBold: Font {
        .system(size: 18, weight: .bold, design: .rounded)
    }
    
    /// Subheadline for secondary descriptive text.
    static var granlySubheadline: Font {
        .system(size: 16, weight: .medium, design: .rounded)
    }
    
    /// Small caption font for metadata or hints.
    static var granlyCaption: Font {
        .system(size: 14, weight: .medium, design: .rounded)
    }
}
