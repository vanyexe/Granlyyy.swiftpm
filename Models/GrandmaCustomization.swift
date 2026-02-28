import SwiftUI
import SceneKit

protocol LocalizedOption: Identifiable, Hashable {
    var localizedLabel: String { get }
}

enum CameraFilter: String, CaseIterable, Identifiable {
    case none = "Original"
    case warm = "Warm"
    case cool = "Cool"
    case sepia = "Sepia"
    case noir = "Noir"

    var id: String { rawValue }

    var localizedLabel: String {
        let lang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "") ?? .english
        switch self {
        case .none:  return [".english": "Original", ".hindi": "असल",       ".spanish": "Original", ".french": "Original", ".mandarin": "原始"][lang.rawValue] ?? rawValue
        case .warm:  return [".english": "Warm",     ".hindi": "गर्म",       ".spanish": "Cálido",   ".french": "Chaud",    ".mandarin": "暖色"][lang.rawValue] ?? rawValue
        case .cool:  return [".english": "Cool",     ".hindi": "ठंडा",       ".spanish": "Frío",     ".french": "Frais",    ".mandarin": "冷色"][lang.rawValue] ?? rawValue
        case .sepia: return [".english": "Sepia",    ".hindi": "सेपिया",     ".spanish": "Sepia",    ".french": "Sépia",   ".mandarin": "棕色"][lang.rawValue] ?? rawValue
        case .noir:  return [".english": "Noir",     ".hindi": "नोयर",       ".spanish": "Noir",     ".french": "Noir",     ".mandarin": "黑白"][lang.rawValue] ?? rawValue
        }
    }

    var colorFilter: CIFilter? {
        switch self {
        case .sepia: return CIFilter(name: "CISepiaTone")
        case .noir: return CIFilter(name: "CIPhotoEffectNoir")
        default: return nil
        }
    }
}

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

    var localizedLabel: String {
        let lang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "") ?? .english
        switch self {
        case .bun:   return [".english": "Classic Bun",   ".hindi": "क्लासिक जूड़ा",    ".spanish": "Moño Clásico",       ".french": "Chignon Classique",   ".mandarin": "经典发髻"][lang.rawValue] ?? rawValue
        case .bob:   return [".english": "Short Bob",     ".hindi": "शॉर्ट बॉब",        ".spanish": "Bob Corto",           ".french": "Carré Court",         ".mandarin": "短波波头"][lang.rawValue] ?? rawValue
        case .long:  return [".english": "Loose Waves",   ".hindi": "लहराती लटें",      ".spanish": "Ondas Sueltas",       ".french": "Ondulations Libres",  ".mandarin": "波浪长发"][lang.rawValue] ?? rawValue
        case .pixie: return [".english": "Pixie Cut",     ".hindi": "पिक्सी कट",        ".spanish": "Corte Pixie",         ".french": "Coupe Pixie",         ".mandarin": "精灵短发"][lang.rawValue] ?? rawValue
        }
    }
}

enum GlassesStyle: String, CaseIterable, Identifiable {
    case round = "Round"
    case square = "Square"
    case catEye = "Cat Eye"
    case none = "None"

    var id: String { rawValue }

