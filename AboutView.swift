import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var lang: LanguageManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // High-End Header
                VStack(spacing: 16) {
                    Image(systemName: "eyeglasses")
                        .font(.system(size: 48, weight: .light))
                        .foregroundStyle(Color.themeRose)
                        .frame(width: 100, height: 100)
                        .background(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.themeRose.opacity(0.15), Color.themeWarm.opacity(0.15)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                        .overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                        .shadow(color: Color.black.opacity(0.05), radius: 10)
                    
                    VStack(spacing: 4) {
                        Text("Granly")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.themeText)
                        
                        Text("Version 2.0")
                            .font(.granlySubheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 40)
                
                // Mission Statement / Overview
                VStack(spacing: 16) {
                    Text(L10n.t(.ourMission))
                        .font(.granlyHeadline)
                        .foregroundStyle(Color.themeText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(L10n.t(.missionBody))
                        .font(.granlyBody)
                        .lineSpacing(6)
                        .foregroundStyle(Color.themeText.opacity(0.8))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(20)
                .glassCard(cornerRadius: 16)
                .padding(.horizontal)
                
                // Links/Resources List
                VStack(spacing: 0) {
                    AboutRow(icon: "star.fill", iconColor: .yellow, title: L10n.t(.rateAppStore), hasDivider: true)
                    AboutRow(icon: "globe", iconColor: .blue, title: L10n.t(.websiteLabel), hasDivider: true)
                    AboutRow(icon: "lock.fill", iconColor: .green, title: L10n.t(.privacyPolicy), hasDivider: true)
                    AboutRow(icon: "doc.text.fill", iconColor: .gray, title: L10n.t(.termsOfService), hasDivider: false)
                }
                .glassCard(cornerRadius: 16)
                .padding(.horizontal)
                
                // Developer / Credits
                VStack(spacing: 6) {
                    Text(L10n.t(.designedWithCare))
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary)
                    Text(L10n.t(.copyright))
                        .font(.granlyCaption)
                        .foregroundStyle(.secondary.opacity(0.7))
                }
                .padding(.bottom, 40)
            }
        }
        .background(Color.themeBackground.ignoresSafeArea())
        .navigationTitle(L10n.t(.aboutGranly))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let hasDivider: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .foregroundStyle(iconColor)
                    .font(.system(size: 18))
                    .frame(width: 24)
                
                Text(title)
                    .font(.granlyBodyBold)
                    .foregroundStyle(Color.themeText)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            
            if hasDivider {
                Divider()
                    .background(Color.white.opacity(0.1))
                    .padding(.leading, 60)
            }
        }
        .contentShape(Rectangle())
    }
}
