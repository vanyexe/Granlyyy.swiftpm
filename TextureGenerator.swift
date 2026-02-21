import SwiftUI

enum OutfitPattern: String, CaseIterable, Identifiable {
    case solid = "Solid"
    case stripes = "Stripes"
    case polkaDots = "Polka Dots"
    case plaid = "Plaid"
    case floral = "Floral"
    
    var id: String { rawValue }
}

@MainActor
final class TextureGenerator {
    static let shared = TextureGenerator()
    
    /// Generates a tileable texture pattern based on the selected type and base color.
    func generateTexture(pattern: OutfitPattern, baseColor: UIColor) -> UIImage {
        let size = CGSize(width: 512, height: 512)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0 // Render at exactly 512x512
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        
        return renderer.image { context in
            let cgContext = context.cgContext
            let rect = CGRect(origin: .zero, size: size)
            
            // Base Background
            baseColor.setFill()
            cgContext.fill(rect)
            
            if pattern == .solid { return }
            
            // Generate Pattern
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
        
        // Vertical thick bands
        darkAccent.setFill()
        for x in stride(from: 0, to: rect.width + spacing, by: spacing) {
            ctx.fill(CGRect(x: x, y: 0, width: thick, height: rect.height))
        }
        
        // Horizontal thick bands (creates dark intersections)
        for y in stride(from: 0, to: rect.height + spacing, by: spacing) {
            ctx.fill(CGRect(x: 0, y: y, width: rect.width, height: thick))
        }
        
        // Vertical thin bands
        lightAccent.setFill()
        for x in stride(from: thick/2, to: rect.width + spacing, by: spacing) {
            ctx.fill(CGRect(x: x - thin/2, y: 0, width: thin, height: rect.height))
        }
        
        // Horizontal thin bands
        for y in stride(from: thick/2, to: rect.height + spacing, by: spacing) {
            ctx.fill(CGRect(x: 0, y: y - thin/2, width: rect.width, height: thin))
        }
    }
    
    private func drawFloral(ctx: CGContext, rect: CGRect) {
        // Procedural abstract floral "noise"
        let count = 80
        for _ in 0..<count {
            let cx = CGFloat.random(in: 0...rect.width)
            let cy = CGFloat.random(in: 0...rect.height)
            let radius = CGFloat.random(in: 8...24)
            
            ctx.saveGState()
            ctx.translateBy(x: cx, y: cy)
            ctx.rotate(by: CGFloat.random(in: 0...(2 * .pi)))
            
            // Draw 5 petals
            for _ in 0..<5 {
                ctx.rotate(by: (2 * .pi) / 5)
                let petal = CGRect(x: 0, y: 0, width: radius, height: radius * 1.5)
                ctx.fillEllipse(in: petal)
            }
            
            // Center
            ctx.setBlendMode(.clear)
            ctx.fillEllipse(in: CGRect(x: -radius/3, y: -radius/3, width: radius/1.5, height: radius/1.5))
            
            ctx.restoreGState()
        }
    }
}

// Extension to detect if a color is light or dark for adaptive texturing
extension UIColor {
    var isLight: Bool {
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        return white >= 0.5
    }
}
