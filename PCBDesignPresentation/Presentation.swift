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
    
    let slides: [any FrameModel]
    
    init(slides: [any FrameModel]) {
        self.slides = slides
    }
    
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

struct PresentationView: View {
    @EnvironmentObject var model: Presentation
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.init(red: 36/255, green: 37/255, blue: 56/255)
                
                let t = model.keyframe
                let scale = min(CGFloat(geometry.size.width) / 3840, CGFloat(geometry.size.height) / 2160)
                
                ForEach(0..<model.slides.count, id: \.self) { index in
                    let local_t = t - model.slides[..<index].map({ frame in frame.duration }).reduce(0, { partialResult, length in partialResult + length })
                    let duration = model.slides[index].duration

                    if local_t >= -1 && local_t <= duration {
                        model.slides[index].view(t: local_t, scale: scale)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .opacity((0..<duration).contains(local_t) ? 1 : 0)
                            .animation(Presentation.animation, value: t)
                    }
                }
            }
        }
    }
}