    var localizedLabel: String {
        let lang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "") ?? .english
        switch self {
        case .round:  return [".english": "Round",   ".hindi": "गोल",         ".spanish": "Redondo",    ".french": "Rond",     ".mandarin": "圆框"][lang.rawValue] ?? rawValue
        case .square: return [".english": "Square",  ".hindi": "चौकोर",       ".spanish": "Cuadrado",   ".french": "Carré",    ".mandarin": "方框"][lang.rawValue] ?? rawValue
        case .catEye: return [".english": "Cat Eye", ".hindi": "कैट आई",      ".spanish": "Ojo de Gato",".french": "Œil de Chat",".mandarin": "猫眼"][lang.rawValue] ?? rawValue
        case .none:   return [".english": "None",    ".hindi": "कोई नहीं",    ".spanish": "Ninguno",    ".french": "Aucun",    ".mandarin": "无"][lang.rawValue] ?? rawValue
        }
    }
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
        case .floral: return UIColor(red: 0.95, green: 0.90, blue: 0.80, alpha: 1)
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

    var localizedLabel: String {
        let lang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "") ?? .english
        switch self {
        case .pearl:  return [".english": "Pearls",      ".hindi": "मोती",        ".spanish": "Perlas",           ".french": "Perles",         ".mandarin": "珍珠项链"][lang.rawValue] ?? rawValue
        case .gold:   return [".english": "Gold Chain",  ".hindi": "सोने की चेन", ".spanish": "Cadena de Oro",   ".french": "Chaîne en Or",   ".mandarin": "金项链"][lang.rawValue] ?? rawValue
        case .scarf:  return [".english": "Silk Scarf",  ".hindi": "रेशमी दुपट्टा",".spanish": "Pañuelo de Seda", ".french": "Foulard en Soie",".mandarin": "丝巾"][lang.rawValue] ?? rawValue
        case .brooch: return [".english": "Ruby Brooch", ".hindi": "माणिक ब्रोच", ".spanish": "Broche de Rubí",  ".french": "Broche en Rubis",".mandarin": "红宝石胸针"][lang.rawValue] ?? rawValue
        case .none:   return [".english": "None",        ".hindi": "कोई नहीं",    ".spanish": "Ninguno",          ".french": "Aucun",          ".mandarin": "无"][lang.rawValue] ?? rawValue
        }
    }
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

    var localizedLabel: String {
        let lang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "") ?? .english
        switch self {
        case .none:   return [".english": "None",          ".hindi": "कोई नहीं",       ".spanish": "Ninguno",          ".french": "Aucun",              ".mandarin": "无"][lang.rawValue] ?? rawValue
        case .sunHat: return [".english": "Sun Hat",       ".hindi": "धूप टोपी",       ".spanish": "Sombrero de Sol",   ".french": "Chapeau de Soleil", ".mandarin": "遮阳帽"][lang.rawValue] ?? rawValue
        case .beanie: return [".english": "Cozy Beanie",   ".hindi": "गर्म टोपी",      ".spanish": "Gorro Acogedor",    ".french": "Bonnet Douillet",   ".mandarin":"毛线帽"][lang.rawValue] ?? rawValue
        case .beret:  return [".english": "Vintage Beret", ".hindi": "विंटेज बेरेट", ".spanish": "Boina Vintage",     ".french": "Béret Vintage",     ".mandarin": "复古贝雷帽"][lang.rawValue] ?? rawValue
        }
    }
}

enum EarringStyle: String, CaseIterable, Identifiable {
    case none = "None"
    case pearl = "Pearl Drops"
    case goldHoop = "Gold Hoops"
    case diamond = "Diamond Studs"

    var id: String { rawValue }

    var localizedLabel: String {
        let lang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "") ?? .english
        switch self {
        case .none:     return [".english": "None",          ".hindi": "कोई नहीं",       ".spanish": "Ninguno",          ".french": "Aucun",             ".mandarin": "无"][lang.rawValue] ?? rawValue
        case .pearl:    return [".english": "Pearl Drops",   ".hindi": "मोती की बूंद",  ".spanish": "Colgantes de Perla",".french": "Pendants en Perle",".mandarin": "珍珠耳坠"][lang.rawValue] ?? rawValue
        case .goldHoop: return [".english": "Gold Hoops",    ".hindi": "सोने की बालियाँ",".spanish": "Aros Dorados",     ".french": "Anneaux Dorés",    ".mandarin": "金圈耳环"][lang.rawValue] ?? rawValue
        case .diamond:  return [".english": "Diamond Studs", ".hindi": "हीरे के टॉप्स", ".spanish": "Pendientes de Diamante",".french": "Clous Diamant",   ".mandarin": "钻石耳钉"][lang.rawValue] ?? rawValue
        }
    }
}

enum BackgroundTheme: String, CaseIterable, Identifiable {
    case cozyRoom = "Cozy Room"
    case garden = "Spring Garden"
    case library = "Old Library"
    case gradient = "Soft Gradient"

    var id: String { rawValue }

    var localizedLabel: String {
        let lang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "") ?? .english
        switch self {
        case .cozyRoom: return [".english": "Cozy Room",     ".hindi": "आरामदायक कमरा",  ".spanish": "Sala Acogedora",   ".french": "Chambre Douillette", ".mandarin": "温馨房间"][lang.rawValue] ?? rawValue
        case .garden:   return [".english": "Spring Garden", ".hindi": "बाग-बगीचा",      ".spanish": "Jardín Primaveral", ".french": "Jardin de Printemps",".mandarin": "春日花园"][lang.rawValue] ?? rawValue
        case .library:  return [".english": "Old Library",   ".hindi": "पुराना पुस्तकालय",".spanish": "Biblioteca Antigua",".french": "Vieille Bibliothèque",".mandarin": "古老图书馆"][lang.rawValue] ?? rawValue
        case .gradient: return [".english": "Soft Gradient", ".hindi": "सॉफ्ट ग्रेडिएंट",".spanish": "Degradado Suave",  ".french": "Dégradé Doux",       ".mandarin": "柔和渐变"][lang.rawValue] ?? rawValue
        }
    }
}

