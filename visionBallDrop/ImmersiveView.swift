//
//  ImmersiveView.swift
//  visionBallDrop
//
//  Created by Allison on 5/20/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            //            if let diceModel = try? await Entity(named: "dice"),
            //               let dice = diceModel.children.first?.children.first {
            //                dice.scale = [2, 2, 2]
            //                dice.position.y = 0.5
            //                dice.position.z = -1
            //                content.add(dice)
            //            }
            
            // Floor
            let floor = ModelEntity(mesh: .generatePlane(width: 50, depth: 50), materials: [OcclusionMaterial()])
            floor.generateCollisionShapes(recursive: false)
            floor.components[PhysicsBodyComponent.self] = .init(
                massProperties: .default,
                mode: .static
            )
            
            content.add(floor)
            
            // Ball
            let model = ModelEntity(
                mesh: .generateSphere(radius: 0.08),
                            materials: [SimpleMaterial(color: .blue, isMetallic: false)])
            model.position.y = 0.5
            model.position.z = -1
            
            model.generateCollisionShapes(recursive: false)
            model.components.set(InputTargetComponent())
            
            model.components[PhysicsBodyComponent.self] = .init(PhysicsBodyComponent(
                massProperties: .default,
                material: .generate(staticFriction: 0.8, dynamicFriction: 0.5, restitution: 0.1),
                mode: .dynamic
            ))
            model.components[PhysicsMotionComponent.self] = .init()
            
            content.add(model)
        }
        .gesture(dragGesture)
    }
    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                value.entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
            }
            .onEnded { value in
                value.entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
            }
    }

}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
}
