
//
//  GrandmaSceneView.swift
//  Granlyyy
//
//  Created for 3D Interactive Onboarding & Expressions
//

import SwiftUI
@preconcurrency import SceneKit
import AVFoundation

// MARK: - Enums for Actions & Expressions
enum GrandmaAction: String {
    case idle
    case wave
    case tellStory
    case listen
    case celebrate
    case love
}

enum GrandmaExpression: String {
    case neutral
    case happy
    case sad
    case surprised
    case angry
}

struct GrandmaSceneView: UIViewRepresentable {
    @Binding var action: GrandmaAction
    @Binding var expression: GrandmaExpression
    @Binding var isSpeaking: Bool
    @ObservedObject var settings: GrandmaSettings
    
    // Internal state for lip sync
    @State private var lipSyncTimer: Timer?
    
    class Coordinator: NSObject, @unchecked Sendable {
        var scene: SCNScene?
        var gestureTimer: Timer?
        var lipSyncTimer: Timer?
        var gestureIdx = 0
        var currentExpression: GrandmaExpression = .neutral
    }
    
    func makeCoordinator() -> Coordinator { Coordinator() }
    
    func makeUIView(context: Context) -> SCNView {
        let v = SCNView()
        v.backgroundColor = .clear
        v.autoenablesDefaultLighting = false
        v.allowsCameraControl = false
        v.antialiasingMode = .multisampling4X
        let scene = SCNScene()
        scene.background.contents = UIColor.clear
        
        let root = SCNNode()
        root.name = "root"
        scene.rootNode.addChildNode(root)
        
        // Build Grandma
        buildGrandma(root, settings: settings)
        
        // Lighting
        addLights(scene)
        addCamera(scene)
        
        // Start Idle Animation
        startIdle(root)
        
        v.scene = scene
        context.coordinator.scene = scene
        return v
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        guard let scene = context.coordinator.scene,
              let root = scene.rootNode.childNode(withName: "root", recursively: false) else { return }
        
        // 1. Update Appearance (Settings)
        // Optimization: In a real app, track changes. Here we rebuild for simplicity if needed.
        // For performance, we should only rebuild if settings changed. 
        // We can check if materials match current settings, but let's just update materials for now.
        // Actually, changing hair style requires rebuild. 
        // Let's rebuild every time settings change (SwiftUI triggers updateUIView).
        // To avoid flickering, we should check if settings changed.
        // For now, let's just rebuild to be safe and simple as per instructions.
        root.enumerateChildNodes { (node, stop) in node.removeFromParentNode() }
        buildGrandma(root, settings: settings)
        
        // 2. Update Action (Body Language)
        updateAction(root, action: action, context: context)
        
        // 3. Update Expression (Face)
        updateExpression(root, expression: expression, context: context)
        
        // 4. Lip Sync (Jaw Movement)
        updateLipSync(root, isSpeaking: isSpeaking, context: context)
        
        // Re-apply camera/lights since we cleared root
        addLights(scene)
        addCamera(scene)
    }
    
    // MARK: - Action Engine (Body Language)
    private func updateAction(_ root: SCNNode, action: GrandmaAction, context: Context) {
        // Simple distinct actions:
        switch action {
        case .idle:
            context.coordinator.gestureTimer?.invalidate()
            restArms(root)
            startIdle(root)
            
        case .wave:
            if root.childNode(withName: "rightSh", recursively: true)?.action(forKey: "wave") == nil {
                performWave(root)
            }
            
        case .tellStory:
            if context.coordinator.gestureTimer == nil || !context.coordinator.gestureTimer!.isValid {
               startGestures(root, context.coordinator)
            }
            
        case .listen:
            context.coordinator.gestureTimer?.invalidate()
            // Lean forward slightly
             restArms(root)
             if let head = root.childNode(withName: "head", recursively: true) {
                 head.runAction(.rotateTo(x: 0.1, y: 0.1, z: 0, duration: 0.5))
             }

        case .celebrate:
            context.coordinator.gestureTimer?.invalidate()
            performCelebrate(root)
            
        case .love:
             context.coordinator.gestureTimer?.invalidate()
             performLove(root)
        }
    }
    
