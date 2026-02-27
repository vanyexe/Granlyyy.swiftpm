import SwiftUI

// MARK: - Activities List Screen

struct CozyActivitiesView: View {
    @EnvironmentObject var lang: LanguageManager
    private var activities: [CozyActivity] {
        CozyActivityData.activities(for: lang.selectedLanguage)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBackground.ignoresSafeArea()
                MeshGradientBackground().ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 28) {

                        // ── Hero Header ─────────────────────────────
                        VStack(alignment: .leading, spacing: 6) {
                            Text(L10n.t(.cozyActivities))
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.themeText)
                            Text(L10n.t(.cozyActivitiesSubtitle))
                                .font(.granlySubheadline)
                                .foregroundStyle(Color.themeRose)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                        // ── Activity Grid ────────────────────────────
                        LazyVGrid(
                            columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)],
                            spacing: 12
                        ) {
                            ForEach(Array(activities.enumerated()), id: \.element.id) { i, activity in
                                NavigationLink(destination: ActivityPlayerView(activity: activity)) {
                                    CozyActivityCard(activity: activity, index: i)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }
}

// MARK: - Activity Card

struct CozyActivityCard: View {
    let activity: CozyActivity
    let index: Int
    @State private var appear = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Gradient top band
            ZStack {
                LinearGradient(
                    colors: [activity.color.opacity(0.85), activity.color.opacity(0.5)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .frame(height: 88)

                // Decorative circle
                Circle()
                    .fill(.white.opacity(0.10))
                    .frame(width: 70, height: 70)
                    .offset(x: 30, y: -20)

                Image(systemName: activity.iconName)
                    .font(.system(size: 28, weight: .light))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.15), radius: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(14)
            }
            .clipShape(CardTopShape(
                topLeadingRadius: 16, bottomLeadingRadius: 0,
                bottomTrailingRadius: 0, topTrailingRadius: 16
            ))

            // Info band
            VStack(alignment: .leading, spacing: 4) {
                Text(activity.title)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.themeText)
                    .lineLimit(1)

                HStack(spacing: 3) {
                    Image(systemName: "clock")
                        .font(.system(size: 9))
                    Text(activity.duration)
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                    Text("·")
                        .font(.system(size: 10))
                    Text("\(activity.steps.count) steps")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                }
                .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.themeCard)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: activity.color.opacity(0.20), radius: 8, x: 0, y: 4)
        .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
        .scaleEffect(appear ? 1 : 0.92)
        .opacity(appear ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.75).delay(Double(index) * 0.05), value: appear)
        .onAppear { appear = true }
    }
}

// MARK: - Immersive Activity Player

struct ActivityPlayerView: View {
    let activity: CozyActivity
    @Environment(\.dismiss) private var dismiss

    @State private var currentStep = 0
    @State private var isComplete = false
    @State private var showCelebration = false
    @State private var stepAppear = false
    @State private var visualPulse = false

    private var totalSteps: Int { activity.steps.count }
    private var progress: Double { Double(currentStep) / Double(totalSteps) }

    var body: some View {
        ZStack {
            // ── Cinematic background ─────────────────────────
            activityBackground

            // ── Main content ─────────────────────────────────
            VStack(spacing: 0) {
                topBar
                    .padding(.top, 4)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Animated visual hero
                        activityVisual
                            .padding(.top, 8)

                        // Progress bar
                        progressTracker
                            .padding(.horizontal, 24)

                        // Step content card
                        if !isComplete {
                            stepCard
                                .padding(.horizontal, 16)
                        } else {
                            completionCard
                                .padding(.horizontal, 16)
                        }

                        // Navigation buttons
                        if !isComplete {
                            navigationButtons
                                .padding(.horizontal, 24)
                        }

                        // Grandma tip
                        if !isComplete {
                            grandmaTipCard
                                .padding(.horizontal, 16)
                        }
                    }
                    .padding(.bottom, 48)
                }
            }

