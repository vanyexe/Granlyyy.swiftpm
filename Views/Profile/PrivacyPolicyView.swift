import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {

                    // ── Header ──────────────────────────────────────────
                    VStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.themeGreen.opacity(0.18), Color.themeRose.opacity(0.12)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 90, height: 90)

                            Image(systemName: "lock.shield.fill")
                                .font(.system(size: 40, weight: .light))
                                .foregroundStyle(Color.themeGreen)
                        }
                        .overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                        .shadow(color: .black.opacity(0.05), radius: 10)

                        VStack(spacing: 6) {
                            Text("Privacy Policy")
                                .font(.granlyTitle2)
                                .foregroundStyle(Color.themeText)

                            Text(L10n.t(.legalLastUpdated))
                                .font(.granlyCaption)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(.ultraThinMaterial)
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.top, 40)

                    // ── Intro blurb ──────────────────────────────────────
                    Text("At Granly, your privacy is as sacred as grandma's secret recipe. Here's exactly what we do — and don't do — with your information.")
                        .font(.granlyBody)
                        .foregroundStyle(Color.themeText.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                        .padding(.horizontal, 20)

                    // ── Sections ─────────────────────────────────────────
                    VStack(spacing: 16) {
                        LegalSection(
                            icon: "hand.raised.slash.fill",
                            iconColor: Color.themeRose,
                            title: L10n.t(.privacyDataWeCollect),
                            content: L10n.t(.privacyDataWeCollectBody)
                        )
                        LegalSection(
                            icon: "magnifyingglass.circle.fill",
                            iconColor: Color.themeGold,
                            title: L10n.t(.privacyHowWeUse),
                            content: L10n.t(.privacyHowWeUseBody)
                        )
                        LegalSection(
                            icon: "person.2.fill",
                            iconColor: Color.themeWarm,
                            title: L10n.t(.privacyChildren),
                            content: L10n.t(.privacyChildrenBody)
                        )
                        LegalSection(
                            icon: "internaldrive.fill",
                            iconColor: Color.themeGreen,
                            title: L10n.t(.privacyStorage),
                            content: L10n.t(.privacyStorageBody)
                        )
                        LegalSection(
                            icon: "envelope.fill",
                            iconColor: Color.themeRose,
                            title: L10n.t(.privacyContact),
                            content: L10n.t(.privacyContactBody)
                        )
                    }
                    .padding(.horizontal)

                    // ── Footer ───────────────────────────────────────────
                    VStack(spacing: 4) {
                        Text(L10n.t(.designedWithCare))
                            .font(.granlyCaption)
                            .foregroundStyle(.secondary)
                        Text(L10n.t(.copyright))
                            .font(.granlyCaption)
                            .foregroundStyle(.secondary.opacity(0.7))
                    }
                    .padding(.bottom, 48)
                }
            }
        }
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Shared component used by both legal pages
struct LegalSection: View {
    let icon: String
    let iconColor: Color
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(iconColor)
                    .frame(width: 32, height: 32)
                    .background(iconColor.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                Text(title)
                    .font(.granlyBodyBold)
                    .foregroundStyle(Color.themeText)
            }

            Text(content)
                .font(.granlyBody)
                .lineSpacing(5)
                .foregroundStyle(Color.themeText.opacity(0.8))
        }
        .padding(18)
        .glassCard(cornerRadius: 14)
    }
}
