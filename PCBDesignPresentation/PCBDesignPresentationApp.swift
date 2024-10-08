//
//  PCBDesignPresentationApp.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 3/25/23.
//

import SwiftUI
import PresentationKit

@main
struct PCBDesignPresentationApp: App {
    @StateObject var presentation = Presentation(bgColor: .init(red: 36/255, green: 37/255, blue: 56/255), slides: [
        Loading(),
        Title(),
        Circuits(),
        PCBRender(),
//        ECETimeline(),
        KiCAD()
    ])
    
    var body: some Scene {
        PresentationScene(presentation: presentation)
    }
}
