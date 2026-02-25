import SwiftUI

/// Helper View to display the correct avatar based on settings
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
                        .fill(Color.themeRose.opacity(0.1))
                    Text("👵🏻")
                        .font(.system(size: size * 0.55))
                }
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(Circle().stroke(.white, lineWidth: 3))
    }
}
