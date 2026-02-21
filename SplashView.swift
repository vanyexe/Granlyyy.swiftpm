import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool

    @State private var imageScale: CGFloat = 0.88
    @State private var imageOpacity: Double = 0

    var body: some View {
        ZStack {
            // Full-screen splash image — same-to-same as the reference
            Image("granly_splash")
                .resizable()
                .interpolation(.high)
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .scaleEffect(imageScale)
                .opacity(imageOpacity)
        }
        .onAppear {
            // Gentle zoom-in fade
            withAnimation(.easeOut(duration: 0.85)) {
                imageScale = 1.0
                imageOpacity = 1.0
            }

            // Auto-dismiss after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeInOut(duration: 0.55)) {
                    isActive = true
                }
            }
        }
    }
}
