import SwiftUI
import AVFoundation
@preconcurrency import SceneKit

struct StoryView: View {
    let mood: Mood
    var storyToLoad: Story?
    @State private var story: Story?
    @StateObject private var speechManager = SpeechManager()
    @State private var animateAvatar = false
    @ObservedObject private var storyManager = StoryManager.shared
    
    // Spotify-style colors
    private var primaryColor: Color { mood.baseColor }
    private var secondaryColor: Color { .black }
    
    var body: some View {
        ZStack {
            // Immersive Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [primaryColor.opacity(0.8), secondaryColor.opacity(0.95), secondaryColor]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header: Spotify-style "Now Telling"
                HStack {
                    Button(action: { /* Dismiss if needed */ }) {
                        Image(systemName: "chevron.down")
                            .font(.title3.bold())
                    }
                    Spacer()
                    VStack(spacing: 2) {
                        Text("TELLING FROM")
                            .font(.caption2.bold())
                            .kerning(1)
                            .opacity(0.7)
                        Text(mood.name.uppercased())
                            .font(.caption.bold())
                    }
                    Spacer()
                    Image(systemName: "ellipsis")
                        .font(.title3.bold())
                }
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Grandma "Album Art"
                ZStack {
                    Circle()
                        .fill(primaryColor.opacity(0.3))
                        .blur(radius: 40)
                    
                    GrandmaSceneView(animate: $animateAvatar)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.white.opacity(0.1), lineWidth: 1))
                        .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
                }
                .frame(height: 220)
                .padding(.vertical, 20)
                
