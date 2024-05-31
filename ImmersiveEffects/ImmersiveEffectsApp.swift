//
//  ImmersiveEffectsApp.swift
//  ImmersiveEffects
//
//  Created by Jinwoo Kim on 5/30/24.
//

import SwiftUI

@main
struct ImmersiveEffectsApp: App {
    @State private var selectedEffect: Effect?
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(selectedEffect: $selectedEffect)
            }
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(selectedEffect: selectedEffect)
        }.immersionStyle(selection: .constant(.full), in: .mixed)
    }
}
