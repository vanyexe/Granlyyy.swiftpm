import SwiftUI
import SceneKit

struct CustomizeGrandmaView: View {
    @StateObject private var settings = GrandmaSettings()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var lang: LanguageManager
    @State private var showConfetti = false
    @State private var grandmaAction: GrandmaAction = .idle
    @State private var grandmaExpression: GrandmaExpression = .neutral
    @State private var showPresetToast = false

    @State private var selectedTab = 0

    let tabIcons = ["comb.fill", "eyeglasses", "tshirt.fill", "paintpalette.fill", "sparkles", "graduationcap.fill", "circle.fill", "face.smiling", "photo.fill", "camera.filters"]

    var tabs: [String] {
        [L10n.t(.hair), L10n.t(.glasses), L10n.t(.outfit), L10n.t(.pattern),
         L10n.t(.accessories), L10n.t(.hats), L10n.t(.earrings), L10n.t(.face),
         L10n.t(.backgrounds), L10n.t(.filters)]
    }

    var body: some View {
        ZStack {

            if settings.filter == .noir {
                Color.black.ignoresSafeArea()
            } else if settings.filter == .sepia {
                Color(red: 0.95, green: 0.9, blue: 0.8).ignoresSafeArea()
            } else {
                backgroundForTheme(settings.backgroundTheme)
            }

            Color(UIColor.systemBackground).opacity(0.15)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()

            VStack(spacing: 0) {

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

                    Button(action: {
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        settings.undo()
                    }) {
                        Image(systemName: "arrow.uturn.backward.circle.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(settings.canUndo ? Color.themeText : Color.gray.opacity(0.3))
                    }
                    .disabled(!settings.canUndo)

                    Text(L10n.t(.makeover))
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                        .padding(.horizontal, 8)

                    Button(action: {
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        settings.redo()
                    }) {
                        Image(systemName: "arrow.uturn.forward.circle.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(settings.canRedo ? Color.themeText : Color.gray.opacity(0.3))
                    }
                    .disabled(!settings.canRedo)

                    Spacer()

                    Button(action: {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                        showConfetti = true

                        grandmaAction = .celebrate
                        grandmaExpression = .happy

                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            showConfetti = false
                            grandmaAction = .idle
                            grandmaExpression = .neutral
                        }
                    }) {
                        Text(L10n.t(.saveLabel))
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

                ZStack {
                    GrandmaSceneView(
                        action: $grandmaAction,
                        expression: $grandmaExpression,
                        isSpeaking: .constant(false),
                        settings: settings
                    )
                    .scaleEffect(1.2)
                    .offset(y: 40)

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

                        HStack {
                            Spacer()
                            VStack(spacing: 6) {

                                if showPresetToast {
                                    Text(settings.currentPresetName)
                                        .font(.system(size: 13, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            Capsule()
                                                .fill(.ultraThinMaterial)
                                                .overlay(Capsule().stroke(Color.themeRose.opacity(0.6), lineWidth: 1))
                                        )
                                        .shadow(color: Color.themeRose.opacity(0.4), radius: 8)
                                        .transition(.opacity.combined(with: .scale(scale: 0.85, anchor: .bottom)))
                                }

                                Button(action: {
                                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                    settings.applyPreset()
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        showPresetToast = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                                        withAnimation { showPresetToast = false }
                                    }
                                }) {
                                    ZStack {

                                        Circle()
                                            .fill(
                                                RadialGradient(
                                                    colors: [Color.themeRose.opacity(0.5), Color.clear],
                                                    center: .center, startRadius: 4, endRadius: 34
                                                )
                                            )
                                            .frame(width: 62, height: 62)

                                        Circle()
                                            .fill(
                                                LinearGradient(
                                                    colors: [Color.themeRose, Color.themeWarm.opacity(0.85)],
                                                    startPoint: .topLeading, endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(width: 54, height: 54)
                                            .shadow(color: Color.themeRose.opacity(0.55), radius: 12, x: 0, y: 5)

                                        Image(systemName: "wand.and.stars")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                        }
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

                VStack(spacing: 0) {

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

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            switch selectedTab {
                            case 0:
                                OptionGroup(title: L10n.t(.optionStyle)) { TextGrid(options: HairStyle.allCases, selected: $settings.hairStyle, settings: settings) }
                                OptionGroup(title: L10n.t(.optionColor)) { ColorGrid(options: HairColor.allCases, selected: $settings.hairColor, settings: settings) }
                                SnapshotSlider(title: L10n.t(.greyIntensity), value: $settings.greyIntensity, settings: settings)
                            case 1:
                                OptionGroup(title: L10n.t(.optionFrames)) { TextGrid(options: GlassesStyle.allCases, selected: $settings.glassesStyle, settings: settings) }
                            case 2:
                                OptionGroup(title: L10n.t(.optionStyle)) { TextGrid(options: OutfitStyle.allCases, selected: $settings.outfitStyle, settings: settings) }
                                OptionGroup(title: L10n.t(.optionColor)) { ColorGrid(options: OutfitColor.allCases, selected: $settings.outfitColor, settings: settings) }
                            case 3:
                                OptionGroup(title: L10n.t(.pattern)) { TextGrid(options: OutfitPattern.allCases, selected: $settings.outfitPattern, settings: settings) }
                            case 4:
                                OptionGroup(title: L10n.t(.optionNecklace)) { TextGrid(options: AccessoryType.allCases, selected: $settings.accessory, settings: settings) }
                            case 5:
                                OptionGroup(title: L10n.t(.optionHatStyle)) { TextGrid(options: HatStyle.allCases, selected: $settings.hatStyle, settings: settings) }
                            case 6:
                                OptionGroup(title: L10n.t(.earrings)) { TextGrid(options: EarringStyle.allCases, selected: $settings.earringStyle, settings: settings) }
                            case 7:
                                OptionGroup(title: L10n.t(.optionSkinTone)) { SkinToneGrid(options: SkinTone.allCases, selected: $settings.skinTone, settings: settings) }
                                OptionGroup(title: L10n.t(.optionEyeColor)) { ColorGrid(options: EyeColor.allCases, selected: $settings.eyeColor, settings: settings) }
                                OptionGroup(title: L10n.t(.optionExpression)) { TextGrid(options: FacialExpression.allCases, selected: $settings.facialExpression, settings: settings) }
                                SnapshotSlider(title: L10n.t(.wrinkleIntensity), value: $settings.wrinkleIntensity, settings: settings)
                                SnapshotSlider(title: L10n.t(.browThickness), value: $settings.browThickness, settings: settings)
                                OptionGroup(title: L10n.t(.optionLashes)) { SnapshotToggle(title: L10n.t(.eyelashes), isOn: $settings.hasLashes, settings: settings) }
                            case 8:
                                OptionGroup(title: L10n.t(.optionTheme)) { TextGrid(options: BackgroundTheme.allCases, selected: $settings.backgroundTheme, settings: settings) }
                            case 9:
                                OptionGroup(title: L10n.t(.optionCameraFilter)) { TextGrid(options: CameraFilter.allCases, selected: $settings.filter, settings: settings) }
                            default: EmptyView()
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 32)
                    }
                    .frame(height: 120)
                }
                .background(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)

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
    var settings: GrandmaSettings?

    var body: some View {
        HStack(spacing: 16) {
            ForEach(options) { option in
                Button(action: {
                    settings?.saveState()
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
        if let e = option as? EyeColor { return Color(uiColor: e.uiColor) }
        return .gray
    }
}

struct SkinToneGrid: View {
    let options: [SkinTone]
    @Binding var selected: SkinTone
    var settings: GrandmaSettings?

    var body: some View {
        HStack(spacing: 16) {
            ForEach(options) { option in
                Button(action: {
                    settings?.saveState()
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

struct TextGrid<T: LocalizedOption>: View {
    let options: [T]
    @Binding var selected: T
    var settings: GrandmaSettings?

    var body: some View {
        HStack(spacing: 12) {
            ForEach(options) { option in
                Button(action: {
                    settings?.saveState()
                    let haptic = UISelectionFeedbackGenerator()
                    haptic.selectionChanged()
                    withAnimation(.easeInOut(duration: 0.2)) { selected = option }
                }) {
                    Text(option.localizedLabel)
                        .font(.system(size: 14, weight: selected.id == option.id ? .bold : .medium, design: .rounded))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(selected.id == option.id ? Color.themeRose : Color.white)
                        .foregroundStyle(selected.id == option.id ? .white : Color.themeText)
                        .clipShape(Capsule())
                        .shadow(color: selected.id == option.id ? Color.themeRose.opacity(0.3) : .black.opacity(0.05), radius: 4, x: 0, y: 2)

                        .scaleEffect(selected.id == option.id ? 1.05 : 1.0)
                }
            }
        }
        .padding(.horizontal, 4)
    }
}

struct SnapshotSlider: View {
    let title: String
    @Binding var value: Double
    var settings: GrandmaSettings?

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
                .padding(.leading, 4)
            Slider(value: Binding(
                get: { value },
                set: { newValue in
                    value = newValue
                    let haptic = UISelectionFeedbackGenerator()
                    haptic.selectionChanged()
                }
            ), in: 0...1) { editing in
                if editing {
                    settings?.saveState()
                }
            }
            .tint(Color.themeRose)
        }
        .padding(.horizontal, 8)
        .frame(width: 180)

        .padding(.vertical, 8)
    }
}

struct SnapshotToggle: View {
    let title: String
    @Binding var isOn: Bool
    var settings: GrandmaSettings?

    var body: some View {
        Toggle(title, isOn: Binding(
            get: { isOn },
            set: { newValue in
                settings?.saveState()
                let haptic = UISelectionFeedbackGenerator()
                haptic.selectionChanged()
                isOn = newValue
            }
        ))
        .font(.system(size: 14, weight: .bold, design: .rounded))
        .foregroundStyle(Color.themeText)
        .tint(Color.themeRose)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}