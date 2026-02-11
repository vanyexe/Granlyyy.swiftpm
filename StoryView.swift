import SwiftUI
import AVFoundation
import SceneKit

struct StoryView: View {
    let mood: Mood
    var storyToLoad: Story? // Optional: If provided, this story is shown instead of fetching by mood
    
    @State private var story: Story?
    @StateObject private var speechManager = SpeechManager()
    @State private var animateAvatar = false
    @ObservedObject private var storyManager = StoryManager.shared
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack {
                // Grandma Avatar Area
                ZStack {
                    Circle()
                        .fill(Color.themeAccent.opacity(0.1))
                        .frame(height: 280)
                    
                    // Try to load the sweet grandma image, fallback to system icon if needed
                    // Since specific file checking is hard in swiftui views without assets, we'll try standard Image
                    // For this environment, we'll assume the user will see the placeholder if the file isn't there.
                    Image("sweet_grandma_avatar") // Ensure this asset exists or use a robust fallback
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .overlay(
                            Circle().stroke(Color.themeAccent, lineWidth: 2)
                        )
                        .scaleEffect(animateAvatar ? 1.05 : 1.0)
                        .animation(animateAvatar ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default, value: animateAvatar)
                }
                .padding(.top, 20)
                
                // Story Content
                ScrollView {
                    VStack(spacing: 20) {
                        if let story = story {
                            Text(story.title)
                                .font(.custom("Baskerville-Bold", size: 28))
                                .foregroundStyle(Color.themeText)
                                .padding(.top)
                            
                            Text(story.content)
                                .font(.custom("Baskerville", size: 20))
                                .lineSpacing(8)
                                .foregroundStyle(Color.themeText.opacity(0.9))
                                .padding()
                                .multilineTextAlignment(.leading) // Better for reading long text
                        } else {
                            ProgressView()
                        }
                    }
                }
                
                // Controls
                HStack(spacing: 40) {
                    // Stop Button
                    Button(action: {
                        speechManager.stop()
                    }) {
                        Image(systemName: "stop.circle.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(Color.red.opacity(0.8))
                    }
                    
                    // Play/Pause Button
                    Button(action: {
                        if speechManager.isSpeaking {
                            speechManager.pause()
                        } else {
                            if let content = story?.content {
                                speechManager.speak(text: content)
                            }
                        }
                    }) {
                        Image(systemName: speechManager.isSpeaking ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(Color.themeAccent)
                    }
                    
                    // Heart/Like Button
                    Button(action: {
                        if let s = story {
                            storyManager.toggleLike(for: s)
                        }
                    }) {
                        Image(systemName: (story != nil && storyManager.isLiked(story: story!)) ? "heart.fill" : "heart")
                            .font(.system(size: 50))
                            .foregroundStyle(Color.pink)
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            if let specificStory = storyToLoad {
                self.story = specificStory
            } else {
                self.story = StoryManager.shared.getStory(for: mood)
            }
        }
        .onChange(of: speechManager.isSpeaking) { isSpeaking in
            animateAvatar = isSpeaking
        }
        .onDisappear {
            speechManager.stop()
        }
    }
}

// Simple SceneKit Wrapper
struct GrandmaSceneView: UIViewRepresentable {
    @Binding var animate: Bool
    
    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.backgroundColor = UIColor.clear
        scnView.autoenablesDefaultLighting = true
        scnView.allowsCameraControl = true // User can rotate grandma
        
        let scene = SCNScene()
        
        // Placeholder 3D Object (a capsule usually represents a person in prototype)
        // In a real app, load: let scene = SCNScene(named: "grandma.usdz")
        let geometry = SCNCapsule(capRadius: 0.5, height: 2.0)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor(Color.themeAccent)
        geometry.materials = [material]
        
        let node = SCNNode(geometry: geometry)
        node.name = "grandmaNode"
        node.position = SCNVector3(0, 0, 0)
        scene.rootNode.addChildNode(node)
        
        // Add basic eyes to make it look like a face
        let eyeGeo = SCNSphere(radius: 0.1)
        eyeGeo.firstMaterial?.diffuse.contents = UIColor.black
        let leftEye = SCNNode(geometry: eyeGeo)
        leftEye.position = SCNVector3(-0.2, 0.5, 0.45)
        node.addChildNode(leftEye)
        
        let rightEye = SCNNode(geometry: eyeGeo)
        rightEye.position = SCNVector3(0.2, 0.5, 0.45)
        node.addChildNode(rightEye)
        
        scnView.scene = scene
        return scnView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Simple animation: gentle bobbing when speaking
        guard let node = uiView.scene?.rootNode.childNode(withName: "grandmaNode", recursively: true) else { return }
        
        if animate {
            if node.action(forKey: "bobbing") == nil {
                let moveUp = SCNAction.moveBy(x: 0, y: 0.1, z: 0, duration: 0.5)
                let moveDown = SCNAction.moveBy(x: 0, y: -0.1, z: 0, duration: 0.5)
                let sequence = SCNAction.sequence([moveUp, moveDown])
                let repeatAction = SCNAction.repeatForever(sequence)
                node.runAction(repeatAction, forKey: "bobbing")
            }
        } else {
            node.removeAction(forKey: "bobbing")
        }
    }
}

@MainActor
class SpeechManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking = false
    @AppStorage("selectedLanguage") var selectedLanguageCode: String = "en-US"
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func speak(text: String) {
        if synthesizer.isPaused {
            synthesizer.continueSpeaking()
            isSpeaking = true
            return
        }
        
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: selectedLanguageCode) // User's selected language
        utterance.rate = 0.45
        utterance.pitchMultiplier = 1.25 // Higher pitch for a "sweeter" grandma voice
        
        synthesizer.speak(utterance)
        isSpeaking = true
    }
    
    func pause() {
        synthesizer.pauseSpeaking(at: .immediate)
        isSpeaking = false
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
    
    // MARK: - Delegate
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        Task { @MainActor in
            isSpeaking = false
        }
    }
    
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in
            isSpeaking = false
        }
    }
}


