import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {

                    // ── Header ───────────────────────────────────────────
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

                        Text("Granly")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.themeText)
                    }
                    .padding(.top, 40)

                    // ── Our Mission ──────────────────────────────────────
                    VStack(alignment: .leading, spacing: 14) {
                        // Section label
                        Label(L10n.t(.ourMission), systemImage: "heart.fill")
                            .font(.granlyHeadline)
                            .foregroundStyle(Color.themeRose)

                        Divider()
                            .background(Color.themeRose.opacity(0.3))

                        // Paragraph 1
                        Text(L10n.t(.missionBody))
                            .font(.granlyBody)
                            .lineSpacing(6)
                            .foregroundStyle(Color.themeText.opacity(0.85))

                        // Paragraph 2
                        Text(L10n.t(.missionBody2))
                            .font(.granlyBody)
                            .lineSpacing(6)
                            .foregroundStyle(Color.themeText.opacity(0.85))

                        // Paragraph 3 — closing sentiment
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.themeGold)
                                .padding(.top, 2)
                            Text(L10n.t(.missionBody3))
                                .font(.granlyBody)
                                .lineSpacing(6)
                                .foregroundStyle(Color.themeText.opacity(0.85))
                                .italic()
                        }
                        .padding(.top, 4)
                    }
                    .padding(20)
                    .glassCard(cornerRadius: 16)
                    .padding(.horizontal)

                    // ── Legal Links ──────────────────────────────────────
                    VStack(spacing: 0) {
                        NavigationLink(destination: PrivacyPolicyView()) {
                            AboutRow(
                                icon: "lock.shield.fill",
                                iconColor: Color.themeGreen,
                                title: L10n.t(.privacyPolicy),
                                hasDivider: true
                            )
                        }
                        .buttonStyle(.plain)

                        NavigationLink(destination: TermsOfServiceView()) {
                            AboutRow(
                                icon: "doc.text.fill",
                                iconColor: Color.themeGold,
                                title: L10n.t(.termsOfService),
                                hasDivider: false
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .glassCard(cornerRadius: 16)
                    .padding(.horizontal)

                    // ── Footer ───────────────────────────────────────────
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
        }
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
