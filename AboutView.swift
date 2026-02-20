import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 16) {
                    Image("AboutIcon") // Placeholder, use system image as fallback
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .background(
                            Circle()
                                .fill(Color.themeWarm.opacity(0.2))
                                .frame(width: 120, height: 120)
                        )
                        .overlay(
                            Image(systemName: "heart.text.square.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(Color.themeRose)
                        )
                    
                    VStack(spacing: 8) {
                        Text("Granly")
                            .font(.granlyTitle)
                            .foregroundStyle(Color.themeText)
                        
                        Text("Version 2.0")
                            .font(.granlySubheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 40)
                
                // Love Letter
                VStack(alignment: .leading, spacing: 16) {
                    Text("Dearest You,")
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                    
                    Text("Granly was built with a simple wish: to bring a little warmth, comfort, and storytelling magic into your daily life. In a world that often moves too fast, we hope Granly offers you a quiet corner to pause, breathe, and feel loved.")
                        .font(.granlyBody)
                        .lineSpacing(6)
                        .foregroundStyle(Color.themeText.opacity(0.8))
                    
                    Text("Whether you need a listening ear, a gentle story, or just a friendly smile, Granly is here for you. Always.")
                        .font(.granlyBody)
                        .lineSpacing(6)
                        .foregroundStyle(Color.themeText.opacity(0.8))
                    
                    Text("With love,\nThe Granly Team 💛")
                        .font(.granlySubheadline)
                        .foregroundStyle(Color.themeRose)
                        .padding(.top, 8)
                }
                .padding(24)
                .glassCard()
                .padding(.horizontal)
                
                // Features
                VStack(alignment: .leading, spacing: 20) {
                    Text("What's New")
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        FeatureRow(icon: "sparkles", color: .yellow, title: "Premium Experience", desc: "A brand new, warm & cozy design.")
                        FeatureRow(icon: "face.smiling", color: .orange, title: "Enhanced Grandma", desc: "More expressions, animations, and love.")
                        FeatureRow(icon: "book.fill", color: .blue, title: "Daily Wisdom", desc: "Fresh advice and quotes every day.")
                        FeatureRow(icon: "heart.fill", color: .red, title: "More Stories", desc: "Over 20 new stories for every mood.")
                    }
                    .padding(20)
                    .glassCard()
                    .padding(.horizontal)
                }
                
                // Credits
                VStack(spacing: 8) {
                    Text("Designed & Developed with ❤️")
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary)
                    Text("© 2026 Granly App")
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary.opacity(0.7))
                }
                .padding(.bottom, 40)
            }
        }
        .background(Color.themeBackground.ignoresSafeArea())
        .navigationTitle("About Granly")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeatureRow: View {
    let icon: String
    let color: Color
    let title: String
    let desc: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.granlyTitle2)
                .foregroundStyle(color)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.granlyHeadline)
                    .foregroundStyle(Color.themeText)
                Text(desc)
                    .font(.granlyCaption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}