            // ── Celebration overlay ──────────────────────────
            if showCelebration {
                celebrationOverlay
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                visualPulse = true
            }
            triggerStepAppear()
        }
    }

    // MARK: Background
    private var activityBackground: some View {
        ZStack {
            activity.color.opacity(0.12).ignoresSafeArea()
            LinearGradient(
                colors: [
                    activity.color.opacity(0.25),
                    Color.themeBackground,
                    Color.themeBackground
                ],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }

    // MARK: Top Bar
    private var topBar: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.themeText)
                    .frame(width: 44, height: 44)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }

            Spacer()

            VStack(spacing: 2) {
                Text(activity.title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.themeText)
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 11))
                    Text(activity.duration)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                }
                .foregroundStyle(.secondary)
            }

            Spacer()

            // Category badge
            Text(activity.category)
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundStyle(activity.color)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(activity.color.opacity(0.12))
                .clipShape(Capsule())
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }

    // MARK: Animated Visual Hero
    private var activityVisual: some View {
        ZStack {
            // Outer glow ring
            Circle()
                .stroke(activity.color.opacity(visualPulse ? 0.25 : 0.10), lineWidth: 28)
                .frame(width: 180, height: 180)
                .scaleEffect(visualPulse ? 1.06 : 0.96)
                .animation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: visualPulse)

            // Mid ring
            Circle()
                .stroke(activity.color.opacity(visualPulse ? 0.35 : 0.15), lineWidth: 14)
                .frame(width: 148, height: 148)
                .scaleEffect(visualPulse ? 1.04 : 0.98)
                .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: visualPulse)

            // Core circle
            Circle()
                .fill(LinearGradient(
                    colors: [activity.color.opacity(0.88), activity.color.opacity(0.60)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                ))
                .frame(width: 118, height: 118)
                .shadow(color: activity.color.opacity(0.40), radius: 16, x: 0, y: 8)
                .scaleEffect(visualPulse ? 1.03 : 0.98)
                .animation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true), value: visualPulse)

            // Icon
            Image(systemName: activity.iconName)
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.12), radius: 4)
                .rotationEffect(.degrees(visualPulse ? 2 : -2))
                .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: visualPulse)
        }
        .padding(.vertical, 8)
    }

    // MARK: Progress Tracker
    private var progressTracker: some View {
        VStack(spacing: 8) {
            // Step label
            HStack(alignment: .bottom) {
                Text(isComplete ? "Complete!" : "Step \(currentStep + 1) of \(totalSteps)")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(activity.color)
                Spacer()
                Text(isComplete ? "100%" : "\(Int(progress * 100))%")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
            }

            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(activity.color.opacity(0.14))
                        .frame(height: 6)

                    Capsule()
                        .fill(LinearGradient(
                            colors: [activity.color, activity.color.opacity(0.70)],
                            startPoint: .leading, endPoint: .trailing
                        ))
                        .frame(
                            width: isComplete
                                ? geo.size.width
                                : max(0, geo.size.width * CGFloat(progress)),
                            height: 6
                        )
                        .animation(.spring(response: 0.5, dampingFraction: 0.75), value: currentStep)
                }
            }
            .frame(height: 6)

            // Step dots
            HStack(spacing: 8) {
                ForEach(0..<totalSteps, id: \.self) { i in
                    Circle()
                        .fill(i < currentStep || isComplete
                              ? activity.color
                              : i == currentStep
                              ? activity.color.opacity(0.6)
                              : activity.color.opacity(0.18))
                        .frame(width: i == currentStep && !isComplete ? 12 : 8,
                               height: i == currentStep && !isComplete ? 12 : 8)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: currentStep)
                }
                Spacer()
            }
        }
    }

    // MARK: Step Card
    private var stepCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Step number badge
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(activity.color)
                        .frame(width: 36, height: 36)
                    Text("\(currentStep + 1)")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }

                Text("Current Step")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(activity.color)

                Spacer()

                // Breathing indicator dot
                Circle()
                    .fill(activity.color)
                    .frame(width: 10, height: 10)
                    .scaleEffect(visualPulse ? 1.4 : 0.8)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: visualPulse)
            }

            // Instruction text
            Text(activity.steps[currentStep])
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundStyle(Color.themeText)
                .lineSpacing(6)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(stepAppear ? 1 : 0)
                .offset(y: stepAppear ? 0 : 12)
                .animation(.spring(response: 0.5, dampingFraction: 0.8), value: stepAppear)
        }
        .padding(24)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(activity.color.opacity(0.20), lineWidth: 1)
        )
        .shadow(color: activity.color.opacity(0.10), radius: 12, x: 0, y: 6)
    }

    // MARK: Navigation Buttons
    private var navigationButtons: some View {
        HStack(spacing: 16) {
            // Back button
            if currentStep > 0 {
                Button(action: previousStep) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Back")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                    .foregroundStyle(activity.color)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(activity.color.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }

            // Next / Complete button
            Button(action: nextStep) {
                HStack(spacing: 8) {
                    Text(currentStep == totalSteps - 1 ? "Complete" : "Next Step")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                    Image(systemName: currentStep == totalSteps - 1 ? "checkmark" : "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(activity.color)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: activity.color.opacity(0.35), radius: 8, x: 0, y: 4)
            }
        }
    }

    // MARK: Grandma Tip Card
    private var grandmaTipCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: "quote.opening")
                    .font(.system(size: 18))
                    .foregroundStyle(activity.color)
                Text("Grandma's Heart")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.themeText)
            }

            Text(activity.grandmaTip)
                .font(.system(size: 16, weight: .medium, design: .rounded).italic())
                .lineSpacing(6)
                .foregroundStyle(Color.themeText.opacity(0.85))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(18)
        .background(activity.color.opacity(0.07))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(activity.color.opacity(0.15), lineWidth: 1)
        )
    }

    // MARK: Completion Card
    private var completionCard: some View {
        VStack(spacing: 20) {
            // Trophy icon
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [activity.color.opacity(0.90), activity.color.opacity(0.60)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    ))
                    .frame(width: 72, height: 72)
                    .shadow(color: activity.color.opacity(0.40), radius: 14)
                Image(systemName: "checkmark")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)
            }

            VStack(spacing: 8) {
                Text("Activity Complete!")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.themeText)
                Text("You've completed all \(totalSteps) steps of \(activity.title). Well done.")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }

            // Restart button
            Button(action: restart) {
                HStack(spacing: 6) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 12, weight: .semibold))
                    Text("Try Again")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                .foregroundStyle(activity.color)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(activity.color.opacity(0.12))
                .clipShape(Capsule())
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(activity.color.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: activity.color.opacity(0.12), radius: 16, x: 0, y: 8)
    }

    // MARK: Celebration Overlay
    private var celebrationOverlay: some View {
        ZStack {
            Color.black.opacity(0.35)
                .ignoresSafeArea()
                .onTapGesture { withAnimation(.spring()) { showCelebration = false } }

            VStack(spacing: 20) {
                // Animated sparkle icons
                ZStack {
                    let icons = ["sparkle","star","sparkles","leaf","sun.min","moon.stars"]
                    ForEach(0..<6, id: \.self) { i in
                        Image(systemName: icons[i])
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(activity.color.opacity(0.70))
                            .offset(
                                x: CGFloat([-60,-30,0,30,60,0][i]),
                                y: CGFloat([-40,-60,-30,-50,-35,-65][i])
                            )
                            .scaleEffect(showCelebration ? 1 : 0)
                            .animation(
                                .spring(response: 0.5, dampingFraction: 0.6)
                                    .delay(Double(i) * 0.08),
                                value: showCelebration
                            )
                    }

                    Circle()
                        .fill(LinearGradient(
                            colors: [activity.color, activity.color.opacity(0.70)],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        ))
                        .frame(width: 88, height: 88)
                        .overlay(
                            Image(systemName: "checkmark")
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundStyle(.white)
                        )
                        .shadow(color: activity.color.opacity(0.50), radius: 20)
                        .scaleEffect(showCelebration ? 1 : 0.2)
                        .animation(.spring(response: 0.6, dampingFraction: 0.6), value: showCelebration)
                }
                .frame(height: 100)
                .padding(.top, 20)

                Text("Activity Complete")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("\(activity.title) finished.\nWell done — Grandma is proud of you.")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)

                Button(action: { withAnimation(.spring()) { showCelebration = false } }) {
                    HStack(spacing: 6) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 13))
                        Text("Wonderful")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(activity.color)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.top, 4)
            }
            .padding(28)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            .padding(.horizontal, 24)
            .scaleEffect(showCelebration ? 1 : 0.8)
            .opacity(showCelebration ? 1 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.75), value: showCelebration)
        }
    }

    // MARK: Actions
    private func nextStep() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        stepAppear = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            if currentStep < totalSteps - 1 {
                currentStep += 1
                triggerStepAppear()
            } else {
                isComplete = true
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation { showCelebration = true }
                }
            }
        }
    }

    private func previousStep() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        stepAppear = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            if currentStep > 0 {
                currentStep -= 1
                triggerStepAppear()
            }
        }
    }

    private func restart() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        withAnimation(.spring()) {
            currentStep = 0
            isComplete = false
        }
        triggerStepAppear()
    }

    private func triggerStepAppear() {
        stepAppear = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            withAnimation { stepAppear = true }
        }
    }
}