enum FacialExpression: String, CaseIterable, Identifiable {
    case neutral = "Neutral"
    case smile = "Smile"
    case laughing = "Laughing"
    case surprised = "Surprised"

    var id: String { rawValue }

    var localizedLabel: String {
        let lang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "") ?? .english
        switch self {
        case .neutral:   return [".english": "Neutral",   ".hindi": "तटस्थ",     ".spanish": "Neutral",    ".french": "Neutre",    ".mandarin": "平静"][lang.rawValue] ?? rawValue
        case .smile:     return [".english": "Smile",     ".hindi": "मुस्कान",   ".spanish": "Sonrisa",   ".french": "Sourire",  ".mandarin": "微笑"][lang.rawValue] ?? rawValue
        case .laughing:  return [".english": "Laughing",  ".hindi": "हँसती हुई", ".spanish": "Riendo",    ".french": "Riant",    ".mandarin": "大笑"][lang.rawValue] ?? rawValue
        case .surprised: return [".english": "Surprised", ".hindi": "हैरान",     ".spanish": "Sorprendida",".french": "Surprise",".mandarin": "惊讶"][lang.rawValue] ?? rawValue
        }
    }
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

    var localizedLabel: String {
        let lang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "") ?? .english
        switch self {
        case .casual:    return [".english": "Casual",    ".hindi": "सामान्य",  ".spanish": "Casual",     ".french": "Décontracté",".mandarin": "休闲"][lang.rawValue] ?? rawValue
        case .saree:     return [".english": "Saree",     ".hindi": "साड़ी",     ".spanish": "Sari",       ".french": "Sari",       ".mandarin": "纱丽"][lang.rawValue] ?? rawValue
        case .nightwear: return [".english": "Nightwear", ".hindi": "नाइटवियर", ".spanish": "Ropa de Noche",".french": "Vêtements de Nuit",".mandarin": "睡衣"][lang.rawValue] ?? rawValue
        case .festive:   return [".english": "Festive",   ".hindi": "उत्सव",    ".spanish": "Festivo",    ".french": "Festif",     ".mandarin": "节日"][lang.rawValue] ?? rawValue
        }
    }
}

struct PresetLook {
    let name: String
    let hairColor: HairColor
    let hairStyle: HairStyle
    let glassesStyle: GlassesStyle
    let outfitColor: OutfitColor
    let outfitPattern: OutfitPattern
    let outfitStyle: OutfitStyle
    let hatStyle: HatStyle
    let earringStyle: EarringStyle
    let eyeColor: EyeColor
    let skinTone: SkinTone
    let hasLashes: Bool
    let greyIntensity: Double
    let wrinkleIntensity: Double
    let browThickness: Double
    let backgroundTheme: BackgroundTheme

