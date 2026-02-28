import SwiftUI

enum OutfitPattern: String, CaseIterable, Identifiable {
    case solid = "Solid"
    case stripes = "Stripes"
    case polkaDots = "Polka Dots"
    case plaid = "Plaid"
    case floral = "Floral"

    var id: String { rawValue }

    var localizedLabel: String {
        let lang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "") ?? .english
        switch self {
        case .solid:     return [".english": "Solid",     ".hindi": "सादा",       ".spanish": "Sólido",       ".french": "Uni",          ".mandarin": "纯色"][lang.rawValue] ?? rawValue
        case .stripes:   return [".english": "Stripes",   ".hindi": "धारीदार",     ".spanish": "Rayas",        ".french": "Rayures",      ".mandarin": "条纹"][lang.rawValue] ?? rawValue
        case .polkaDots: return [".english": "Polka Dots",".hindi": "बिंदीदार",    ".spanish": "Lunares",      ".french": "Pois",         ".mandarin": "波点"][lang.rawValue] ?? rawValue
        case .plaid:     return [".english": "Plaid",     ".hindi": "प्लेड",       ".spanish": "Cuadros",      ".french": "Tartan",       ".mandarin": "格子"][lang.rawValue] ?? rawValue
        case .floral:    return [".english": "Floral",    ".hindi": "फूलदार",      ".spanish": "Floral",       ".french": "Floral",       ".mandarin": "花卉"][lang.rawValue] ?? rawValue
        }
    }
}

extension OutfitPattern: LocalizedOption { }

@MainActor
final class TextureGenerator {
    static let shared = TextureGenerator()

    func generateTexture(pattern: OutfitPattern, baseColor: UIColor) -> UIImage {
        let size = CGSize(width: 512, height: 512)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        let renderer = UIGraphicsImageRenderer(size: size, format: format)

        return renderer.image { context in
            let cgContext = context.cgContext
            let rect = CGRect(origin: .zero, size: size)

            baseColor.setFill()
            cgContext.fill(rect)

            if pattern == .solid { return }

            let accentColor: UIColor = baseColor.isLight ? .black.withAlphaComponent(0.3) : .white.withAlphaComponent(0.4)
            accentColor.setFill()
            accentColor.setStroke()

            switch pattern {
            case .stripes:
                drawStripes(ctx: cgContext, rect: rect)

            case .polkaDots:
                drawPolkaDots(ctx: cgContext, rect: rect)

            case .plaid:
                drawPlaid(ctx: cgContext, rect: rect, baseColor: baseColor)

            case .floral:
                drawFloral(ctx: cgContext, rect: rect)

            case .solid: break
            }
        }
    }

    private func drawStripes(ctx: CGContext, rect: CGRect) {
        let stripeWidth: CGFloat = 20
        let spacing: CGFloat = 40
        ctx.setLineWidth(stripeWidth)

        for y in stride(from: -rect.height, to: rect.height * 2, by: spacing) {
            ctx.move(to: CGPoint(x: 0, y: y))
            ctx.addLine(to: CGPoint(x: rect.width, y: y + rect.height))
            ctx.strokePath()
        }
    }

    private func drawPolkaDots(ctx: CGContext, rect: CGRect) {
        let radius: CGFloat = 16
        let spacing: CGFloat = 64

        var isOffset = false
        for y in stride(from: 0, to: rect.height + spacing, by: spacing) {
            let startX: CGFloat = isOffset ? (spacing / 2) : 0
            for x in stride(from: startX, to: rect.width + spacing, by: spacing) {
                let dotRect = CGRect(x: x - radius, y: y - radius, width: radius * 2, height: radius * 2)
                ctx.fillEllipse(in: dotRect)
            }
            isOffset.toggle()
        }
    }

    private func drawPlaid(ctx: CGContext, rect: CGRect, baseColor: UIColor) {
        let thick: CGFloat = 40
        let thin: CGFloat = 10
        let spacing: CGFloat = 120

        let darkAccent = baseColor.isLight ? UIColor.black.withAlphaComponent(0.2) : UIColor.white.withAlphaComponent(0.2)
        let lightAccent = baseColor.isLight ? UIColor.white.withAlphaComponent(0.4) : UIColor.black.withAlphaComponent(0.4)

        darkAccent.setFill()
        for x in stride(from: 0, to: rect.width + spacing, by: spacing) {
            ctx.fill(CGRect(x: x, y: 0, width: thick, height: rect.height))
        }

        for y in stride(from: 0, to: rect.height + spacing, by: spacing) {
            ctx.fill(CGRect(x: 0, y: y, width: rect.width, height: thick))
        }

        lightAccent.setFill()
        for x in stride(from: thick/2, to: rect.width + spacing, by: spacing) {
            ctx.fill(CGRect(x: x - thin/2, y: 0, width: thin, height: rect.height))
        }

        for y in stride(from: thick/2, to: rect.height + spacing, by: spacing) {
            ctx.fill(CGRect(x: 0, y: y - thin/2, width: rect.width, height: thin))
        }
    }

    private func drawFloral(ctx: CGContext, rect: CGRect) {

        let count = 80
        for _ in 0..<count {
            let cx = CGFloat.random(in: 0...rect.width)
            let cy = CGFloat.random(in: 0...rect.height)
            let radius = CGFloat.random(in: 8...24)

            ctx.saveGState()
            ctx.translateBy(x: cx, y: cy)
            ctx.rotate(by: CGFloat.random(in: 0...(2 * .pi)))

            for _ in 0..<5 {
                ctx.rotate(by: (2 * .pi) / 5)
                let petal = CGRect(x: 0, y: 0, width: radius, height: radius * 1.5)
                ctx.fillEllipse(in: petal)
            }

            ctx.setBlendMode(.clear)
            ctx.fillEllipse(in: CGRect(x: -radius/3, y: -radius/3, width: radius/1.5, height: radius/1.5))

            ctx.restoreGState()
        }
    }
}

extension UIColor {
    var isLight: Bool {
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        return white >= 0.5
    }
}