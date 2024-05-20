//
//  visionBallDropApp.swift
//  visionBallDrop
//
//  Created by Allison on 5/20/24.
//

import SwiftUI

@main
struct visionBallDropApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .defaultSize(width: 200, height: 200)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
