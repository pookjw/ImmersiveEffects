//
//  ContentView.swift
//  ImmersiveEffects
//
//  Created by Jinwoo Kim on 5/30/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @Binding private var selectedEffect: Effect?
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    init(selectedEffect: Binding<Effect?>) {
        _selectedEffect = selectedEffect
    }

    var body: some View {
        List(Effect.allCases, id: \.self, selection: $selectedEffect) { effect in
            Text(effect.title)
        }
        .toolbar { 
            ToolbarItem(placement: .topBarTrailing) { 
                Toggle(isOn: $showImmersiveSpace) {}
            }
        }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
}
