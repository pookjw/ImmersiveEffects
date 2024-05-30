//
//  ImmersiveView.swift
//  ImmersiveEffects
//
//  Created by Jinwoo Kim on 5/30/24.
//

import SwiftUI
import RealityKit

struct ImmersiveView: View {
    private let floorCollisionName: String = "FloorCollisionEntity"
    
    var body: some View {
        GeometryReader3D { geometry in
            RealityView { content in
                let localFrame: Rect3D = geometry.frame(in: .local)
                let sceneFrame: BoundingBox = content.convert(localFrame, from: .local, to: .scene)
                
                addSpheres(into: content, sceneFrame: sceneFrame)
                addFloorCollisionEntity(into: content, sceneFrame: sceneFrame)
            } update: { content in
                let localFrame: Rect3D = geometry.frame(in: .local)
                let sceneFrame: BoundingBox = content.convert(localFrame, from: .local, to: .scene)
                
                updateFloorCollisionEntity(with: content, sceneFrame: sceneFrame)
            }
        }
    }
    
    private func addSpheres(into content: RealityViewContent, sceneFrame: BoundingBox) {
        for index in 0..<50 {
            let sphereEntity: Entity = .metalicSphere(sceneFrame: sceneFrame)
            sphereEntity.name = "SphereEntity_\(index)"
            
            content.add(sphereEntity)
        }
    }
    
    private func addFloorCollisionEntity(into content: RealityViewContent, sceneFrame: BoundingBox) {
        let boxSize: Float = 30.0
        
        let floorCollisionEntity: ModelEntity = .init(
            mesh: .generateBox(size: boxSize),
            materials: [
                SimpleMaterial(color: .init(white: 1.0, alpha: 0.1), isMetallic: true)
            ]
        )
        
        floorCollisionEntity.name = floorCollisionName
        floorCollisionEntity.position = floorCollisionEntityLocation(sceneFrame: sceneFrame)
        
        let boxShape: ShapeResource = .generateBox(
            width: boxSize,
            height: 1E-3,
            depth: boxSize
        )
        
        let collisionComponent: CollisionComponent = .init(
            shapes: [boxShape],
            isStatic: true
        )
        
        floorCollisionEntity.components.set(collisionComponent)
        
        let physicsBodyComponent: PhysicsBodyComponent = .init(
            shapes: [boxShape],
            mass: 1.0,
            mode: .static
        )
        
        floorCollisionEntity.components.set(physicsBodyComponent)
        
        content.add(floorCollisionEntity)
    }
    
    private func updateFloorCollisionEntity(with content: RealityViewContent, sceneFrame: BoundingBox) {
        let floorCollisionName: String = floorCollisionName
        
        for entity in content.entities {
            if entity.name == floorCollisionName {
                entity.position = floorCollisionEntityLocation(sceneFrame: sceneFrame)
                return
            }
        }
    }
    
    private func floorCollisionEntityLocation(sceneFrame: BoundingBox) -> SIMD3<Float> {
        let center: SIMD3<Float> = sceneFrame.center
        return .init(x: center.x, y: .zero, z: center.z)
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
}
