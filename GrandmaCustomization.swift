import SwiftUI
import SceneKit

// MARK: - Filter Enum
enum CameraFilter: String, CaseIterable, Identifiable {
    case none = "Original"
    case warm = "Warm"
    case cool = "Cool"
    case sepia = "Sepia"
    case noir = "Noir"
    
    var id: String { rawValue }
    
    var colorFilter: CIFilter? {
        switch self {
        case .sepia: return CIFilter(name: "CISepiaTone")
        case .noir: return CIFilter(name: "CIPhotoEffectNoir")
        default: return nil
        }
    }
}

// MARK: - Enums
enum HairColor: String, CaseIterable, Identifiable {
    case gray = "Silver Gray"
    case white = "Snow White"
    case blonde = "Golden Blonde"
    case brown = "Chestnut Brown"
    case black = "Midnight Black"
    case red = "Auburn Red"
    
    var id: String { rawValue }
    
    var uiColor: UIColor {
        switch self {
        case .gray: return UIColor(red: 0.88, green: 0.88, blue: 0.92, alpha: 1)
        case .white: return UIColor(white: 0.98, alpha: 1)
        case .blonde: return UIColor(red: 0.96, green: 0.87, blue: 0.60, alpha: 1)
        case .brown: return UIColor(red: 0.45, green: 0.35, blue: 0.25, alpha: 1)
        case .black: return UIColor(white: 0.2, alpha: 1)
        case .red: return UIColor(red: 0.70, green: 0.30, blue: 0.20, alpha: 1)
        }
    }
}

enum HairStyle: String, CaseIterable, Identifiable {
    case bun = "Classic Bun"
    case bob = "Short Bob"
    case long = "Loose Waves"
    case pixie = "Pixie Cut"
    
    var id: String { rawValue }
}

enum GlassesStyle: String, CaseIterable, Identifiable {
    case round = "Round"
    case square = "Square"
    case catEye = "Cat Eye"
    case none = "None"
    
    var id: String { rawValue }
}

enum OutfitColor: String, CaseIterable, Identifiable {
    case lavender = "Lavender"
    case teal = "Teal"
    case rose = "Dusty Rose"
    case navy = "Navy Blue"
    case floral = "Spring Floral"
    
    var id: String { rawValue }
    
    var uiColor: UIColor {
        switch self {
        case .lavender: return UIColor(red: 0.80, green: 0.75, blue: 0.92, alpha: 1)
        case .teal: return UIColor(red: 0.30, green: 0.60, blue: 0.65, alpha: 1)
        case .rose: return UIColor(red: 0.85, green: 0.55, blue: 0.55, alpha: 1)
        case .navy: return UIColor(red: 0.20, green: 0.25, blue: 0.40, alpha: 1)
        case .floral: return UIColor(red: 0.95, green: 0.90, blue: 0.80, alpha: 1) // Base for pattern
        }
    }
}

enum AccessoryType: String, CaseIterable, Identifiable {
    case pearl = "Pearls"
    case gold = "Gold Chain"
    case scarf = "Silk Scarf"
    case brooch = "Ruby Brooch"
    case none = "None"
    
    var id: String { rawValue }
}

enum SkinTone: String, CaseIterable, Identifiable {
    case light = "Light"
    case medium = "Medium"
    case olive = "Olive"
    case tan = "Tan"
    case deep = "Deep"
    
    var id: String { rawValue }
    
    var uiColor: UIColor {
        switch self {
        case .light: return UIColor(red: 0.96, green: 0.87, blue: 0.78, alpha: 1)
        case .medium: return UIColor(red: 0.92, green: 0.80, blue: 0.70, alpha: 1)
        case .olive: return UIColor(red: 0.85, green: 0.75, blue: 0.60, alpha: 1)
        case .tan: return UIColor(red: 0.75, green: 0.60, blue: 0.45, alpha: 1)
        case .deep: return UIColor(red: 0.55, green: 0.40, blue: 0.30, alpha: 1)
        }
    }
}

enum HatStyle: String, CaseIterable, Identifiable {
    case none = "None"
    case sunHat = "Sun Hat"
    case beanie = "Cozy Beanie"
    case beret = "Vintage Beret"
    
    var id: String { rawValue }
}

enum EarringStyle: String, CaseIterable, Identifiable {
    case none = "None"
    case pearl = "Pearl Drops"
    case goldHoop = "Gold Hoops"
    case diamond = "Diamond Studs"
    
    var id: String { rawValue }
}

enum BackgroundTheme: String, CaseIterable, Identifiable {
    case cozyRoom = "Cozy Room"
    case garden = "Spring Garden"
    case library = "Old Library"
    case gradient = "Soft Gradient"
    
