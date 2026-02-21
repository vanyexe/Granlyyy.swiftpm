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
    
    func randomize() {
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
        }
    }
    
    func reset() {
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