    // MARK: - Expression Engine (Face)
    private func updateExpression(_ root: SCNNode, expression: GrandmaExpression, context: Context) {
        // Always apply expression update in case of rebuild
        context.coordinator.currentExpression = expression
        
        guard let head = root.childNode(withName: "head", recursively: true) else { return }
        
        // MOUTH
        if let mouth = head.childNode(withName: "mouth", recursively: true) {
             switch expression {
             case .happy:
                 mouth.scale = SCNVector3(1.2, 0.8, 1) // Smile
                 mouth.eulerAngles = SCNVector3(0, 0, 0.2)
                 
             case .sad:
                 mouth.scale = SCNVector3(1, 0.8, 1)
                 mouth.eulerAngles = SCNVector3(0, 0, -0.2) // Frown
                 
             case .surprised:
                 mouth.scale = SCNVector3(0.5, 1.5, 1) // 'O' shape
                 mouth.eulerAngles = SCNVector3(0, 0, 0)
                 
             case .angry:
                  mouth.scale = SCNVector3(1, 0.2, 1) // Thin line
                  mouth.eulerAngles = SCNVector3(0, 0, 0)
                  
             case .neutral:
                 mouth.scale = SCNVector3(1, 1, 1)
                 mouth.eulerAngles = SCNVector3(0, 0, 0)
             }
        }
        
        // EYEBROWS
        for s in ["L", "R"] {
            if let brow = head.childNode(withName: "brow_\(s)", recursively: true) {
                let isLeft = (s == "L")
                let sign: Float = isLeft ? 1 : -1
                
                switch expression {
                case .happy:
                    brow.position.y = 0.24 // Raised slightly
                    brow.eulerAngles.z = Float.pi/2
                    
                case .sad:
                   brow.position.y = 0.22
                   brow.eulerAngles.z = Float.pi/2 - (0.2 * sign) // Inner up
                    
                case .surprised:
                    brow.position.y = 0.28 // Way up
                    brow.eulerAngles.z = Float.pi/2
                    
                case .angry:
                    brow.position.y = 0.20 // Low
                    brow.eulerAngles.z = Float.pi/2 + (0.3 * sign) // Inner down
                    
                case .neutral:
                    brow.position.y = 0.22
                    brow.eulerAngles.z = Float.pi/2
                }
            }
        }
    }
    
