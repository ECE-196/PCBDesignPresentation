//
//  Presentation.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 3/25/23.
//

import Foundation
import SwiftUI

class Presentation: ObservableObject {
    @Published var keyframe: CGFloat = 0
    
    static let animation: Animation = Animation.spring(response: 0.5, dampingFraction: 1, blendDuration: 1)
    
    let slides: [some FrameModel] = [
        Title()
    ]
    
    func nextKeyframe() {
        withAnimation(Self.animation) {
            keyframe += 1
        }
    }
    
    func prevKeyFrame() {
        withAnimation(Self.animation) {
            keyframe -= 1
        }
    }
}