    static let all: [PresetLook] = [
        PresetLook(name: "Classic Gran",
            hairColor: .gray, hairStyle: .bun, glassesStyle: .round,
            outfitColor: .lavender, outfitPattern: .solid, outfitStyle: .casual,
            hatStyle: .none, earringStyle: .pearl, eyeColor: .brown, skinTone: .light,
            hasLashes: true, greyIntensity: 0.9, wrinkleIntensity: 0.5, browThickness: 0.4,
            backgroundTheme: .cozyRoom),

        PresetLook(name: "Bollywood Diva",
            hairColor: .black, hairStyle: .bun, glassesStyle: .none,
            outfitColor: .rose, outfitPattern: .floral, outfitStyle: .saree,
            hatStyle: .none, earringStyle: .goldHoop, eyeColor: .brown, skinTone: .medium,
            hasLashes: true, greyIntensity: 0.1, wrinkleIntensity: 0.2, browThickness: 0.8,
            backgroundTheme: .garden),

        PresetLook(name: "Cozy Baker",
            hairColor: .white, hairStyle: .bob, glassesStyle: .square,
            outfitColor: .floral, outfitPattern: .stripes, outfitStyle: .casual,
            hatStyle: .sunHat, earringStyle: .none, eyeColor: .hazel, skinTone: .olive,
            hasLashes: true, greyIntensity: 1.0, wrinkleIntensity: 0.7, browThickness: 0.3,
            backgroundTheme: .cozyRoom),

        PresetLook(name: "Garden Party",
            hairColor: .blonde, hairStyle: .long, glassesStyle: .catEye,
            outfitColor: .teal, outfitPattern: .polkaDots, outfitStyle: .casual,
            hatStyle: .sunHat, earringStyle: .diamond, eyeColor: .blue, skinTone: .light,
            hasLashes: true, greyIntensity: 0.3, wrinkleIntensity: 0.3, browThickness: 0.6,
            backgroundTheme: .garden),

        PresetLook(name: "Midnight Glam",
            hairColor: .black, hairStyle: .pixie, glassesStyle: .catEye,
            outfitColor: .navy, outfitPattern: .plaid, outfitStyle: .festive,
            hatStyle: .none, earringStyle: .diamond, eyeColor: .green, skinTone: .deep,
            hasLashes: true, greyIntensity: 0.0, wrinkleIntensity: 0.1, browThickness: 0.9,
            backgroundTheme: .library),

        PresetLook(name: "Festival Queen",
            hairColor: .red, hairStyle: .bun, glassesStyle: .round,
            outfitColor: .rose, outfitPattern: .floral, outfitStyle: .festive,
            hatStyle: .beret, earringStyle: .goldHoop, eyeColor: .hazel, skinTone: .medium,
            hasLashes: true, greyIntensity: 0.0, wrinkleIntensity: 0.4, browThickness: 0.7,
            backgroundTheme: .gradient),

        PresetLook(name: "Wise Elder",
            hairColor: .white, hairStyle: .bun, glassesStyle: .square,
            outfitColor: .navy, outfitPattern: .solid, outfitStyle: .casual,
            hatStyle: .none, earringStyle: .pearl, eyeColor: .brown, skinTone: .tan,
            hasLashes: false, greyIntensity: 1.0, wrinkleIntensity: 0.9, browThickness: 0.3,
            backgroundTheme: .library),

        PresetLook(name: "Autumn Stroll",
            hairColor: .red, hairStyle: .long, glassesStyle: .round,
            outfitColor: .floral, outfitPattern: .plaid, outfitStyle: .casual,
            hatStyle: .beret, earringStyle: .pearl, eyeColor: .hazel, skinTone: .tan,
            hasLashes: true, greyIntensity: 0.2, wrinkleIntensity: 0.4, browThickness: 0.5,
            backgroundTheme: .library),

        PresetLook(name: "Rose Garden",
            hairColor: .gray, hairStyle: .long, glassesStyle: .catEye,
            outfitColor: .rose, outfitPattern: .floral, outfitStyle: .casual,
            hatStyle: .sunHat, earringStyle: .diamond, eyeColor: .blue, skinTone: .light,
            hasLashes: true, greyIntensity: 0.7, wrinkleIntensity: 0.3, browThickness: 0.5,
            backgroundTheme: .garden),

        PresetLook(name: "Ocean Breeze",
            hairColor: .white, hairStyle: .pixie, glassesStyle: .none,
            outfitColor: .teal, outfitPattern: .stripes, outfitStyle: .casual,
            hatStyle: .none, earringStyle: .goldHoop, eyeColor: .blue, skinTone: .medium,
            hasLashes: true, greyIntensity: 0.95, wrinkleIntensity: 0.6, browThickness: 0.35,
            backgroundTheme: .gradient),

        PresetLook(name: "Nightwear Comfy",
            hairColor: .gray, hairStyle: .bob, glassesStyle: .square,
            outfitColor: .lavender, outfitPattern: .polkaDots, outfitStyle: .nightwear,
            hatStyle: .none, earringStyle: .none, eyeColor: .brown, skinTone: .light,
            hasLashes: false, greyIntensity: 0.85, wrinkleIntensity: 0.6, browThickness: 0.3,
            backgroundTheme: .cozyRoom),

        PresetLook(name: "Golden Years",
            hairColor: .blonde, hairStyle: .bun, glassesStyle: .round,
            outfitColor: .floral, outfitPattern: .solid, outfitStyle: .casual,
            hatStyle: .none, earringStyle: .diamond, eyeColor: .hazel, skinTone: .light,
            hasLashes: true, greyIntensity: 0.5, wrinkleIntensity: 0.5, browThickness: 0.55,
            backgroundTheme: .gradient),

        PresetLook(name: "Heritage Chic",
            hairColor: .brown, hairStyle: .bun, glassesStyle: .none,
            outfitColor: .rose, outfitPattern: .solid, outfitStyle: .saree,
            hatStyle: .none, earringStyle: .pearl, eyeColor: .brown, skinTone: .deep,
            hasLashes: true, greyIntensity: 0.15, wrinkleIntensity: 0.3, browThickness: 0.65,
            backgroundTheme: .garden),

        PresetLook(name: "Winter Warmth",
            hairColor: .white, hairStyle: .bob, glassesStyle: .square,
            outfitColor: .navy, outfitPattern: .plaid, outfitStyle: .casual,
            hatStyle: .beanie, earringStyle: .pearl, eyeColor: .brown, skinTone: .light,
            hasLashes: true, greyIntensity: 1.0, wrinkleIntensity: 0.7, browThickness: 0.4,
            backgroundTheme: .library),
    ]
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

