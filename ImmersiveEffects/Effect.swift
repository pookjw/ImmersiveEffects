//
//  Effect.swift
//  Effects
//
//  Created by Jinwoo Kim on 5/30/24.
//

enum Effect: Int, Hashable, CaseIterable, Identifiable {
    case fallingBalls
//    case shootingBalls
    case fireworks
    
    var id: Int {
        rawValue
    }
}
