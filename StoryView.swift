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
                // Grandma 3D Avatar Area
                GrandmaSceneView(animate: $animateAvatar)
                    .frame(height: 280)
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

// Enhanced 3D Grandma SceneKit View
struct GrandmaSceneView: UIViewRepresentable {
    @Binding var animate: Bool
    
    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.backgroundColor = UIColor.clear
        scnView.autoenablesDefaultLighting = true
        scnView.allowsCameraControl = true // User can rotate grandma
        
        let scene = SCNScene()
        
        // Create a more grandma-like figure
        // Body (rounded shape for warmth)
        let bodyGeometry = SCNCapsule(capRadius: 0.6, height: 1.8)
        let bodyMaterial = SCNMaterial()
        bodyMaterial.diffuse.contents = UIColor(red: 0.95, green: 0.76, blue: 0.78, alpha: 1.0) // Warm pink dress
        bodyGeometry.materials = [bodyMaterial]
        
        let bodyNode = SCNNode(geometry: bodyGeometry)
        bodyNode.name = "grandmaBody"
        bodyNode.position = SCNVector3(0, 0, 0)
        scene.rootNode.addChildNode(bodyNode)
        
        // Head (sphere for face)
        let headGeometry = SCNSphere(radius: 0.5)
        let headMaterial = SCNMaterial()
        headMaterial.diffuse.contents = UIColor(red: 0.98, green: 0.92, blue: 0.84, alpha: 1.0) // Skin tone
        headGeometry.materials = [headMaterial]
        
        let headNode = SCNNode(geometry: headGeometry)
        headNode.name = "grandmaHead"
        headNode.position = SCNVector3(0, 1.3, 0)
        bodyNode.addChildNode(headNode)
        
        // Eyes (larger, warmer)
        let eyeGeometry = SCNSphere(radius: 0.12)
        eyeGeometry.firstMaterial?.diffuse.contents = UIColor.black
        
        let leftEye = SCNNode(geometry: eyeGeometry)
        leftEye.position = SCNVector3(-0.18, 0.1, 0.4)
        headNode.addChildNode(leftEye)
        
        let rightEye = SCNNode(geometry: eyeGeometry)
        rightEye.position = SCNVector3(0.18, 0.1, 0.4)
        headNode.addChildNode(rightEye)
        
        // Smile (small sphere for nose)
        let noseGeometry = SCNSphere(radius: 0.08)
        noseGeometry.firstMaterial?.diffuse.contents = UIColor(red: 0.95, green: 0.85, blue: 0.75, alpha: 1.0)
        let noseNode = SCNNode(geometry: noseGeometry)
        noseNode.position = SCNVector3(0, -0.05, 0.45)
        headNode.addChildNode(noseNode)
        
        // Hair (gray sphere on top)
        let hairGeometry = SCNSphere(radius: 0.4)
        let hairMaterial = SCNMaterial()
        hairMaterial.diffuse.contents = UIColor.lightGray
        hairGeometry.materials = [hairMaterial]
        
        let hairNode = SCNNode(geometry: hairGeometry)
        hairNode.position = SCNVector3(0, 0.4, 0)
        headNode.addChildNode(hairNode)
        
        // Arms (simple cylinders)
        let armGeometry = SCNCylinder(radius: 0.15, height: 1.0)
        let armMaterial = SCNMaterial()
        armMaterial.diffuse.contents = UIColor(red: 0.98, green: 0.92, blue: 0.84, alpha: 1.0)
        armGeometry.materials = [armMaterial]
        
        let leftArm = SCNNode(geometry: armGeometry)
        leftArm.position = SCNVector3(-0.7, 0.3, 0)
        leftArm.eulerAngles = SCNVector3(0, 0, 0.3)
        bodyNode.addChildNode(leftArm)
        
        let rightArm = SCNNode(geometry: armGeometry)
        rightArm.position = SCNVector3(0.7, 0.3, 0)
        rightArm.eulerAngles = SCNVector3(0, 0, -0.3)
        bodyNode.addChildNode(rightArm)
        