    // MARK: - Lip Sync
    private func updateLipSync(_ root: SCNNode, isSpeaking: Bool, context: Context) {
        guard let head = root.childNode(withName: "head", recursively: true) else { return }
        
        if isSpeaking {
             if context.coordinator.lipSyncTimer == nil {
                 context.coordinator.lipSyncTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
                     if let mouth = head.childNode(withName: "mouth", recursively: true) {
                         let s = Float.random(in: 0.5...1.5)
                         // Non-uniform scale animation using runBlock or SCNTransaction
                         mouth.runAction(SCNAction.run { node in
                             let current = node.scale
                             SCNTransaction.begin()
                             SCNTransaction.animationDuration = 0.1
                             node.scale = SCNVector3(current.x, s, current.z)
                             SCNTransaction.commit()
                         })
                     }
                 }
             }
        } else {
            context.coordinator.lipSyncTimer?.invalidate()
            context.coordinator.lipSyncTimer = nil
            // Reset mouth to expression state
            updateExpression(root, expression: context.coordinator.currentExpression, context: context)
        }
    }
    
    // MARK: - Animations
    private func performWave(_ root: SCNNode) {
        guard let body = root.childNode(withName: "body", recursively: true),
              let ra = body.childNode(withName: "rightSh", recursively: true),
              let re = body.childNode(withName: "rightEl", recursively: true) else { return }
        
        let raise = SCNAction.rotateTo(x: -0.8, y: 0, z: -0.4, duration: 0.4)
        let waveL = SCNAction.rotateBy(x: 0, y: 0, z: -0.4, duration: 0.2)
        let waveR = SCNAction.rotateBy(x: 0, y: 0, z: 0.4, duration: 0.2)
        let waveSeq = SCNAction.sequence([waveL, waveR, waveL, waveR, waveL, waveR])
        let lower = SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 0.5)
        
        ra.runAction(.sequence([raise, waveSeq, lower]), forKey: "wave")
        re.runAction(.sequence([
            SCNAction.rotateTo(x: -2.0, y: 0, z: 0, duration: 0.4),
            .wait(duration: 1.2),
            SCNAction.rotateTo(x: -0.28, y: 0, z: 0, duration: 0.5)
        ]))
    }
    
    private func performCelebrate(_ root: SCNNode) {
         guard let body = root.childNode(withName: "body", recursively: true),
              let la = body.childNode(withName: "leftSh", recursively: true),
              let ra = body.childNode(withName: "rightSh", recursively: true) else { return }
              
        let raiseL = SCNAction.rotateTo(x: -2.5, y: 0, z: 0.2, duration: 0.5)
        let raiseR = SCNAction.rotateTo(x: -2.5, y: 0, z: -0.2, duration: 0.5)
        
        la.runAction(raiseL)
        ra.runAction(raiseR)
    }
    
     private func performLove(_ root: SCNNode) {
          guard let body = root.childNode(withName: "body", recursively: true),
              let la = body.childNode(withName: "leftSh", recursively: true),
              let ra = body.childNode(withName: "rightSh", recursively: true) else { return }
              
        let hugL = SCNAction.rotateTo(x: -1.2, y: 0.5, z: 0, duration: 0.6)
        let hugR = SCNAction.rotateTo(x: -1.2, y: -0.5, z: 0, duration: 0.6)
        
        la.runAction(hugL)
        ra.runAction(hugR)
    }
    
    private func startGestures(_ root: SCNNode, _ c: Coordinator) {
        c.gestureTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { [weak c] _ in
            guard let c = c else { return }
            Task { @MainActor in
                self.gesture(c.gestureIdx, root)
                c.gestureIdx = (c.gestureIdx + 1) % 3
            }
        }
    }
    
     private func gesture(_ i: Int, _ root: SCNNode) {
          guard let body = root.childNode(withName: "body", recursively: true) else { return }
         restArms(root)
         
         if i == 0 {
             if let la = body.childNode(withName: "leftSh", recursively: true),
                let ra = body.childNode(withName: "rightSh", recursively: true) {
                 la.runAction(.rotateTo(x: 0, y: 0.2, z: 0.3, duration: 0.8))
                 ra.runAction(.rotateTo(x: 0, y: -0.2, z: -0.3, duration: 0.8))
             }
         } else if i == 1 {
              if let ra = body.childNode(withName: "rightSh", recursively: true) {
                  ra.runAction(.rotateTo(x: -0.4, y: 0, z: 0, duration: 0.6))
              }
         }
     }
     
    private func restArms(_ root: SCNNode) {
         guard let body = root.childNode(withName: "body", recursively: true) else { return }
        if let la = body.childNode(withName: "leftSh", recursively: true),
           let ra = body.childNode(withName: "rightSh", recursively: true) {
            la.runAction(.rotateTo(x: 0, y: 0, z: 0, duration: 0.5))
            ra.runAction(.rotateTo(x: 0, y: 0, z: 0, duration: 0.5))
        }
    }
    
    private func startIdle(_ root: SCNNode) {
         let tilt = SCNAction.sequence([
             .rotateTo(x: 0, y: 0, z: 0.03, duration: 2.0),
             .rotateTo(x: 0, y: 0, z: -0.03, duration: 2.0)
         ])
         if let head = root.childNode(withName: "head", recursively: true) {
             head.runAction(.repeatForever(tilt))
             
             // Start Blink Routine
             scheduleBlink(head)
         }
    }
    
    private func scheduleBlink(_ head: SCNNode) {
        let delay = Double.random(in: 2.0...6.0)
        
        let blinkAction = SCNAction.sequence([
            SCNAction.wait(duration: delay),
            SCNAction.run { _ in
                let beginBlink = SCNAction.run { node in
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = 0.05
                    node.scale = SCNVector3(1, 0.1, 1)
                    SCNTransaction.commit()
                }
                let endBlink = SCNAction.run { node in
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = 0.1
                    node.scale = SCNVector3(1, 1, 1)
                    SCNTransaction.commit()
                }
                let blink = SCNAction.sequence([
                    beginBlink,
                    SCNAction.wait(duration: 0.05),
                    endBlink
                ])
                if let leftEye = head.childNode(withName: "eye_L", recursively: true),
                   let rightEye = head.childNode(withName: "eye_R", recursively: true) {
                    leftEye.runAction(blink)
                    rightEye.runAction(blink)
                }
            },
            SCNAction.run { _ in
                Task { @MainActor in
                    self.scheduleBlink(head)
                }
            }
        ])
        
        // Use a unique key to prevent compounding of blink actions if startIdle is called again
        head.runAction(blinkAction, forKey: "blinkCycle")
    }

    // MARK: - Build 3D Model
    private func buildGrandma(_ root: SCNNode, settings: GrandmaSettings) {
        // Body Texture
        let outfitColor = UIColor(cgColor: settings.outfitColor.uiColor.cgColor)
        let patternImage = TextureGenerator.shared.generateTexture(pattern: settings.outfitPattern, baseColor: outfitColor)
        
        // Body
        let body = SCNNode(geometry: SCNCapsule(capRadius: 0.52, height: 1.8))
        body.geometry?.materials = [mat(image: patternImage, rough: 0.85)]
        body.name = "body"; body.position = SCNVector3(0, 0, 0)
        root.addChildNode(body)
        
        // HEAD
        let head = SCNNode(geometry: SCNSphere(radius: 0.48))
        head.geometry?.materials = [mat(UIColor(cgColor: settings.skinTone.uiColor.cgColor), rough: 0.5)]
        head.name = "head"; head.position = SCNVector3(0, 1.35, 0)
        body.addChildNode(head)
        
        buildFace(head, settings: settings)
        buildEars(head, settings: settings)
        buildHair(head, settings: settings)
        // If there's a hat, it might cover the hair, but build Hats after Hair anyway
        buildHats(head, settings: settings)
        buildGlasses(head, settings: settings)
        buildArms(body, settings: settings)
        buildAccessories(body, settings: settings)
    }
    
    private func buildFace(_ h: SCNNode, settings: GrandmaSettings) {
        let skin = UIColor(cgColor: settings.skinTone.uiColor.cgColor)
        for s: Float in [-1, 1] {
             let x = s * 0.16
             let sc = SCNNode(geometry: SCNSphere(radius: 0.10))
             sc.geometry?.materials = [mat(.white)]
             sc.position = SCNVector3(x, 0.08, 0.38)
             sc.name = "eye_\(s > 0 ? "R" : "L")"
             h.addChildNode(sc)
             let ir = SCNNode(geometry: SCNSphere(radius: 0.058))
             ir.geometry?.materials = [mat(.green)]
             ir.position = SCNVector3(0, 0, 0.06); sc.addChildNode(ir)
             let pu = SCNNode(geometry: SCNSphere(radius: 0.028))
            pu.geometry?.materials = [mat(.black)]; pu.position = SCNVector3(0, 0, 0.04); ir.addChildNode(pu)
            
            // EYEBROWS
             let brow = SCNNode(geometry: SCNCapsule(capRadius: 0.02, height: 0.14))
             brow.geometry?.materials = [mat(UIColor(cgColor: settings.hairColor.uiColor.cgColor))]
             brow.position = SCNVector3(x, 0.22, 0.45)
             brow.eulerAngles = SCNVector3(0, 0, Float.pi/2)
             brow.name = "brow_\(s > 0 ? "R" : "L")"
             h.addChildNode(brow)
        }
        let nose = SCNNode(geometry: SCNSphere(radius: 0.065))
        nose.geometry?.materials = [mat(skin)]
        nose.position = SCNVector3(0, -0.02, 0.44); h.addChildNode(nose)
        
        // Mouth
        let mouth = SCNNode(geometry: SCNCapsule(capRadius: 0.032, height: 0.20))
        mouth.geometry?.materials = [mat(UIColor(red: 0.82, green: 0.52, blue: 0.50, alpha: 1))]
        mouth.position = SCNVector3(0, -0.15, 0.40)
        mouth.eulerAngles = SCNVector3(0, 0, Float.pi/2)
        mouth.name = "mouth"
        h.addChildNode(mouth)
    }

    private func buildEars(_ h: SCNNode, settings: GrandmaSettings) {
         let skin = UIColor(cgColor: settings.skinTone.uiColor.cgColor)
         for s: Float in [-1, 1] {
            let ear = SCNNode(geometry: SCNSphere(radius: 0.09))
            ear.geometry?.materials = [mat(skin)]
            ear.position = SCNVector3(s * 0.44, 0.05, 0.02)
            ear.scale = SCNVector3(0.6, 0.9, 0.5)
            h.addChildNode(ear)
            
            // New Earring System
            switch settings.earringStyle {
            case .pearl:
                let earring = SCNNode(geometry: SCNSphere(radius: 0.035))
                earring.geometry?.materials = [mat(.white, rough: 0.2, metal: 0.1)]
                earring.position = SCNVector3(0, -0.1, 0)
                ear.addChildNode(earring)
            case .goldHoop:
                let hoop = SCNNode(geometry: SCNTorus(ringRadius: 0.04, pipeRadius: 0.008))
                hoop.geometry?.materials = [mat(UIColor(red: 1.0, green: 0.8, blue: 0.2, alpha: 1), rough: 0.2, metal: 1.0)]
                hoop.position = SCNVector3(0, -0.12, 0)
                hoop.eulerAngles = SCNVector3(Float.pi/2, 0, 0)
                ear.addChildNode(hoop)
            case .diamond:
                let stud = SCNNode(geometry: SCNPyramid(width: 0.04, height: 0.04, length: 0.04))
                stud.geometry?.materials = [mat(UIColor(white: 0.95, alpha: 1), rough: 0.1, metal: 0.8)]
                stud.position = SCNVector3(0, -0.08, 0.06)
                stud.eulerAngles = SCNVector3(Float.pi/2, 0, 0)
                ear.addChildNode(stud)
            case .none: break
            }
         }
    }
    
    private func buildHair(_ h: SCNNode, settings: GrandmaSettings) {
         let hairColor = UIColor(cgColor: settings.hairColor.uiColor.cgColor)
         let hm = mat(hairColor, rough: 0.7)
         let top = SCNNode(geometry: SCNSphere(radius: 0.49))
         top.geometry?.materials = [hm]
         top.position = SCNVector3(0, 0.1, -0.05)
         top.scale = SCNVector3(1, 0.8, 0.9)
         h.addChildNode(top)
         
         switch settings.hairStyle {
         case .bun:
             let bun = SCNNode(geometry: SCNSphere(radius: 0.25))
             bun.geometry?.materials = [hm]
             bun.position = SCNVector3(0, 0.35, -0.4)
             h.addChildNode(bun)
         case .bob:
             let sideL = SCNNode(geometry: SCNCapsule(capRadius: 0.15, height: 0.6))
             sideL.geometry?.materials = [hm]; sideL.position = SCNVector3(-0.4, -0.1, 0.1); h.addChildNode(sideL)
             let sideR = SCNNode(geometry: SCNCapsule(capRadius: 0.15, height: 0.6))
             sideR.geometry?.materials = [hm]; sideR.position = SCNVector3(0.4, -0.1, 0.1); h.addChildNode(sideR)
         case .long:
             let back = SCNNode(geometry: SCNCylinder(radius: 0.45, height: 0.8))
             back.geometry?.materials = [hm]; back.position = SCNVector3(0, -0.3, -0.2); h.addChildNode(back)
         case .pixie:
              let spike = SCNNode(geometry: SCNSphere(radius: 0.1))
              spike.geometry?.materials = [hm]; spike.position = SCNVector3(0, 0.5, 0); h.addChildNode(spike)
         }
    }
    
    private func buildGlasses(_ h: SCNNode, settings: GrandmaSettings) {
        if settings.glassesStyle == .none { return }
        let gm = mat(.black, rough: 0.3)
        let r: CGFloat = (settings.glassesStyle == .round) ? 0.115 : 0.10
        for s: Float in [-1, 1] {
            let x = s * 0.16
            let fr: SCNNode
            if settings.glassesStyle == .square {
                 fr = SCNNode(geometry: SCNBox(width: 0.25, height: 0.18, length: 0.02, chamferRadius: 0.01))
            } else {
                 fr = SCNNode(geometry: SCNTorus(ringRadius: r, pipeRadius: 0.013))
            }
            fr.geometry?.materials = [gm]; fr.position = SCNVector3(x, 0.08, 0.41)
            if settings.glassesStyle != .square { fr.eulerAngles = SCNVector3(Float.pi/2, 0, 0) }
            h.addChildNode(fr)
        }
        let br = SCNNode(geometry: SCNCylinder(radius: 0.01, height: 0.10))
        br.geometry?.materials = [gm]; br.position = SCNVector3(0, 0.08, 0.46)
        br.eulerAngles = SCNVector3(0, 0, Float.pi/2); h.addChildNode(br)
    }
    
    private func buildArms(_ body: SCNNode, settings: GrandmaSettings) {
          let outfitColor = UIColor(cgColor: settings.outfitColor.uiColor.cgColor)
          let patternImage = TextureGenerator.shared.generateTexture(pattern: settings.outfitPattern, baseColor: outfitColor)
          let skin = UIColor(cgColor: settings.skinTone.uiColor.cgColor)
          
          for (n, sv) in [("left", -1.0), ("right", 1.0)] {
             let x = Float(sv * 0.70)
             let sh = SCNNode(); sh.name = "\(n)Sh"; sh.position = SCNVector3(x, 0.52, 0); body.addChildNode(sh)
             let ua = SCNNode(geometry: SCNCapsule(capRadius: 0.09, height: 0.50))
             ua.geometry?.materials = [mat(image: patternImage)]; ua.position = SCNVector3(0, -0.23, 0); ua.eulerAngles = SCNVector3(0, 0, Float(sv) * 0.22); sh.addChildNode(ua)
             let el = SCNNode(); el.name = "\(n)El"; el.position = SCNVector3(0, -0.28, 0); ua.addChildNode(el)
             let fa = SCNNode(geometry: SCNCapsule(capRadius: 0.07, height: 0.38))
             fa.geometry?.materials = [mat(skin)]; fa.position = SCNVector3(0, -0.19, 0); el.addChildNode(fa)
             let hand = SCNNode(geometry: SCNSphere(radius: 0.07))
             hand.geometry?.materials = [mat(skin)]; hand.position = SCNVector3(0, -0.21, 0); fa.addChildNode(hand)
          }
    }
    
    private func buildAccessories(_ body: SCNNode, settings: GrandmaSettings) {
        switch settings.accessory {
        case .pearl:
            let chain = SCNNode(geometry: SCNTorus(ringRadius: 0.28, pipeRadius: 0.008))
            chain.geometry?.materials = [mat(UIColor(white: 0.9, alpha: 1))]; chain.position = SCNVector3(0, 0.95, 0.05); body.addChildNode(chain)
        case .gold:
            let chain = SCNNode(geometry: SCNTorus(ringRadius: 0.28, pipeRadius: 0.005))
            chain.geometry?.materials = [mat(UIColor.yellow)]; chain.position = SCNVector3(0, 0.95, 0.05); body.addChildNode(chain)
        case .scarf:
            let scarf = SCNNode(geometry: SCNTorus(ringRadius: 0.30, pipeRadius: 0.08))
            scarf.geometry?.materials = [mat(UIColor.red)]; scarf.position = SCNVector3(0, 0.92, 0.05); body.addChildNode(scarf)
            let d = SCNNode(geometry: SCNCapsule(capRadius: 0.08, height: 0.4))
            d.geometry?.materials = [mat(UIColor.red)]; d.position = SCNVector3(0.1, 0.7, 0.25); d.eulerAngles.x = 0.5; body.addChildNode(d)
        case .brooch:
            let brooch = SCNNode(geometry: SCNSphere(radius: 0.04))
            brooch.geometry?.materials = [mat(UIColor.red)]; brooch.position = SCNVector3(-0.2, 0.7, 0.45); body.addChildNode(brooch)
        case .none: break
        }
    }
    
    private func buildHats(_ head: SCNNode, settings: GrandmaSettings) {
        switch settings.hatStyle {
        case .sunHat:
            let brim = SCNNode(geometry: SCNCylinder(radius: 0.75, height: 0.02))
            brim.geometry?.materials = [mat(UIColor(red: 0.9, green: 0.8, blue: 0.6, alpha: 1))]
            brim.position = SCNVector3(0, 0.4, -0.05)
            brim.eulerAngles = SCNVector3(-0.1, 0, 0)
            head.addChildNode(brim)
            
            let top = SCNNode(geometry: SCNCylinder(radius: 0.45, height: 0.3))
            top.geometry?.materials = [mat(UIColor(red: 0.9, green: 0.8, blue: 0.6, alpha: 1))]
            top.position = SCNVector3(0, 0.55, -0.05)
            top.eulerAngles = SCNVector3(-0.1, 0, 0)
            head.addChildNode(top)
        case .beanie:
            let beanie = SCNNode(geometry: SCNSphere(radius: 0.52))
            beanie.geometry?.materials = [mat(UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1), rough: 0.9)]
            beanie.position = SCNVector3(0, 0.15, -0.05)
            // Flatten the bottom half
            let plane = SCNNode(geometry: SCNBox(width: 2, height: 1, length: 2, chamferRadius: 0))
            plane.position = SCNVector3(0, -0.5, 0)
            
            head.addChildNode(beanie)
            
            let pom = SCNNode(geometry: SCNSphere(radius: 0.15))
            pom.geometry?.materials = [mat(UIColor.white, rough: 0.9)]
            pom.position = SCNVector3(0, 0.55, 0)
            beanie.addChildNode(pom)
        case .beret:
            let beret = SCNNode(geometry: SCNCylinder(radius: 0.5, height: 0.15))
            beret.geometry?.materials = [mat(UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1), rough: 0.9)]
            beret.position = SCNVector3(0.1, 0.45, 0)
            beret.eulerAngles = SCNVector3(-0.2, 0, -0.2)
            head.addChildNode(beret)
            
            let tip = SCNNode(geometry: SCNCylinder(radius: 0.02, height: 0.05))
            tip.geometry?.materials = [mat(UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1), rough: 0.9)]
            tip.position = SCNVector3(0, 0.1, 0)
            beret.addChildNode(tip)
        case .none: break
        }
    }
    
    private func addLights(_ scene: SCNScene) {
         let ambient = SCNLight(); ambient.type = .ambient; ambient.intensity = 300
         let ambientNode = SCNNode(); ambientNode.light = ambient
         scene.rootNode.addChildNode(ambientNode)
         
         let omni = SCNLight(); omni.type = .omni; omni.intensity = 800
         let on = SCNNode(); on.light = omni; on.position = SCNVector3(2, 2, 5)
         scene.rootNode.addChildNode(on)
    }
    
    private func addCamera(_ scene: SCNScene) {
        let cn = SCNNode(); cn.camera = SCNCamera(); cn.position = SCNVector3(0, 1.3, 3.5); scene.rootNode.addChildNode(cn)
    }
    
    private func mat(_ c: UIColor, rough: CGFloat = 0.6, metal: CGFloat = 0.0) -> SCNMaterial {
        let m = SCNMaterial()
        m.diffuse.contents = c
        m.roughness.contents = rough
        return m
    }
    
    // Overloaded to accept Image Textures for patterns
    private func mat(image: UIImage, rough: CGFloat = 0.6) -> SCNMaterial {
        let m = SCNMaterial()
        m.diffuse.contents = image
        // To make the pattern repeat correctly on capsules
        m.diffuse.contentsTransform = SCNMatrix4MakeScale(2, 4, 1) // Tiling scale
        m.diffuse.wrapS = .repeat
        m.diffuse.wrapT = .repeat
        m.roughness.contents = rough
        return m
    }
}