    var eyeColor: EyeColor
    var outfitStyle: OutfitStyle
    var wrinkleIntensity: Double
    var greyIntensity: Double
    var browThickness: Double
    var hasLashes: Bool
}

class GrandmaSettings: ObservableObject {
    @AppStorage("hairColor") var hairColor: HairColor = .gray
    @AppStorage("hairStyle") var hairStyle: HairStyle = .bun
    @AppStorage("glassesStyle") var glassesStyle: GlassesStyle = .round
    @AppStorage("outfitColor") var outfitColor: OutfitColor = .lavender
    @AppStorage("accessory") var accessory: AccessoryType = .pearl
    @AppStorage("skinTone") var skinTone: SkinTone = .light
    @AppStorage("cameraFilter") var filter: CameraFilter = .none

    @AppStorage("hatStyle") var hatStyle: HatStyle = .none
    @AppStorage("earringStyle") var earringStyle: EarringStyle = .none
    @AppStorage("backgroundTheme") var backgroundTheme: BackgroundTheme = .gradient
    @AppStorage("facialExpression") var facialExpression: FacialExpression = .smile
    @AppStorage("outfitPattern") var outfitPattern: OutfitPattern = .solid

    @AppStorage("eyeColor") var eyeColor: EyeColor = .brown
    @AppStorage("outfitStyle") var outfitStyle: OutfitStyle = .casual
    @AppStorage("wrinkleIntensity") var wrinkleIntensity: Double = 0.5
    @AppStorage("greyIntensity") var greyIntensity: Double = 0.8
    @AppStorage("browThickness") var browThickness: Double = 0.5
    @AppStorage("hasLashes") var hasLashes: Bool = true

    @Published var undoStack: [MakeoverState] = []
    @Published var redoStack: [MakeoverState] = []
    @Published var currentPresetIndex: Int = 0

    var canUndo: Bool { !undoStack.isEmpty }
    var canRedo: Bool { !redoStack.isEmpty }

    var currentPresetName: String { PresetLook.all[currentPresetIndex % PresetLook.all.count].name }

    func applyPreset() {
        saveState()
        let look = PresetLook.all[currentPresetIndex % PresetLook.all.count]
        withAnimation(.easeInOut(duration: 0.3)) {
            hairColor      = look.hairColor
            hairStyle      = look.hairStyle
            glassesStyle   = look.glassesStyle
            outfitColor    = look.outfitColor
            outfitPattern  = look.outfitPattern
            outfitStyle    = look.outfitStyle
            hatStyle       = look.hatStyle
            earringStyle   = look.earringStyle
            eyeColor       = look.eyeColor
            skinTone       = look.skinTone
            hasLashes      = look.hasLashes
            greyIntensity  = look.greyIntensity
            wrinkleIntensity = look.wrinkleIntensity
            browThickness  = look.browThickness
            backgroundTheme = look.backgroundTheme
        }
        currentPresetIndex = (currentPresetIndex + 1) % PresetLook.all.count
    }

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

        if undoStack.last != currentState {
            undoStack.append(currentState)

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

extension HairStyle: LocalizedOption { }
extension GlassesStyle: LocalizedOption { }
extension AccessoryType: LocalizedOption { }
extension HatStyle: LocalizedOption { }
extension EarringStyle: LocalizedOption { }
extension BackgroundTheme: LocalizedOption { }
extension FacialExpression: LocalizedOption { }
extension OutfitStyle: LocalizedOption { }
extension CameraFilter: LocalizedOption { }
