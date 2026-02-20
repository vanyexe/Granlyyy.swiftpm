import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool
    @State private var textAnimation = false
    @State private var grandmaAction: GrandmaAction = .idle
    @State private var ringAnimation = false
    @State private var taglineVisible = false
    @StateObject private var settings = GrandmaSettings()
    
    var body: some View {
        ZStack {
            // Warm background
            Color.themeBackground
                .ignoresSafeArea()
            
            // Glow rings
            ForEach(0..<4, id: \.self) { i in
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.themeRose.opacity(0.3 - Double(i) * 0.06),
                                Color.themeGold.opacity(0.2 - Double(i) * 0.04)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                    )
                    .frame(width: CGFloat(140 + i * 50), height: CGFloat(140 + i * 50)) // 180+60i -> 140+50i
                    .scaleEffect(ringAnimation ? 1.1 : 0.8)
                    .opacity(ringAnimation ? 0.8 : 0.2)
                    .animation(
                        .easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true)
                        .delay(Double(i) * 0.3),
                        value: ringAnimation
                    )
            }
            
            VStack(spacing: 36) {
                // 3D Grandma
                GrandmaSceneView(
                    action: $grandmaAction,
                    expression: .constant(.happy),
                    isSpeaking: .constant(false),
                    settings: settings
                )
                .frame(width: 200, height: 200) // 260 -> 200
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [Color.themeRose.opacity(0.5), Color.themeGold.opacity(0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .shadow(color: Color.themeRose.opacity(0.3), radius: 30, x: 0, y: 15)
                .scaleEffect(grandmaAction != .idle ? 1 : 0.7)
                .opacity(grandmaAction != .idle ? 1 : 0)
                
                VStack(spacing: 12) {
                    // Gradient Logo
                    Text("Granly")
                        .font(.granlyTitle2) // Title -> Title2
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.themeRose, Color.themeWarm],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(color: Color.themeRose.opacity(0.3), radius: 10)
                    
                    // Animated tagline
                    Text("Always with you. 💛")
                    .font(.granlyHeadline)
                    .foregroundStyle(.secondary)
                    .kerning(1.5)
                    .opacity(taglineVisible ? 1 : 0)
                    .offset(y: taglineVisible ? 0 : 12)
                }
                .blur(radius: textAnimation ? 0 : 5)
                .scaleEffect(textAnimation ? 1 : 0.9)
            }
        }
        .onAppear {
            ringAnimation = true
            startLoopAnimation()
            
            withAnimation(.easeOut(duration: 1.0).delay(0.8)) {
                textAnimation = true
            }
            
            withAnimation(.easeOut(duration: 0.8).delay(1.4)) {
                taglineVisible = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                 withAnimation(.easeInOut(duration: 0.6)) {
                     self.isActive = true
                 }
             }
        }
    }
    
    private func startLoopAnimation() {
         // Initial pop
         withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
             grandmaAction = .wave
         }
         
         // Cycle actions
         Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
             let actions: [GrandmaAction] = [.love, .celebrate, .wave]
             let next = actions.randomElement() ?? .idle
             Task { @MainActor in
                 withAnimation {
                     self.grandmaAction = next
                 }
             }
         }
    }
}
