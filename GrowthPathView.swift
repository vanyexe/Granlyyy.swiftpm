import SwiftUI

struct GrowthPathView: View {
    @StateObject private var tracker = GrowthTrackerManager()
    @State private var showCompletionAlert = false
    @State private var activeNode: GrowthNode?
    
    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header Stats
                    VStack(spacing: 16) {
                        Text("Your Emotional Garden")
                            .font(.granlyTitle2) // Title -> Title2
                            .foregroundStyle(Color.themeText)
                        
                        HStack(spacing: 30) {
                            StatRing(icon: "heart.fill", value: "\(tracker.emotionalScore)", label: "Energy", color: Color.themeRose)
                            StatRing(icon: "leaf.fill", value: "\(tracker.completedPaths)", label: "Paths", color: Color.themeGreen)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    
                    // The Path
                    VStack(spacing: 0) {
                        ForEach(tracker.nodes.indices, id: \.self) { index in
                            let node = tracker.nodes[index]
                            let isLast = index == tracker.nodes.count - 1
                            
                            VStack(spacing: 0) {
                                // Node
                                Button(action: {
                                    if !node.isCompleted {
                                        activeNode = node
                                        showCompletionAlert = true
                                    }
                                }) {
                                    HStack(spacing: 16) { // 20 -> 16
                                        // Icon
                                        ZStack {
                                            Circle()
                                                .fill(node.isCompleted ? Color.themeGreen : Color.gray.opacity(0.2))
                                                .frame(width: 48, height: 48) // 60 -> 48
                                                .shadow(color: node.isCompleted ? Color.themeGreen.opacity(0.4) : .clear, radius: 6) // 8 -> 6
                                            
                                            Image(systemName: node.icon)
                                                .font(.granlyHeadline) // Title2 -> Headline
                                                .foregroundStyle(node.isCompleted ? .white : .gray)
                                        }
                                        
                                        // Text
                                        VStack(alignment: .leading, spacing: 2) { // 4 -> 2
                                            Text(node.title)
                                                .font(.granlyBodyBold) // Headline -> BodyBold
                                                .foregroundStyle(Color.themeText)
                                            Text(node.description)
                                                .font(.granlyCaption)
                                                .foregroundStyle(.secondary)
                                                .multilineTextAlignment(.leading)
                                        }
                                        Spacer()
                                        
                                        if !node.isCompleted {
                                            Image(systemName: "lock.fill")
                                                .font(.granlySubheadline) // Add slightly smaller lock
                                                .foregroundStyle(.secondary.opacity(0.5))
                                        } else {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.granlySubheadline) // Add slightly smaller check
                                                .foregroundStyle(Color.themeGreen)
                                        }
                                    }
                                    .padding(14) // default padding -> 14
                                    .glassCard(cornerRadius: 16)
                                }
                                .disabled(node.isCompleted)
                                
                                // Connector Line
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
        .alert("Complete Reflection", isPresented: $showCompletionAlert, presenting: activeNode) { node in
            Button("I have reflected on this") {
                withAnimation {
                    tracker.completeNode(id: node.id)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: { node in
            Text("By marking this as complete, you acknowledge you have spent time focusing on: \(node.category).")
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
                    .stroke(color.opacity(0.2), lineWidth: 5) // 6 -> 5
                    .frame(width: 64, height: 64) // 80 -> 64
                
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(color, style: StrokeStyle(lineWidth: 5, lineCap: .round)) // 6 -> 5
                    .frame(width: 64, height: 64) // 80 -> 64
                    .rotationEffect(.degrees(-90))
                
                VStack(spacing: 2) {
                    Image(systemName: icon)
                        .font(.granlyCaption) // Body -> Caption
                        .foregroundStyle(color)
                    Text(value)
                        .font(.granlyBodyBold) // Headline -> BodyBold
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