    var id: String { rawValue }
}

enum FacialExpression: String, CaseIterable, Identifiable {
    case neutral = "Neutral"
    case smile = "Smile"
    case laughing = "Laughing"
    case surprised = "Surprised"
    
    var id: String { rawValue }
}

enum EyeColor: String, CaseIterable, Identifiable {
    case brown = "Brown"
    case blue = "Blue"
    case green = "Green"
    case hazel = "Hazel"
    var id: String { rawValue }
    
    var uiColor: UIColor {
        switch self {
        case .brown: return UIColor(red: 0.35, green: 0.20, blue: 0.10, alpha: 1.0)
        case .blue: return UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)
        case .green: return UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        case .hazel: return UIColor(red: 0.6, green: 0.5, blue: 0.2, alpha: 1.0)
        }
    }
}

enum OutfitStyle: String, CaseIterable, Identifiable {
    case casual = "Casual"
    case saree = "Saree"
    case nightwear = "Nightwear"
    case festive = "Festive"
    var id: String { rawValue }
}

struct MakeoverState: Equatable {
    var hairColor: HairColor
    var hairStyle: HairStyle
    var glassesStyle: GlassesStyle
    var outfitColor: OutfitColor
    var accessory: AccessoryType
    var skinTone: SkinTone
    var filter: CameraFilter
    var hatStyle: HatStyle
    var earringStyle: EarringStyle
    var backgroundTheme: BackgroundTheme
    var facialExpression: FacialExpression
    var outfitPattern: OutfitPattern
    
    // Phase 7 Avatar Engine
    var eyeColor: EyeColor
    var outfitStyle: OutfitStyle
    var wrinkleIntensity: Double
    var greyIntensity: Double
    var browThickness: Double
    var hasLashes: Bool
}

// MARK: - Settings Manager
class GrandmaSettings: ObservableObject {
    @AppStorage("hairColor") var hairColor: HairColor = .gray
    @AppStorage("hairStyle") var hairStyle: HairStyle = .bun
    @AppStorage("glassesStyle") var glassesStyle: GlassesStyle = .round
    @AppStorage("outfitColor") var outfitColor: OutfitColor = .lavender
    @AppStorage("accessory") var accessory: AccessoryType = .pearl
    @AppStorage("skinTone") var skinTone: SkinTone = .light
    @AppStorage("cameraFilter") var filter: CameraFilter = .none
    
    // New Makeover Properties
    @AppStorage("hatStyle") var hatStyle: HatStyle = .none
    @AppStorage("earringStyle") var earringStyle: EarringStyle = .none
    @AppStorage("backgroundTheme") var backgroundTheme: BackgroundTheme = .gradient
    @AppStorage("facialExpression") var facialExpression: FacialExpression = .smile
    @AppStorage("outfitPattern") var outfitPattern: OutfitPattern = .solid
    
    // Phase 7 Avatar Engine Properties
    @AppStorage("eyeColor") var eyeColor: EyeColor = .brown
    @AppStorage("outfitStyle") var outfitStyle: OutfitStyle = .casual
    @AppStorage("wrinkleIntensity") var wrinkleIntensity: Double = 0.5
    @AppStorage("greyIntensity") var greyIntensity: Double = 0.8
    @AppStorage("browThickness") var browThickness: Double = 0.5
    @AppStorage("hasLashes") var hasLashes: Bool = true
    
    // Undo/Redo Stacks
    @Published var undoStack: [MakeoverState] = []
    @Published var redoStack: [MakeoverState] = []
    
    var canUndo: Bool { !undoStack.isEmpty }
    var canRedo: Bool { !redoStack.isEmpty }
    
    func saveState() {
        let currentState = MakeoverState(
            hairColor: hairColor, hairStyle: hairStyle, glassesStyle: glassesStyle,
            outfitColor: outfitColor, accessory: accessory, skinTone: skinTone,
            filter: filter, hatStyle: hatStyle, earringStyle: earringStyle,
            backgroundTheme: backgroundTheme, facialExpression: facialExpression,
            outfitPattern: outfitPattern, eyeColor: eyeColor, outfitStyle: outfitStyle,
            wrinkleIntensity: wrinkleIntensity, greyIntensity: greyIntensity,
            browThickness: browThickness, hasLashes: hasLashes
        )
        // If the top of the stack is already this state, don't duplicate it.
        if undoStack.last != currentState {
            undoStack.append(currentState)
            // Once we make a new change, we invalidate the redo future
            redoStack.removeAll()
        }
    }
    
