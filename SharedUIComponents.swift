import SwiftUI

struct MeshGradientBackground: View {
    @State private var animate = false
    var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.themeBackground
            
            // Dynamic moving blobs with parallax
            Circle()
                .fill(Color.themeAccent.opacity(0.3))
                .frame(width: 400, height: 400)
                .blur(radius: 80)
                .offset(x: (animate ? 100 : -100) + (scrollOffset * 0.2), 
                        y: (animate ? -200 : 200) + (scrollOffset * 0.1))
            
            Circle()
                .fill(Color.blue.opacity(0.15))
                .frame(width: 350, height: 350)
                .blur(radius: 70)
                .offset(x: (animate ? -150 : 150) - (scrollOffset * 0.1), 
                        y: (animate ? 150 : -150) + (scrollOffset * 0.25))
            
            Circle()
                .fill(Color.purple.opacity(0.2))
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

