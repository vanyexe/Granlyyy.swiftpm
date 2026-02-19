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
                            .font(.system(size: 28, weight: .bold, design: .serif))
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
                                    HStack(spacing: 20) {
                                        // Icon
                                        ZStack {
                                            Circle()
                                                .fill(node.isCompleted ? Color.themeGreen : Color.gray.opacity(0.2))
                                                .frame(width: 60, height: 60)
                                                .shadow(color: node.isCompleted ? Color.themeGreen.opacity(0.4) : .clear, radius: 8)
                                            
                                            Image(systemName: node.icon)
                                                .font(.title2)
                                                .foregroundStyle(node.isCompleted ? .white : .gray)
                                        }
                                        
                                        // Text
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(node.title)
                                                .font(.headline)
                                                .foregroundStyle(Color.themeText)
                                            Text(node.description)
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                                .multilineTextAlignment(.leading)
                                        }
                                        Spacer()
                                        
                                        if !node.isCompleted {
                                            Image(systemName: "lock.fill")
                                                .foregroundStyle(.secondary.opacity(0.5))
                                        } else {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundStyle(Color.themeGreen)
                                        }
                                    }
                                    .padding()
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
                    .stroke(color.opacity(0.2), lineWidth: 6)
                    .frame(width: 80, height: 80)
                
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(color, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(-90))
                
                VStack(spacing: 2) {
                    Image(systemName: icon)
                        .font(.body)
                        .foregroundStyle(color)
                    Text(value)
                        .font(.title3.bold())
                        .foregroundStyle(Color.themeText)
                }
            }
            Text(label)
                .font(.caption.bold())
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    GrowthPathView()
}
