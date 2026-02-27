import SwiftUI

extension Font {
    // MARK: - Granly Design System — Refined Type Scale
    // Inspired by Spotify, Apple Music, Instagram proportions.

    /// Hero display text — large titles only. 34pt Bold Rounded.
    static var granlyTitle: Font {
        .system(size: 34, weight: .bold, design: .rounded)
    }

    /// Section hero titles, page headers. 28pt Semibold Rounded.
    static var granlyTitle2: Font {
        .system(size: 28, weight: .semibold, design: .rounded)
    }

    /// Card headers, section titles. 20pt Semibold Rounded.
    static var granlyHeadline: Font {
        .system(size: 20, weight: .semibold, design: .rounded)
    }

    /// Primary readable body text. 17pt Regular Rounded.
    static var granlyBody: Font {
        .system(size: 17, weight: .regular, design: .rounded)
    }

    /// Emphasized body text — buttons, labels. 17pt Semibold Rounded.
    static var granlyBodyBold: Font {
        .system(size: 17, weight: .semibold, design: .rounded)
    }

    /// Secondary / supporting text. 15pt Medium Rounded.
    static var granlySubheadline: Font {
        .system(size: 15, weight: .medium, design: .rounded)
    }

    /// Metadata, timestamps, hints. 13pt Regular Rounded.
    static var granlyCaption: Font {
        .system(size: 13, weight: .regular, design: .rounded)
    }
}