    func undo() {
        guard canUndo else { return }
        let currentState = MakeoverState(
            hairColor: hairColor, hairStyle: hairStyle, glassesStyle: glassesStyle,
            outfitColor: outfitColor, accessory: accessory, skinTone: skinTone,
            filter: filter, hatStyle: hatStyle, earringStyle: earringStyle,
            backgroundTheme: backgroundTheme, facialExpression: facialExpression,
            outfitPattern: outfitPattern, eyeColor: eyeColor, outfitStyle: outfitStyle,
            wrinkleIntensity: wrinkleIntensity, greyIntensity: greyIntensity,
            browThickness: browThickness, hasLashes: hasLashes
        )
        
        if let previousState = undoStack.popLast() {
            redoStack.append(currentState)
            restore(state: previousState)
        }
    }
    
    func redo() {
        guard canRedo else { return }
        let currentState = MakeoverState(
            hairColor: hairColor, hairStyle: hairStyle, glassesStyle: glassesStyle,
            outfitColor: outfitColor, accessory: accessory, skinTone: skinTone,
            filter: filter, hatStyle: hatStyle, earringStyle: earringStyle,
            backgroundTheme: backgroundTheme, facialExpression: facialExpression,
            outfitPattern: outfitPattern, eyeColor: eyeColor, outfitStyle: outfitStyle,
            wrinkleIntensity: wrinkleIntensity, greyIntensity: greyIntensity,
            browThickness: browThickness, hasLashes: hasLashes
        )
        
        if let nextState = redoStack.popLast() {
            undoStack.append(currentState)
            restore(state: nextState)
        }
    }
    
    private func restore(state: MakeoverState) {
        withAnimation {
            hairColor = state.hairColor
            hairStyle = state.hairStyle
            glassesStyle = state.glassesStyle
            outfitColor = state.outfitColor
            accessory = state.accessory
            skinTone = state.skinTone
            filter = state.filter
            hatStyle = state.hatStyle
            earringStyle = state.earringStyle
            backgroundTheme = state.backgroundTheme
            facialExpression = state.facialExpression
            outfitPattern = state.outfitPattern
            eyeColor = state.eyeColor
            outfitStyle = state.outfitStyle
            wrinkleIntensity = state.wrinkleIntensity
            greyIntensity = state.greyIntensity
            browThickness = state.browThickness
            hasLashes = state.hasLashes
        }
    }
    
    func randomize() {
        saveState()
        withAnimation {
            hairColor = HairColor.allCases.randomElement()!
            hairStyle = HairStyle.allCases.randomElement()!
            glassesStyle = GlassesStyle.allCases.randomElement()!
            outfitColor = OutfitColor.allCases.randomElement()!
            accessory = AccessoryType.allCases.randomElement()!
            skinTone = SkinTone.allCases.randomElement()!
            hatStyle = HatStyle.allCases.randomElement()!
            earringStyle = EarringStyle.allCases.randomElement()!
            facialExpression = FacialExpression.allCases.randomElement()!
            outfitPattern = OutfitPattern.allCases.randomElement()!
            eyeColor = EyeColor.allCases.randomElement()!
            outfitStyle = OutfitStyle.allCases.randomElement()!
            wrinkleIntensity = Double.random(in: 0...1.0)
            greyIntensity = Double.random(in: 0...1.0)
            browThickness = Double.random(in: 0...1.0)
            hasLashes = Bool.random()
        }
    }
    
    func reset() {
        saveState()
        withAnimation {
            hairColor = .gray
            hairStyle = .bun
            glassesStyle = .round
            outfitColor = .lavender
            accessory = .pearl
            skinTone = .light
            filter = .none
            hatStyle = .none
            earringStyle = .none
            backgroundTheme = .gradient
            facialExpression = .smile
            outfitPattern = .solid
            eyeColor = .brown
            outfitStyle = .casual
            wrinkleIntensity = 0.5
            greyIntensity = 0.8
            browThickness = 0.5
            hasLashes = true
        }
    }
}

// Extensions for AppStorage support
extension HairColor: RawRepresentable { }
extension HairStyle: RawRepresentable { }
extension GlassesStyle: RawRepresentable { }
extension OutfitColor: RawRepresentable { }
extension AccessoryType: RawRepresentable { }
extension SkinTone: RawRepresentable { }
extension CameraFilter: RawRepresentable { }
extension HatStyle: RawRepresentable { }
extension EarringStyle: RawRepresentable { }
extension BackgroundTheme: RawRepresentable { }
extension FacialExpression: RawRepresentable { }
extension OutfitPattern: RawRepresentable { }
extension EyeColor: RawRepresentable { }
extension OutfitStyle: RawRepresentable { }
