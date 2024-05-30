//
//  ContentView.swift
//  ImmersiveEffects
//
//  Created by Jinwoo Kim on 5/30/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
            .font(.title)
            .frame(width: 360)
            .padding(24)
            .glassBackgroundEffect()
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

#Preview(windowStyle: .automatic) {
    ContentView()
}