//
//  ImmersiveEffectsApp.swift
//  ImmersiveEffects
//
//  Created by Jinwoo Kim on 5/30/24.
//

import SwiftUI

@main
struct ImmersiveEffectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .mixed)
    }
}
