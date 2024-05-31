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
    case impact
    case magic
    case rain
    case snow
    case sparks
    
    var id: Int {
        rawValue
    }
    
    var title: String {
        switch self {
        case .fallingBalls:
            "Falling Balls"
        case .fireworks:
            "Fireworks"
        case .impact:
            "Impact"
        case .magic:
            "Magic"
        case .rain:
            "Rain"
        case .snow:
            "Snow"
        case .sparks:
            "Sparks"
        }
    }
}