                // Lyrics View (Story Content)
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 18) {
                            if let story = story {
                                let lines = splitToLines(story.content)
                                
                                Text(story.title)
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 20)
                                    .padding(.horizontal)
                                
                                ForEach(Array(lines.enumerated()), id: \.offset) { index, line in
                                    let isActive = isLineActive(index: index, lines: lines)
                                    
                                    Text(line)
                                        .font(.system(size: 26, weight: .bold))
                                        .foregroundStyle(isActive ? .white : .white.opacity(0.35))
                                        .padding(.horizontal)
                                        .multilineTextAlignment(.leading)
                                        .scaleEffect(isActive ? 1.02 : 1.0, anchor: .leading)
                                        .id(index)
                                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isActive)
                                }
                            } else {
                                ProgressView().tint(.white)
                            }
                        }
                        .padding(.bottom, 40)
                    }
                    .onChange(of: speechManager.spokenRange) { range in
                        guard let range = range, let story = story else { return }
                        let lines = splitToLines(story.content)
                        if let index = activeLineIndex(for: range, in: lines) {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                proxy.scrollTo(index, anchor: .center)
                            }
                        }
                    }
                }
                
                // Media Controls (Spotify-style)
                VStack(spacing: 20) {
                    // Progress Bar
                    VStack(spacing: 8) {
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(.white.opacity(0.2))
                                .frame(height: 4)
                            
                            Capsule()
                                .fill(.white)
                                .frame(width: progressWidth(totalWidth: UIScreen.main.bounds.width - 40), height: 4)
                        }
                        
                        HStack {
                            Text(formatProgress())
                            Spacer()
                            Text(formatDuration())
                        }
                        .font(.caption2.monospacedDigit())
                        .foregroundStyle(.white.opacity(0.6))
                    }
                    .padding(.horizontal)
                    
                    // Buttons
                    HStack(spacing: 0) {
                        Button(action: {}) {
                            Image(systemName: "shuffle")
                                .font(.title3)
                                .foregroundStyle(primaryColor)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button(action: {}) {
                            Image(systemName: "backward.end.fill")
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button(action: {
                            if speechManager.isSpeaking { 
                                speechManager.pause()
                                animateAvatar = false
                            } else { 
                                if let c = story?.content { 
                                    speechManager.speak(text: c)
                                    animateAvatar = true
                                } 
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 70, height: 70)
                                Image(systemName: speechManager.isSpeaking ? "pause.fill" : "play.fill")
                                    .font(.title.bold())
                                    .foregroundStyle(.black)
                                    .offset(x: speechManager.isSpeaking ? 0 : 2)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button(action: { speechManager.stop() }) {
                            Image(systemName: "forward.end.fill")
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button(action: { if let s = story { storyManager.toggleLike(for: s) } }) {
                            Image(systemName: (story != nil && storyManager.isLiked(story: story!)) ? "heart.fill" : "heart")
                                .font(.title3)
                                .foregroundStyle((story != nil && storyManager.isLiked(story: story!)) ? .green : .white)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
                }
                .padding(.top, 10)
                .background(
                    secondaryColor.opacity(0.8)
                        .blur(radius: 20)
                        .ignoresSafeArea()
                )
            }
        }
        .onAppear {
            if let s = storyToLoad { 
                story = s 
            } else { 
                story = StoryManager.shared.getStory(for: mood) 
            }
        }
        .onChange(of: speechManager.isSpeaking) { animateAvatar = $0 }
        .onDisappear { speechManager.stop() }
    }
    
    // MARK: - Helpers
    
    private func splitToLines(_ content: String) -> [String] {
        // Splitting by sentences or specific punctuation for better line-by-line karaoke
        content.components(separatedBy: CharacterSet(charactersIn: ".!?\n"))
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
    private func activeLineIndex(for range: NSRange, in lines: [String]) -> Int? {
        // Find which line contains the current range location
        guard let story = story else { return nil }
        var currentOffset = 0
        for (index, line) in lines.enumerated() {
            // Find the line in the original content to get accurate offset
            if let lineRange = story.content.range(of: line, range: story.content.index(story.content.startIndex, offsetBy: currentOffset)..<story.content.endIndex) {
                let start = story.content.distance(from: story.content.startIndex, to: lineRange.lowerBound)
                let end = story.content.distance(from: story.content.startIndex, to: lineRange.upperBound)
                
                if range.location >= start && range.location <= end {
                    return index
                }
                currentOffset = end
            }
        }
        return nil
    }
    
    private func isLineActive(index: Int, lines: [String]) -> Bool {
        guard let range = speechManager.spokenRange else { return false }
        return activeLineIndex(for: range, in: lines) == index
    }
    
    // Spotify-style progress helpers
    private func progressWidth(totalWidth: CGFloat) -> CGFloat {
        guard let range = speechManager.spokenRange, let total = story?.content.count, total > 0 else { return 0 }
        return CGFloat(range.location) / CGFloat(total) * totalWidth
    }
    
    private func formatProgress() -> String {
        guard let range = speechManager.spokenRange else { return "0:00" }
        // Simple heuristic: 15 chars per second for storytelling speed
        let seconds = range.location / 15
        return String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
    
    private func formatDuration() -> String {
        guard let total = story?.content.count else { return "0:00" }
        let seconds = total / 15
        return String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
}


// MARK: - Enhanced Grandma 3D View
struct GrandmaSceneView: UIViewRepresentable {
    @Binding var animate: Bool
    
    class Coordinator: @unchecked Sendable {
        var scene: SCNScene?
        var gestureTimer: Timer?
        var gestureIdx = 0
        var active = false
    }
    
    func makeCoordinator() -> Coordinator { Coordinator() }
    
    func makeUIView(context: Context) -> SCNView {
        let v = SCNView()
        v.backgroundColor = .clear
        v.autoenablesDefaultLighting = false
        v.allowsCameraControl = true
        v.antialiasingMode = .multisampling4X
        let scene = SCNScene()
        scene.background.contents = UIColor.clear
        let root = SCNNode(); root.name = "root"
        scene.rootNode.addChildNode(root)
        buildGrandma(root)
        addLights(scene)
        addCamera(scene)
        idleAnims(root)
        v.scene = scene
        context.coordinator.scene = scene
        return v
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        guard let s = context.coordinator.scene,
              let r = s.rootNode.childNode(withName: "root", recursively: false) else { return }
        if animate { startAnims(r, context.coordinator) }
        else { stopAnims(r, context.coordinator) }
    }
    
    // MARK: - Skin/cloth materials
    private var skinColor: UIColor { UIColor(red: 0.96, green: 0.87, blue: 0.78, alpha: 1) }
    private var cardiganColor: UIColor { UIColor(red: 0.70, green: 0.65, blue: 0.82, alpha: 1) } // Lavender
    private var blouseColor: UIColor { UIColor(red: 0.92, green: 0.90, blue: 0.95, alpha: 1) } // Soft lilac-cream
    private var hairColor: UIColor { UIColor(red: 0.88, green: 0.88, blue: 0.92, alpha: 1) } // Silver
    private var hairHighlight: UIColor { UIColor(red: 0.80, green: 0.78, blue: 0.90, alpha: 1) } // Lavender highlight
    private var lipColor: UIColor { UIColor(red: 0.82, green: 0.52, blue: 0.50, alpha: 1) }
    private var blushColor: UIColor { UIColor(red: 0.95, green: 0.72, blue: 0.70, alpha: 0.45) }
    private var glassesColor: UIColor { UIColor(red: 0.45, green: 0.42, blue: 0.55, alpha: 1) } // Purple-brown
    
    private func mat(_ c: UIColor, rough: CGFloat = 0.6) -> SCNMaterial {
        let m = SCNMaterial(); m.diffuse.contents = c; m.roughness.contents = rough; return m
    }
    
    // MARK: - Build
    private func buildGrandma(_ root: SCNNode) {
        // Body - lavender cardigan
        let body = SCNNode(geometry: SCNCapsule(capRadius: 0.52, height: 1.8))
        body.geometry?.materials = [mat(cardiganColor, rough: 0.85)]
        body.name = "body"; body.position = SCNVector3(0, 0, 0)
        root.addChildNode(body)
        
        // Blouse inner
        let blouse = SCNNode(geometry: SCNCapsule(capRadius: 0.40, height: 1.4))
        blouse.geometry?.materials = [mat(blouseColor)]
        blouse.position = SCNVector3(0, 0.08, 0.07)
        body.addChildNode(blouse)
        
        // Necklace chain (torus around neck)
        let chain = SCNNode(geometry: SCNTorus(ringRadius: 0.28, pipeRadius: 0.008))
        chain.geometry?.materials = [mat(UIColor(red: 0.85, green: 0.80, blue: 0.70, alpha: 1), rough: 0.3)]
        chain.position = SCNVector3(0, 0.95, 0.05)
        body.addChildNode(chain)
        // Pearl pendant
        let pearl = SCNNode(geometry: SCNSphere(radius: 0.04))
        pearl.geometry?.materials = [{ let m = SCNMaterial(); m.diffuse.contents = UIColor(white: 0.95, alpha: 1); m.metalness.contents = 0.2; m.roughness.contents = 0.15; return m }()]
        pearl.position = SCNVector3(0, 0.82, 0.25)
        body.addChildNode(pearl)
        
        // Brooch (small heart on cardigan)
        let brooch = SCNNode(geometry: SCNSphere(radius: 0.035))
        brooch.geometry?.materials = [mat(UIColor(red: 0.85, green: 0.45, blue: 0.50, alpha: 1), rough: 0.2)]
        brooch.position = SCNVector3(-0.22, 0.65, 0.42)
        body.addChildNode(brooch)
        
        // Head
        let head = SCNNode(geometry: SCNSphere(radius: 0.48))
        head.geometry?.materials = [mat(skinColor, rough: 0.5)]
        head.name = "head"; head.position = SCNVector3(0, 1.35, 0)
        body.addChildNode(head)
        
        buildFace(head)
        buildHair(head)
        buildGlasses(head)
        buildArms(body)
    }
    
    // MARK: - Face
    private func buildFace(_ h: SCNNode) {
        // Eyes
        for s: Float in [-1, 1] {
            let x = s * 0.16
            // Sclera
            let sc = SCNNode(geometry: SCNSphere(radius: 0.10))
            sc.geometry?.materials = [mat(UIColor(white: 0.97, alpha: 1))]
            sc.position = SCNVector3(x, 0.08, 0.38); h.addChildNode(sc)
            // Iris
            let ir = SCNNode(geometry: SCNSphere(radius: 0.058))
            ir.geometry?.materials = [mat(UIColor(red: 0.42, green: 0.55, blue: 0.40, alpha: 1))] // Green-hazel
            ir.position = SCNVector3(0, 0, 0.06); sc.addChildNode(ir)
            // Pupil
            let pu = SCNNode(geometry: SCNSphere(radius: 0.028))
            pu.geometry?.materials = [mat(.black)]; pu.position = SCNVector3(0, 0, 0.04); ir.addChildNode(pu)
            // Catchlight sparkle
            let sp = SCNNode(geometry: SCNSphere(radius: 0.014))
            sp.geometry?.materials = [{ let m = SCNMaterial(); m.diffuse.contents = UIColor.white; m.emission.contents = UIColor(white: 0.9, alpha: 1); return m }()]
            sp.position = SCNVector3(0.012, 0.012, 0.03); ir.addChildNode(sp)
            // Eyelid
            let lid = SCNNode(geometry: SCNBox(width: 0.22, height: 0.02, length: 0.12, chamferRadius: 0.005))
            lid.geometry?.materials = [mat(skinColor)]; lid.name = s < 0 ? "lidL" : "lidR"
            lid.position = SCNVector3(0, 0.09, 0.04); lid.scale = SCNVector3(1, 0.3, 1); sc.addChildNode(lid)
            // Crow's feet (2 tiny lines at eye corner)
            for i in 0..<2 {
                let cf = SCNNode(geometry: SCNCylinder(radius: 0.005, height: 0.06))
                cf.geometry?.materials = [mat(UIColor(red: 0.90, green: 0.80, blue: 0.72, alpha: 0.5))]
                cf.position = SCNVector3(s * 0.22 + s * Float(i) * 0.02, 0.06 - Float(i) * 0.03, 0.36)
                cf.eulerAngles = SCNVector3(0, 0, Float.pi/2 + Float(i) * 0.3)
                h.addChildNode(cf)
            }
        }
        // Eyebrows (arched kindly)
        for s: Float in [-1, 1] {
            let brow = SCNNode(geometry: SCNBox(width: 0.17, height: 0.022, length: 0.035, chamferRadius: 0.01))
            brow.geometry?.materials = [mat(UIColor(red: 0.65, green: 0.60, blue: 0.58, alpha: 1))]
            brow.position = SCNVector3(s * 0.16, 0.22, 0.38)
            brow.eulerAngles = SCNVector3(0, 0, s * -0.15); h.addChildNode(brow)
        }
        // Nose
        let nose = SCNNode(geometry: SCNSphere(radius: 0.065))
        nose.geometry?.materials = [mat(UIColor(red: 0.94, green: 0.83, blue: 0.73, alpha: 1))]
        nose.position = SCNVector3(0, -0.02, 0.44); h.addChildNode(nose)
        // Mouth (smile shape)
        let mouth = SCNNode(geometry: SCNCapsule(capRadius: 0.028, height: 0.16))
        mouth.geometry?.materials = [mat(lipColor)]
        mouth.name = "mouth"; mouth.position = SCNVector3(0, -0.15, 0.40)
        mouth.eulerAngles = SCNVector3(0, 0, Float.pi/2); h.addChildNode(mouth)
        // Teeth (white bar behind lips)
        let teeth = SCNNode(geometry: SCNBox(width: 0.12, height: 0.03, length: 0.02, chamferRadius: 0.005))
        teeth.geometry?.materials = [mat(UIColor(white: 0.96, alpha: 1), rough: 0.2)]
        teeth.position = SCNVector3(0, -0.14, 0.38); h.addChildNode(teeth)
        // Smile lines
        for s: Float in [-1, 1] {
            let sl = SCNNode(geometry: SCNCylinder(radius: 0.006, height: 0.09))
            sl.geometry?.materials = [mat(UIColor(red: 0.90, green: 0.78, blue: 0.70, alpha: 0.5))]
            sl.position = SCNVector3(s * 0.11, -0.17, 0.36)
            sl.eulerAngles = SCNVector3(0.25, 0, s * 0.25); h.addChildNode(sl)
        }
        // Blush cheeks
        for s: Float in [-1, 1] {
            let ch = SCNNode(geometry: SCNCylinder(radius: 0.08, height: 0.008))
            ch.geometry?.materials = [mat(blushColor)]
            ch.position = SCNVector3(s * 0.25, -0.04, 0.38)
            ch.eulerAngles = SCNVector3(Float.pi/2, 0, 0); h.addChildNode(ch)
        }
        // Freckles (tiny dots on cheeks)
        for s: Float in [-1, 1] {
            for i in 0..<3 {
                let fr = SCNNode(geometry: SCNSphere(radius: 0.008))
                fr.geometry?.materials = [mat(UIColor(red: 0.82, green: 0.70, blue: 0.60, alpha: 0.4))]
                let ox = Float(i - 1) * 0.03
                fr.position = SCNVector3(s * 0.22 + ox, -0.02 + Float(i % 2) * 0.02, 0.42)
                h.addChildNode(fr)
            }
        }
    }
    
    // MARK: - Hair (modern silver bob with lavender highlights)
    private func buildHair(_ h: SCNNode) {
        let hm = mat(hairColor, rough: 0.7)
        let hlm = mat(hairHighlight, rough: 0.65) // Lavender highlight
        // Main back volume
        let back = SCNNode(geometry: SCNSphere(radius: 0.46)); back.geometry?.materials = [hm]
        back.position = SCNVector3(0, 0.12, -0.15); back.scale = SCNVector3(1.05, 0.95, 0.7); h.addChildNode(back)
        // Top of head
        let top = SCNNode(geometry: SCNSphere(radius: 0.44)); top.geometry?.materials = [hm]
        top.position = SCNVector3(0, 0.30, -0.02); top.scale = SCNVector3(1.0, 0.5, 0.95); h.addChildNode(top)
        // Left bob side (chin-length)
        let ls = SCNNode(geometry: SCNCapsule(capRadius: 0.15, height: 0.45)); ls.geometry?.materials = [hm]
        ls.position = SCNVector3(-0.35, -0.05, 0.0); ls.scale = SCNVector3(0.7, 1, 0.65); h.addChildNode(ls)
        // Right bob side
        let rs = SCNNode(geometry: SCNCapsule(capRadius: 0.15, height: 0.45)); rs.geometry?.materials = [hm]
        rs.position = SCNVector3(0.35, -0.05, 0.0); rs.scale = SCNVector3(0.7, 1, 0.65); h.addChildNode(rs)
        // Lavender highlight strands (subtle)
        for (pos, sc) in [(SCNVector3(-0.2, 0.15, 0.25), SCNVector3(0.3, 0.6, 0.3)),
                           (SCNVector3(0.22, 0.18, 0.22), SCNVector3(0.25, 0.55, 0.3))] {
            let hl = SCNNode(geometry: SCNCapsule(capRadius: 0.05, height: 0.3)); hl.geometry?.materials = [hlm]
            hl.position = pos; hl.scale = sc; h.addChildNode(hl)
        }
        // Forehead framing wisps
        let fw = SCNNode(geometry: SCNSphere(radius: 0.42)); fw.geometry?.materials = [hm]
        fw.position = SCNVector3(0, 0.22, 0.05); fw.scale = SCNVector3(1.0, 0.22, 0.85); h.addChildNode(fw)
    }
    
    // MARK: - Glasses (colorful reading glasses)
    private func buildGlasses(_ h: SCNNode) {
        let gm = mat(glassesColor, rough: 0.3)
        for s: Float in [-1, 1] {
            let x = s * 0.16
            let fr = SCNNode(geometry: SCNTorus(ringRadius: 0.115, pipeRadius: 0.013))
            fr.geometry?.materials = [gm]; fr.position = SCNVector3(x, 0.08, 0.41)
            fr.eulerAngles = SCNVector3(Float.pi/2, 0, 0); h.addChildNode(fr)
            // Lens
            let ln = SCNNode(geometry: SCNCylinder(radius: 0.10, height: 0.004))
            let lm = SCNMaterial(); lm.diffuse.contents = UIColor(red: 0.88, green: 0.92, blue: 0.98, alpha: 0.12); lm.transparency = 0.85
            ln.geometry?.materials = [lm]; ln.position = SCNVector3(x, 0.08, 0.41)
            ln.eulerAngles = SCNVector3(Float.pi/2, 0, 0); h.addChildNode(ln)
        }
        // Bridge
        let br = SCNNode(geometry: SCNCylinder(radius: 0.01, height: 0.10))
        br.geometry?.materials = [gm]; br.position = SCNVector3(0, 0.08, 0.46)
        br.eulerAngles = SCNVector3(0, 0, Float.pi/2); h.addChildNode(br)
        // Temples
        for s: Float in [-1, 1] {
            let t = SCNNode(geometry: SCNCylinder(radius: 0.007, height: 0.32))
            t.geometry?.materials = [gm]; t.position = SCNVector3(s * 0.27, 0.08, 0.24)
            t.eulerAngles = SCNVector3(Float.pi/2, 0, 0); h.addChildNode(t)
        }
    }
    
    // MARK: - Arms (jointed with fingers)
    private func buildArms(_ body: SCNNode) {
        let skm = mat(skinColor, rough: 0.5)
        let slm = mat(cardiganColor, rough: 0.85)
        for (n, sv) in [("left", -1.0), ("right", 1.0)] {
            let x = Float(sv * 0.70)
            let sh = SCNNode(); sh.name = "\(n)Sh"; sh.position = SCNVector3(x, 0.52, 0); body.addChildNode(sh)
            let ua = SCNNode(geometry: SCNCapsule(capRadius: 0.09, height: 0.50))
            ua.geometry?.materials = [slm]; ua.name = "\(n)UA"
            ua.position = SCNVector3(0, -0.23, 0); ua.eulerAngles = SCNVector3(0, 0, Float(sv) * 0.22)
            sh.addChildNode(ua)
            let el = SCNNode(); el.name = "\(n)El"; el.position = SCNVector3(0, -0.28, 0); ua.addChildNode(el)
            let fa = SCNNode(geometry: SCNCapsule(capRadius: 0.07, height: 0.38))
            fa.geometry?.materials = [skm]; fa.name = "\(n)FA"; fa.position = SCNVector3(0, -0.19, 0); el.addChildNode(fa)
            let hand = SCNNode(geometry: SCNSphere(radius: 0.07))
            hand.geometry?.materials = [skm]; hand.position = SCNVector3(0, -0.21, 0); fa.addChildNode(hand)
            // Fingers
            for i in 0..<4 {
                let f = SCNNode(geometry: SCNCylinder(radius: 0.012, height: 0.055))
                f.geometry?.materials = [skm]
                let a = Float(i - 2) * 0.25
                f.position = SCNVector3(sin(a)*0.04, -0.07, cos(a)*0.04)
                f.eulerAngles = SCNVector3(a*0.25, 0, 0); hand.addChildNode(f)
            }
            // Thumb
            let th = SCNNode(geometry: SCNCylinder(radius: 0.013, height: 0.045))
            th.geometry?.materials = [skm]; th.position = SCNVector3(Float(sv)*0.05, -0.03, 0.04)
            th.eulerAngles = SCNVector3(0.3, 0, Float(sv)*0.5); hand.addChildNode(th)
        }
    }
    
    // MARK: - Lighting
    private func addLights(_ scene: SCNScene) {
        func light(_ t: SCNLight.LightType, _ c: UIColor, _ i: CGFloat, _ p: SCNVector3) {
            let l = SCNLight(); l.type = t; l.color = c; l.intensity = i
            if t == .omni { l.attenuationStartDistance = 3; l.attenuationEndDistance = 12 }
            let n = SCNNode(); n.light = l; n.position = p; scene.rootNode.addChildNode(n)
        }
        light(.omni, UIColor(red: 1, green: 0.93, blue: 0.82, alpha: 1), 850, SCNVector3(2, 3, 4))
        light(.omni, UIColor(red: 0.88, green: 0.85, blue: 0.95, alpha: 1), 400, SCNVector3(-3, 2, 3))
        light(.ambient, UIColor(red: 0.95, green: 0.91, blue: 0.88, alpha: 1), 350, SCNVector3(0, 0, 0))
        light(.omni, UIColor(red: 1, green: 0.95, blue: 0.90, alpha: 1), 280, SCNVector3(0, 2, -3))
    }
    
    // MARK: - Camera
    private func addCamera(_ scene: SCNScene) {
        let cam = SCNCamera(); cam.fieldOfView = 35; cam.zNear = 0.1; cam.zFar = 100
        let n = SCNNode(); n.camera = cam; n.position = SCNVector3(0, 1.4, 5.5)
        n.look(at: SCNVector3(0, 0.8, 0)); scene.rootNode.addChildNode(n)
    }
    
    // MARK: - Idle anims
    private func idleAnims(_ root: SCNNode) {
        guard let body = root.childNode(withName: "body", recursively: true) else { return }
        let bIn = SCNAction.scale(to: 1.012, duration: 2.0); bIn.timingMode = .easeInEaseOut
        let bOut = SCNAction.scale(to: 1.0, duration: 2.0); bOut.timingMode = .easeInEaseOut
        body.runAction(.repeatForever(.sequence([bIn, bOut])), forKey: "breathe")
        // Blink
        if let ll = root.childNode(withName: "lidL", recursively: true),
           let lr = root.childNode(withName: "lidR", recursively: true) {
            nonisolated(unsafe) let leftLid = ll
            nonisolated(unsafe) let rightLid = lr
            let w = SCNAction.wait(duration: 3, withRange: 2)
            let cl = SCNAction.customAction(duration: 0.08) { _, _ in leftLid.scale.y = 5; rightLid.scale.y = 5 }
            let op = SCNAction.customAction(duration: 0.08) { _, _ in leftLid.scale.y = 0.3; rightLid.scale.y = 0.3 }
            ll.runAction(.repeatForever(.sequence([w, cl, .wait(duration: 0.1), op])), forKey: "blink")
        }
    }
    
    // MARK: - Speaking anims
    private func startAnims(_ root: SCNNode, _ c: Coordinator) {
        guard !c.active else { return }; c.active = true
        guard let body = root.childNode(withName: "body", recursively: true) else { return }
        // Mouth
        if let mouth = root.childNode(withName: "mouth", recursively: true), mouth.action(forKey: "talk") == nil {
            let o = SCNAction.customAction(duration: 0.10) { n, t in n.scale.y = 1 + 0.7 * Float(t/0.10) }
            let cl = SCNAction.customAction(duration: 0.10) { n, t in n.scale.y = 1.7 - 0.7 * Float(t/0.10) }
            mouth.runAction(.repeatForever(.sequence([o, .wait(duration: 0.04), cl, .wait(duration: 0.06)])), forKey: "talk")
        }
        // Sway
        if body.action(forKey: "sway") == nil {
            let l = SCNAction.rotateBy(x: 0, y: 0, z: 0.03, duration: 1.5); l.timingMode = .easeInEaseOut
            let r = SCNAction.rotateBy(x: 0, y: 0, z: -0.06, duration: 3); r.timingMode = .easeInEaseOut
            let b = SCNAction.rotateBy(x: 0, y: 0, z: 0.03, duration: 1.5); b.timingMode = .easeInEaseOut
            body.runAction(.repeatForever(.sequence([l, r, b])), forKey: "sway")
        }
        // Nod
        if let head = body.childNode(withName: "head", recursively: false), head.action(forKey: "nod") == nil {
            let n1 = SCNAction.rotateBy(x: 0.08, y: 0.05, z: 0, duration: 1.2); n1.timingMode = .easeInEaseOut
            let n2 = SCNAction.rotateBy(x: -0.08, y: -0.05, z: 0, duration: 1.2); n2.timingMode = .easeInEaseOut
            head.runAction(.repeatForever(.sequence([n1, n2])), forKey: "nod")
        }
        // Gestures
        if c.gestureTimer == nil {
            gesture(0, root)
            let coordinator = c
            nonisolated(unsafe) let rootNode = root
            c.gestureTimer = Timer.scheduledTimer(withTimeInterval: 3.5, repeats: true) { _ in
                DispatchQueue.main.async { [self] in
                    coordinator.gestureIdx = (coordinator.gestureIdx + 1) % 4
                    self.gesture(coordinator.gestureIdx, rootNode)
                }
            }
        }
    }
    
    private func stopAnims(_ root: SCNNode, _ c: Coordinator) {
        guard c.active else { return }; c.active = false
        guard let body = root.childNode(withName: "body", recursively: true) else { return }
        if let m = root.childNode(withName: "mouth", recursively: true) {
            m.removeAction(forKey: "talk")
            m.runAction(.customAction(duration: 0.15) { n, _ in n.scale = SCNVector3(1,1,1) })
        }
        body.removeAction(forKey: "sway")
        let rst = SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 0.5); rst.timingMode = .easeInEaseOut
        body.runAction(rst)
        if let h = body.childNode(withName: "head", recursively: false) {
            h.removeAction(forKey: "nod"); h.runAction(rst)
        }
        c.gestureTimer?.invalidate(); c.gestureTimer = nil; c.gestureIdx = 0
        restArms(root)
    }
    
    // MARK: - Gestures
    private func gesture(_ i: Int, _ root: SCNNode) {
        guard let body = root.childNode(withName: "body", recursively: true) else { return }
        let le = body.childNode(withName: "leftEl", recursively: true)
        let re = body.childNode(withName: "rightEl", recursively: true)
        let ls = body.childNode(withName: "leftSh", recursively: true)
        let rs = body.childNode(withName: "rightSh", recursively: true)
        let d: TimeInterval = 0.8
        let ease: (SCNAction) -> SCNAction = { $0.timingMode = .easeInEaseOut; return $0 }
        let relax = ease(SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: d))
        switch i {
        case 0: // Right open palm
            rs?.runAction(ease(SCNAction.rotateTo(x: -0.5, y: 0, z: -0.3, duration: d)))
            re?.runAction(ease(SCNAction.rotateTo(x: -0.6, y: 0, z: 0, duration: d)))
            ls?.runAction(relax); le?.runAction(relax)
        case 1: // Both raised
            ls?.runAction(ease(SCNAction.rotateTo(x: -0.4, y: 0, z: 0, duration: d)))
            rs?.runAction(ease(SCNAction.rotateTo(x: -0.4, y: 0, z: 0, duration: d)))
            le?.runAction(ease(SCNAction.rotateTo(x: -0.5, y: 0, z: 0, duration: d)))
            re?.runAction(ease(SCNAction.rotateTo(x: -0.5, y: 0, z: 0, duration: d)))
        case 2: // Hand to heart
            ls?.runAction(ease(SCNAction.rotateTo(x: -0.3, y: 0, z: 0.5, duration: d)))
            le?.runAction(ease(SCNAction.rotateTo(x: -0.8, y: 0, z: 0, duration: d)))
            rs?.runAction(relax); re?.runAction(relax)
        case 3: // Wave
            rs?.runAction(ease(SCNAction.rotateTo(x: -0.7, y: 0, z: -0.2, duration: 0.4)))
            re?.runAction(.sequence([
                SCNAction.rotateTo(x: -0.4, y: 0.3, z: 0, duration: 0.3),
                SCNAction.rotateTo(x: -0.4, y: -0.3, z: 0, duration: 0.3),
                SCNAction.rotateTo(x: -0.4, y: 0.3, z: 0, duration: 0.3),
                SCNAction.rotateTo(x: -0.4, y: -0.3, z: 0, duration: 0.3)
            ]))
            ls?.runAction(relax); le?.runAction(relax)
        default: break
        }
    }
    
    private func restArms(_ root: SCNNode) {
        guard let body = root.childNode(withName: "body", recursively: true) else { return }
        let r = SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 0.6); r.timingMode = .easeInEaseOut
        for n in ["leftSh", "rightSh", "leftEl", "rightEl"] {
            body.childNode(withName: n, recursively: true)?.runAction(r)
        }
    }
}

// MARK: - Speech Manager
@MainActor
class SpeechManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking = false
    @Published var spokenRange: NSRange? = nil
    @AppStorage("selectedLanguage") var selectedLanguageCode: String = "en-US"
    
    override init() { super.init(); synthesizer.delegate = self }
    
    func speak(text: String) {
        if synthesizer.isPaused { synthesizer.continueSpeaking(); isSpeaking = true; return }
        if synthesizer.isSpeaking { synthesizer.stopSpeaking(at: .immediate) }
        let u = AVSpeechUtterance(string: text)
        u.voice = selectVoice(for: selectedLanguageCode)
        u.rate = 0.42; u.pitchMultiplier = 1.28; u.volume = 0.9
        u.preUtteranceDelay = 0.2; u.postUtteranceDelay = 0.1
        synthesizer.speak(u); isSpeaking = true
    }
    
    private func selectVoice(for lang: String) -> AVSpeechSynthesisVoice? {
        let prefs: [String: [String]] = [
            "en-US": ["Samantha","Karen","Victoria"], "en-GB": ["Kate","Serena"],
            "es-ES": ["Monica","Paulina"], "fr-FR": ["Amelie","Audrey"],
            "de-DE": ["Anna","Petra"], "hi-IN": ["Lekha"]
        ]
        let base = String(lang.prefix(2))
        if let names = prefs[lang] {
            for n in names {
                if let v = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.\(lang).\(n)") { return v }
                if let v = AVSpeechSynthesisVoice(identifier: "com.apple.voice.enhanced.\(lang).\(n)") { return v }
            }
        }
        if let v = AVSpeechSynthesisVoice.speechVoices().first(where: {
            $0.language.hasPrefix(base) && ($0.name.contains("Female") || $0.gender == .female)
        }) { return v }
        return AVSpeechSynthesisVoice(language: lang)
    }
    
    func pause() { synthesizer.pauseSpeaking(at: .immediate); isSpeaking = false }
    func stop() { synthesizer.stopSpeaking(at: .immediate); isSpeaking = false }
    
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        Task { @MainActor in isSpeaking = false }
    }
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in isSpeaking = false }
    }
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        Task { @MainActor in
            spokenRange = characterRange
        }
    }
}
