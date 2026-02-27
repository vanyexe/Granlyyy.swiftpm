import SwiftUI

struct TermsOfServiceView: View {
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
                                        colors: [Color.themeWarm.opacity(0.20), Color.themeGold.opacity(0.14)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 90, height: 90)

                            Image(systemName: "doc.text.fill")
                                .font(.system(size: 38, weight: .light))
                                .foregroundStyle(Color.themeGold)
                        }
                        .overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                        .shadow(color: .black.opacity(0.05), radius: 10)

                        VStack(spacing: 6) {
                            Text("Terms of Service")
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
                    Text("These terms govern your use of Granly. Please take a moment to read them — they're written with the same warmth and care as everything else in this app.")
                        .font(.granlyBody)
                        .foregroundStyle(Color.themeText.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                        .padding(.horizontal, 20)

                    // ── Sections ─────────────────────────────────────────
                    VStack(spacing: 16) {
                        LegalSection(
                            icon: "checkmark.seal.fill",
                            iconColor: Color.themeGreen,
                            title: L10n.t(.termsAcceptance),
                            content: L10n.t(.termsAcceptanceBody)
                        )
                        LegalSection(
                            icon: "iphone",
                            iconColor: Color.themeRose,
                            title: L10n.t(.termsUse),
                            content: L10n.t(.termsUseBody)
                        )
                        LegalSection(
                            icon: "c.circle.fill",
                            iconColor: Color.themeGold,
                            title: L10n.t(.termsIP),
                            content: L10n.t(.termsIPBody)
                        )
                        LegalSection(
                            icon: "exclamationmark.triangle.fill",
                            iconColor: Color.themeWarm,
                            title: L10n.t(.termsDisclaimer),
                            content: L10n.t(.termsDisclaimerBody)
                        )
                        LegalSection(
                            icon: "arrow.triangle.2.circlepath",
                            iconColor: Color.themeRose,
                            title: L10n.t(.termsChanges),
                            content: L10n.t(.termsChangesBody)
                        )
                        LegalSection(
                            icon: "envelope.fill",
                            iconColor: Color.themeGold,
                            title: L10n.t(.termsContact),
                            content: L10n.t(.termsContactBody)
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
        .navigationTitle("Terms of Service")
        .navigationBarTitleDisplayMode(.inline)
    }
}
