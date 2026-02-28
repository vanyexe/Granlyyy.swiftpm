import SwiftUI

@MainActor
struct ProfileAvatarView: View {
    let size: CGFloat
    @AppStorage("profileAvatarType") private var avatarType = "default"
    @AppStorage("profileAvatarValue") private var avatarValue = ""
    @AppStorage("customProfileImageData") private var customImageData: Data = Data()

    var body: some View {
        Group {
            if avatarType == "gallery", let uiImage = UIImage(data: customImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if avatarType == "symbol" {
                ZStack {
                    Circle()
                        .fill(Color.themeRose.opacity(0.15))
                    Image(systemName: avatarValue)
                        .font(.system(size: size * 0.4))
                        .foregroundStyle(Color.themeRose)
                }
            } else {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.themeRose.opacity(0.20), Color.themeWarm.opacity(0.14)],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )
                        )
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: size * 0.58))
                        .foregroundStyle(Color.themeRose.opacity(0.80))
                }
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(Circle().stroke(.white, lineWidth: 3))
    }
}