// MARK: - Helpers

private struct CardTopShape: Shape {
    var topLeadingRadius: CGFloat = 0
    var bottomLeadingRadius: CGFloat = 0
    var bottomTrailingRadius: CGFloat = 0
    var topTrailingRadius: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        var p = Path()
        let tl = min(topLeadingRadius, min(rect.width, rect.height) / 2)
        let tr = min(topTrailingRadius, min(rect.width, rect.height) / 2)
        let bl = min(bottomLeadingRadius, min(rect.width, rect.height) / 2)
        let br = min(bottomTrailingRadius, min(rect.width, rect.height) / 2)
        p.move(to: CGPoint(x: rect.minX + tl, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX - tr, y: rect.minY))
        p.addArc(center: CGPoint(x: rect.maxX - tr, y: rect.minY + tr), radius: tr, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - br))
        p.addArc(center: CGPoint(x: rect.maxX - br, y: rect.maxY - br), radius: br, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        p.addLine(to: CGPoint(x: rect.minX + bl, y: rect.maxY))
        p.addArc(center: CGPoint(x: rect.minX + bl, y: rect.maxY - bl), radius: bl, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY + tl))
        p.addArc(center: CGPoint(x: rect.minX + tl, y: rect.minY + tl), radius: tl, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        p.closeSubpath()
        return p
    }
}
