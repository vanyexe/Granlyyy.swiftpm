import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool
    @State private var textAnimation = false
    @State private var grandmaAnimation = false
    
    var body: some View {
        ZStack {
            // Mesh Background
            MeshGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                // 3D Grandma Entry
                GrandmaSceneView(animate: $grandmaAnimation)
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.white.opacity(0.3), lineWidth: 1))
                    .shadow(color: .black.opacity(0.2), radius: 30, x: 0, y: 15)
                    .scaleEffect(grandmaAnimation ? 1 : 0.8)
                    .opacity(grandmaAnimation ? 1 : 0)
                
                VStack(spacing: 10) {
                    Text("Granly")
                        .font(.system(size: 60, weight: .bold, design: .serif))
                        .foregroundStyle(Color.themeText)
                        .shadow(color: .white.opacity(0.5), radius: 10)
                    
                    Text("Always with you.")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .kerning(1.5)
                        .opacity(textAnimation ? 1 : 0)
                        .offset(y: textAnimation ? 0 : 10)
                }
                .blur(radius: textAnimation ? 0 : 5)
                .scaleEffect(textAnimation ? 1 : 0.9)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 1.2, dampingFraction: 0.7).delay(0.3)) {
                grandmaAnimation = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(0.8)) {
                textAnimation = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    self.isActive = true
                }
            }
        }
    }
}




