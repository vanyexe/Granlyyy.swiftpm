import SwiftUI
import SceneKit

struct CustomizeGrandmaView: View {
    @StateObject private var settings = GrandmaSettings()
    @Environment(\.dismiss) private var dismiss
    @State private var animate = true
    @State private var waveTrigger = false // Dummy trigger for preview
    
    // Tab selection
    @State private var selectedTab = 0
    let tabs = ["Hair", "Face", "Outfit", "Style", "Filter"]
    let tabIcons = ["comb.fill", "face.smiling", "tshirt.fill", "sunglasses.fill", "camera.filters"]
    
    var body: some View {
        ZStack {
            // Background depends on filter
            if settings.filter == .noir {
                Color.black.ignoresSafeArea()
            } else if settings.filter == .sepia {
                Color(red: 0.95, green: 0.9, blue: 0.8).ignoresSafeArea()
            } else {
                MeshGradientBackground().ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(Color.themeText)
                    }
                    Spacer()
                    Text("Grandma Makeover")
                        .font(.custom("Baskerville-Bold", size: 24))
                        .foregroundStyle(Color.themeText)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            settings.randomize()
                        }
                    }) {
                        Image(systemName: "dice.fill")
                            .font(.title)
                            .foregroundStyle(Color.themeRose)
                    }
                }
                .padding()
                
                // 3D Preview (Live)
                ZStack {
                    if settings.filter == .noir {
                        Color.gray.opacity(0.2)
                    } else {
                        Color.white.opacity(0.3)
                    }
                    
                    GrandmaSceneView(
                        action: .constant(.idle),
                        expression: .constant(.happy),
                        isSpeaking: .constant(false),
                        settings: settings
                    )
                        .scaleEffect(1.1)
                        .offset(y: 20)
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.themeRose.opacity(0.3), lineWidth: 1))
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                // Customization Tabs
                VStack(spacing: 0) {
                    // Tab Bar
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<tabs.count, id: \.self) { index in
                                Button(action: { selectedTab = index }) {
                                    VStack(spacing: 6) {
                                        Image(systemName: tabIcons[index])
                                            .font(.headline)
                                        Text(tabs[index])
                                            .font(.caption.bold())
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(selectedTab == index ? Color.themeRose : Color.clear)
                                    .foregroundStyle(selectedTab == index ? .white : Color.themeText)
                                    .clipShape(Capsule())
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 12)
                    .background(.ultraThinMaterial)
                    
                    // Options Area
                    ScrollView {
                        VStack(spacing: 24) {
                            switch selectedTab {
                            case 0: // Hair
                                OptionSection(title: "Hair Color") {
                                    ColorGrid(options: HairColor.allCases, selected: $settings.hairColor)
                                }
                                OptionSection(title: "Hair Style") {
                                    TextGrid(options: HairStyle.allCases, selected: $settings.hairStyle)
                                }
                                
                            case 1: // Face
                                OptionSection(title: "Skin Tone") {
                                    SkinToneGrid(options: SkinTone.allCases, selected: $settings.skinTone)
                                }
                                OptionSection(title: "Glasses") {
                                    TextGrid(options: GlassesStyle.allCases, selected: $settings.glassesStyle)
                                }
                                
                            case 2: // Outfit
                                OptionSection(title: "Outfit Color") {
                                    ColorGrid(options: OutfitColor.allCases, selected: $settings.outfitColor)
                                }
                                
                            case 3: // Style/Accessories
                                OptionSection(title: "Accessory") {
                                    TextGrid(options: AccessoryType.allCases, selected: $settings.accessory)
                                }
                                
                            case 4: // Filter
                                OptionSection(title: "Camera Filter") {
                                    TextGrid(options: CameraFilter.allCases, selected: $settings.filter)
                                }
                                
                            default: EmptyView()
                            }
                        }
                        .padding()
                        .padding(.bottom, 40)
                    }
                }
                .background(Color.white.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}

// MARK: - Components

struct OptionSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)
            content
        }
    }
}

struct ColorGrid<T: Identifiable & RawRepresentable>: View where T.RawValue == String {
    let options: [T]
    @Binding var selected: T
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 16) {
            ForEach(options) { option in
                Button(action: { selected = option }) {
                    ZStack {
                        Circle()
                            .fill(getColor(for: option))
                            .frame(width: 50, height: 50)
                            .shadow(radius: 2)
                        
                        if selected.id == option.id {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                                .shadow(radius: 2)
                        }
                    }
                }
            }
        }
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 16) {
            ForEach(options) { option in
                Button(action: { selected = option }) {
                    ZStack {
                        Circle()
                            .fill(Color(uiColor: option.uiColor))
                            .frame(width: 50, height: 50)
                            .shadow(radius: 2)
                        
                        if selected == option {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.black.opacity(0.5))
                        }
                    }
                }
            }
        }
    }
}

struct TextGrid<T: Identifiable & RawRepresentable>: View where T.RawValue == String {
    let options: [T]
    @Binding var selected: T
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 12) {
            ForEach(options) { option in
                Button(action: { selected = option }) {
                    Text(option.rawValue)
                        .font(.subheadline.bold())
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(selected.id == option.id ? Color.themeRose : Color.white)
                        .foregroundStyle(selected.id == option.id ? .white : Color.themeText)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
            }
        }
    }
}
