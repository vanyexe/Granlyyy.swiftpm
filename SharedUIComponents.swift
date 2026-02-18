import SwiftUI

struct MeshGradientBackground: View {
    @State private var animate = false
    var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.themeBackground
            
            // Warm rose blob
            Circle()
                .fill(Color.themeRose.opacity(0.25))
                .frame(width: 420, height: 420)
                .blur(radius: 90)
                .offset(x: (animate ? 110 : -110) + (scrollOffset * 0.2),
                        y: (animate ? -180 : 180) + (scrollOffset * 0.1))
            
            // Amber/gold blob
            Circle()
                .fill(Color.themeWarm.opacity(0.22))
                .frame(width: 360, height: 360)
                .blur(radius: 80)
                .offset(x: (animate ? -140 : 140) - (scrollOffset * 0.1),
                        y: (animate ? 140 : -140) + (scrollOffset * 0.25))
            
            // Soft peach blob
            Circle()
                .fill(Color.themeGold.opacity(0.18))
                .frame(width: 300, height: 300)
                .blur(radius: 100)
                .offset(x: (animate ? 50 : -50) + (scrollOffset * 0.15),
                        y: (animate ? 100 : -100) - (scrollOffset * 0.05))
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                animate.toggle()
            }
        }
    }
}

// MARK: - Reusable Glass Card Modifier
struct GlassCard: ViewModifier {
    var cornerRadius: CGFloat = 24
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.white.opacity(0.4), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 6)
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 24) -> some View {
        modifier(GlassCard(cornerRadius: cornerRadius))
    }
}
