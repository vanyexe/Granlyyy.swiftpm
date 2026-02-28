import SwiftUI

struct GrowthPathView: View {
    @StateObject private var tracker = GrowthTrackerManager()
    @State private var showCompletionAlert = false
    @State private var activeNode: GrowthNode?
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {

                    VStack(spacing: 16) {
                        Text(L10n.t(.emotionalGarden))
                            .font(.granlyTitle2)
                            .foregroundStyle(Color.themeText)

                        HStack(spacing: 30) {
                            StatRing(icon: "heart.fill", value: "\(tracker.emotionalScore)", label: L10n.t(.statEnergy), color: Color.themeRose)
                            StatRing(icon: "leaf.fill", value: "\(tracker.completedPaths)", label: L10n.t(.statPaths), color: Color.themeGreen)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                    VStack(spacing: 0) {
                        ForEach(tracker.nodes.indices, id: \.self) { index in
                            let node = tracker.nodes[index]
                            let isLast = index == tracker.nodes.count - 1

                            VStack(spacing: 0) {

                                Button(action: {
                                    if !node.isCompleted {
                                        activeNode = node
                                        showCompletionAlert = true
                                    }
                                }) {
                                    HStack(spacing: 16) {

                                        ZStack {
                                            Circle()
                                                .fill(node.isCompleted ? Color.themeGreen : Color.gray.opacity(0.2))
                                                .frame(width: 48, height: 48)
                                                .shadow(color: node.isCompleted ? Color.themeGreen.opacity(0.4) : .clear, radius: 6)

                                            Image(systemName: node.icon)
                                                .font(.granlyHeadline)
                                                .foregroundStyle(node.isCompleted ? .white : .gray)
                                        }

                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(node.title)
                                                .font(.granlyBodyBold)
                                                .foregroundStyle(Color.themeText)
                                            Text(node.description)
                                                .font(.granlyCaption)
                                                .foregroundStyle(.secondary)
                                                .multilineTextAlignment(.leading)
                                        }
                                        Spacer()

                                        if !node.isCompleted {
                                            Image(systemName: "lock.fill")
                                                .font(.granlySubheadline)
                                                .foregroundStyle(.secondary.opacity(0.5))
                                        } else {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.granlySubheadline)
                                                .foregroundStyle(Color.themeGreen)
                                        }
                                    }
                                    .padding(14)
                                    .glassCard(cornerRadius: 16)
                                }
                                .disabled(node.isCompleted)

                                if !isLast {
                                    Rectangle()
                                        .fill(node.isCompleted ? Color.themeGreen : Color.gray.opacity(0.3))
                                        .frame(width: 4, height: 40)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(L10n.t(.completeReflection), isPresented: $showCompletionAlert, presenting: activeNode) { node in
            Button(L10n.t(.reflectionAckButton)) {
                withAnimation {
                    tracker.completeNode(id: node.id)
                }
            }
            Button(L10n.t(.cancel), role: .cancel) { }
        } message: { node in
            Text(L10n.t(.reflectionMessage))
        }
    }
}

struct StatRing: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(color.opacity(0.2), lineWidth: 5)
                    .frame(width: 64, height: 64)

                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(color, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .frame(width: 64, height: 64)
                    .rotationEffect(.degrees(-90))

                VStack(spacing: 2) {
                    Image(systemName: icon)
                        .font(.granlyCaption)
                        .foregroundStyle(color)
                    Text(value)
                        .font(.granlyBodyBold)
                        .foregroundStyle(Color.themeText)
                }
            }
            Text(label)
                .font(.granlyCaption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    GrowthPathView()
}