        // Add ambient lighting for warmth
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor(white: 0.8, alpha: 1.0)
        let ambientNode = SCNNode()
        ambientNode.light = ambientLight
        scene.rootNode.addChildNode(ambientNode)
        
        // Add directional light
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.color = UIColor(white: 0.6, alpha: 1.0)
        let lightNode = SCNNode()
        lightNode.light = directionalLight
        lightNode.position = SCNVector3(2, 3, 2)
        scene.rootNode.addChildNode(lightNode)
        
        scnView.scene = scene
        return scnView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Enhanced animation: gentle bobbing and head nodding when speaking
        guard let bodyNode = uiView.scene?.rootNode.childNode(withName: "grandmaBody", recursively: true),
              let headNode = bodyNode.childNode(withName: "grandmaHead", recursively: false) else { return }
        
        if animate {
            // Body bobbing animation
            if bodyNode.action(forKey: "bobbing") == nil {
                let moveUp = SCNAction.moveBy(x: 0, y: 0.08, z: 0, duration: 0.6)
                let moveDown = SCNAction.moveBy(x: 0, y: -0.08, z: 0, duration: 0.6)
                let sequence = SCNAction.sequence([moveUp, moveDown])
                let repeatAction = SCNAction.repeatForever(sequence)
                bodyNode.runAction(repeatAction, forKey: "bobbing")
            }
            
            // Head nodding animation
            if headNode.action(forKey: "nodding") == nil {
                let nod = SCNAction.rotateBy(x: 0.1, y: 0, z: 0, duration: 0.8)
                let nodBack = SCNAction.rotateBy(x: -0.1, y: 0, z: 0, duration: 0.8)
                let sequence = SCNAction.sequence([nod, nodBack])
                let repeatAction = SCNAction.repeatForever(sequence)
                headNode.runAction(repeatAction, forKey: "nodding")
            }
        } else {
            bodyNode.removeAction(forKey: "bobbing")
            headNode.removeAction(forKey: "nodding")
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
        
        // Select the best grandmotherly voice for the language
        let voice = selectGrandmaVoice(for: selectedLanguageCode)
        utterance.voice = voice
        
        // Adjust parameters for a sweet, warm grandma voice
        utterance.rate = 0.42 // Slower, gentle pace for storytelling
        utterance.pitchMultiplier = 1.28 // Higher pitch for warmth and sweetness
        utterance.volume = 0.9 // Slightly softer volume
        utterance.preUtteranceDelay = 0.2 // Small pause before starting
        utterance.postUtteranceDelay = 0.1 // Small pause after finishing
        
        synthesizer.speak(utterance)
        isSpeaking = true
    }
    
    // Select the best grandmotherly voice for each language
    private func selectGrandmaVoice(for languageCode: String) -> AVSpeechSynthesisVoice? {
        // Try to find specific high-quality voices first
        let preferredVoices: [String: [String]] = [
            "en-US": ["Samantha", "Karen", "Victoria"], // Warm female voices
            "en-GB": ["Kate", "Serena"],
            "es-ES": ["Monica", "Paulina"],
            "fr-FR": ["Amelie", "Audrey"],
            "de-DE": ["Anna", "Petra"],
            "hi-IN": ["Lekha"]
        ]
        
        // Get the base language (e.g., "en" from "en-US")
        let baseLanguage = String(languageCode.prefix(2))
        
        // Try preferred voices for this language
        if let voiceNames = preferredVoices[languageCode] {
            for voiceName in voiceNames {
                if let voice = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.\(languageCode).\(voiceName)") {
                    return voice
                }
                // Try enhanced quality
                if let voice = AVSpeechSynthesisVoice(identifier: "com.apple.voice.enhanced.\(languageCode).\(voiceName)") {
                    return voice
                }
            }
        }
        
        // Fallback: Find any female voice for the language
        let availableVoices = AVSpeechSynthesisVoice.speechVoices()
        let femaleVoice = availableVoices.first { voice in
            voice.language.hasPrefix(baseLanguage) && 
            (voice.name.contains("Female") || voice.gender == .female)
        }
        
        if let voice = femaleVoice {
            return voice
        }
        
        // Final fallback: Default voice for the language
        return AVSpeechSynthesisVoice(language: languageCode)
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


