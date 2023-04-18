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
    
    let slides: [any SlideModel]
    
    var currentSlide: (any SlideModel)? {
        if let index = countSlides(to: keyframe) {
            return slides[index]
        }
        
        return nil
    }
    
    init(slides: [any SlideModel]) {
        self.slides = slides
    }
    
    func nextKeyframe() {
        withAnimation(Self.animation) {
            keyframe += 1
        }
    }
    
    func prevKeyFrame() {
        withAnimation(Self.animation) {
            if keyframe > 0 {
                keyframe -= 1
            }
        }
    }
    
    func countFrames(to slideIndex: Int) -> CGFloat {
        return slides[..<slideIndex].map({ frame in frame.duration }).reduce(0, { partialResult, length in partialResult + length })
    }
    
    func countSlides(to frame: CGFloat) -> Int? {
        var frameTotal = 0.0
        
        for (i, slide) in slides.enumerated() {
            frameTotal += slide.duration
            
            if frameTotal > frame {
                return i
            }
        }
        
        return nil
    }
}

struct PresentationView: View {
    @EnvironmentObject var model: Presentation
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    Color.init(red: 36/255, green: 37/255, blue: 56/255)
                    
                    let t = model.keyframe
                    let scale = min(CGFloat(geometry.size.width) / 3840, CGFloat(geometry.size.height) / 2160)
                    
                    ForEach(0..<model.slides.count, id: \.self) { index in
                        let local_t = t - model.countFrames(to: index)
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
            
            TimelineView()
                .environmentObject(model)
        }
    }
}
