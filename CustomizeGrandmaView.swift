import SwiftUI
import SceneKit

struct CustomizeGrandmaView: View {
    @StateObject private var settings = GrandmaSettings()
    @Environment(\.dismiss) private var dismiss
    @State private var showConfetti = false
    
    // Tab selection
    // Tab selection
    @State private var selectedTab = 0
    let tabs = ["Hair", "Glasses", "Outfit", "Pattern", "Accessories", "Hats", "Earrings", "Face", "Backgrounds", "Filters"]
    let tabIcons = ["comb.fill", "eyeglasses", "tshirt.fill", "paintpalette.fill", "sparkles", "graduationcap.fill", "circle.fill", "face.smiling", "photo.fill", "camera.filters"]
    
    var body: some View {
        ZStack {
            // Dynamic Background based on theme / filter
            if settings.filter == .noir {
                Color.black.ignoresSafeArea()
            } else if settings.filter == .sepia {
                Color(red: 0.95, green: 0.9, blue: 0.8).ignoresSafeArea()
            } else {
                backgroundForTheme(settings.backgroundTheme)
            }
            
            // Subtle frosted overlay so the UI stays readable (Adaptive for Light/Dark Mode)
            Color(UIColor.systemBackground).opacity(0.15)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header (Save & Reset)
                HStack(alignment: .center) {
                    Button(action: {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                        settings.reset()
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(Color.themeText.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Text("Grandma Makeover")
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                        .shadow(color: .white.opacity(0.5), radius: 2, x: 0, y: 1)
                    
                    Spacer()
                    
                    Button(action: {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                        showConfetti = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showConfetti = false
                        }
                    }) {
                        Text("Save")
                            .font(.granlyBodyBold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.themeRose)
                            .clipShape(Capsule())
                            .shadow(color: Color.themeRose.opacity(0.4), radius: 6, x: 0, y: 3)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 8)
                
                Spacer()
                
                // 3D Preview (Live)
                ZStack {
                    GrandmaSceneView(
                        action: .constant(.idle),
                        expression: .constant(.neutral),
                        isSpeaking: .constant(false),
                        settings: settings
                    )
                    .scaleEffect(1.2)
                    .offset(y: 40) // Shove her down slightly so she fills the frame
                    
                    // Close button floating at top-left of the preview
                    VStack {
                        HStack {
                            Button(action: { dismiss() }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundStyle(.white)
                                    .shadow(radius: 4)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(16)
                    
                    if showConfetti {
                        ConfettiView()
                            .allowsHitTesting(false)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
                
                // Snapchat-style Bottom Dock
                VStack(spacing: 0) {
                    // Category Icons (Horizontal Scroll)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 24) {
                            ForEach(0..<tabs.count, id: \.self) { index in
                                Button(action: {
                                    let haptic = UISelectionFeedbackGenerator()
                                    haptic.selectionChanged()
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        selectedTab = index
                                    }
                                }) {
                                    VStack(spacing: 6) {
                                        Image(systemName: tabIcons[index])
                                            .font(.system(size: 24, weight: selectedTab == index ? .bold : .regular))
                                            .foregroundStyle(selectedTab == index ? Color.themeRose : Color.themeText.opacity(0.6))
                                            .frame(width: 44, height: 44)
                                            .background(
                                                Circle()
                                                    .fill(selectedTab == index ? Color.themeRose.opacity(0.15) : Color.white.opacity(0.8))
                                            )
                                            // Scale animation
                                            .scaleEffect(selectedTab == index ? 1.15 : 1.0)
                                            
                                        Text(tabs[index])
                                            .font(.system(size: 10, weight: selectedTab == index ? .bold : .semibold, design: .rounded))
                                            .foregroundStyle(selectedTab == index ? Color.themeText : Color.themeText.opacity(0.6))
                                            .lineLimit(1)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                    
                    // Options Area for the Selected Category
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            switch selectedTab {
                            case 0: // Hair
                                OptionGroup(title: "Style") { TextGrid(options: HairStyle.allCases, selected: $settings.hairStyle) }
                                OptionGroup(title: "Color") { ColorGrid(options: HairColor.allCases, selected: $settings.hairColor) }
                            case 1: // Glasses
                                OptionGroup(title: "Frames") { TextGrid(options: GlassesStyle.allCases, selected: $settings.glassesStyle) }
                            case 2: // Outfit
                                OptionGroup(title: "Color") { ColorGrid(options: OutfitColor.allCases, selected: $settings.outfitColor) }
                            case 3: // Pattern
                                OptionGroup(title: "Pattern") { TextGrid(options: OutfitPattern.allCases, selected: $settings.outfitPattern) }
                            case 4: // Accessories
                                OptionGroup(title: "Necklace") { TextGrid(options: AccessoryType.allCases, selected: $settings.accessory) }
                            case 5: // Hats
                                OptionGroup(title: "Hat Style") { TextGrid(options: HatStyle.allCases, selected: $settings.hatStyle) }
                            case 6: // Earrings
                                OptionGroup(title: "Earrings") { TextGrid(options: EarringStyle.allCases, selected: $settings.earringStyle) }
                            case 7: // Face
                                OptionGroup(title: "Skin Tone") { SkinToneGrid(options: SkinTone.allCases, selected: $settings.skinTone) }
                                OptionGroup(title: "Expression") { TextGrid(options: FacialExpression.allCases, selected: $settings.facialExpression) }
                            case 8: // Backgrounds
                                OptionGroup(title: "Theme") { TextGrid(options: BackgroundTheme.allCases, selected: $settings.backgroundTheme) }
                            case 9: // Filters
                                OptionGroup(title: "Camera Filter") { TextGrid(options: CameraFilter.allCases, selected: $settings.filter) }
                            default: EmptyView()
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 32) // Safe area padding
                    }
                    .frame(height: 120) // Fixed height for the options tray to prevent jumping
                }
                .background(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        // Adaptive background for light/dark mode drawer
                        .fill(Color(UIColor.secondarySystemGroupedBackground).opacity(0.95))
                        .shadow(color: Color(UIColor.label).opacity(0.1), radius: 10, x: 0, y: -5)
                )
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
    
    @ViewBuilder
    private func backgroundForTheme(_ theme: BackgroundTheme) -> some View {
        switch theme {
        case .cozyRoom:
            LinearGradient(colors: [Color(red: 0.9, green: 0.8, blue: 0.7), Color(red: 0.8, green: 0.6, blue: 0.5)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
        case .garden:
            LinearGradient(colors: [Color(red: 0.7, green: 0.9, blue: 0.7), Color(red: 0.4, green: 0.7, blue: 0.4)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
        case .library:
            LinearGradient(colors: [Color(red: 0.5, green: 0.4, blue: 0.3), Color(red: 0.3, green: 0.2, blue: 0.15)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
        case .gradient:
            MeshGradientBackground().ignoresSafeArea()
        }
    }
}

// Confetti Overlay
struct ConfettiView: View {
    var body: some View {
        ZStack {
            ForEach(0..<40, id: \.self) { i in
                Rectangle()
                    .fill([Color.red, .blue, .green, .yellow, .orange, .purple].randomElement()!)
                    .frame(width: 8, height: 8)
                    .rotationEffect(.degrees(Double.random(in: 0...360)))
                    .offset(x: CGFloat.random(in: -150...150), y: CGFloat.random(in: -300...300))
                    .animation(.easeOut(duration: 1).delay(Double.random(in: 0...0.2)), value: true)
            }
        }
    }
}

// MARK: - Components

struct OptionGroup<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
            
            content
        }
        .padding(.vertical, 8)
    }
}

struct ColorGrid<T: Identifiable & RawRepresentable>: View where T.RawValue == String {
    let options: [T]
    @Binding var selected: T
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(options) { option in
                Button(action: {
                    let haptic = UISelectionFeedbackGenerator()
                    haptic.selectionChanged()
                    withAnimation(.easeInOut(duration: 0.2)) { selected = option }
                }) {
                    ZStack {
                        Circle()
                            .fill(getColor(for: option))
                            .frame(width: 44, height: 44)
                            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                        
                        if selected.id == option.id {
                            Circle()
                                .stroke(Color.themeRose, lineWidth: 3)
                                .frame(width: 52, height: 52)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 8)
    }
    
    func getColor(for option: T) -> Color {
        if let h = option as? HairColor { return Color(uiColor: h.uiColor) }
        if let o = option as? OutfitColor { return Color(uiColor: o.uiColor) }
        return .gray
    }
}

struct SkinToneGrid: View {
    let options: [SkinTone]
    @Binding var selected: SkinTone
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(options) { option in
                Button(action: {
                    let haptic = UISelectionFeedbackGenerator()
                    haptic.selectionChanged()
                    withAnimation(.easeInOut(duration: 0.2)) { selected = option }
                }) {
                    ZStack {
                        Circle()
                            .fill(Color(uiColor: option.uiColor))
                            .frame(width: 44, height: 44)
                            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                        
                        if selected == option {
                            Circle()
                                .stroke(Color.themeRose, lineWidth: 3)
                                .frame(width: 52, height: 52)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

struct TextGrid<T: Identifiable & RawRepresentable>: View where T.RawValue == String {
    let options: [T]
    @Binding var selected: T
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(options) { option in
                Button(action: {
                    let haptic = UISelectionFeedbackGenerator()
                    haptic.selectionChanged()
                    withAnimation(.easeInOut(duration: 0.2)) { selected = option }
                }) {
                    Text(option.rawValue)
                        .font(.system(size: 14, weight: selected.id == option.id ? .bold : .medium, design: .rounded))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(selected.id == option.id ? Color.themeRose : Color.white)
                        .foregroundStyle(selected.id == option.id ? .white : Color.themeText)
                        .clipShape(Capsule())
                        .shadow(color: selected.id == option.id ? Color.themeRose.opacity(0.3) : .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        // Slight scale on selection
                        .scaleEffect(selected.id == option.id ? 1.05 : 1.0)
                }
            }
        }
        .padding(.horizontal, 4)
    }
}
