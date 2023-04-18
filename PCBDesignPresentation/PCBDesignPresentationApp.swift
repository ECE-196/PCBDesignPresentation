//
//  PCBDesignPresentationApp.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 3/25/23.
//

import SwiftUI

@main
struct PCBDesignPresentationApp: App {
    @StateObject var model = Presentation(slides: [
        Loading(),
        Title(),
        Circuits(),
        PCBRender(),
        ECETimeline(),
        KiCAD()
    ])
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
        .commands {
            CommandMenu("Control") {
                Text("Current frame: \(Int(model.keyframe))")
                
                Button("Next Keyframe") {
                    model.nextKeyframe()
                }
                .keyboardShortcut("N")
                
                Button("Previous Keyframe") {
                    model.prevKeyFrame()
                }
                .keyboardShortcut("B")
            }
        }
    }
}
