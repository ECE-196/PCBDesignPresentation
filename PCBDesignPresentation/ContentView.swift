//
//  ContentView.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 3/25/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Presentation
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.init(red: 36/255, green: 37/255, blue: 56/255)
                
                let t = model.keyframe
                let scale = min(CGFloat(geometry.size.width) / 3840, CGFloat(geometry.size.height) / 2160)
                
                ForEach(0..<model.slides.count, id: \.self) { index in
                    let local_t = t - model.slides[..<index].map({ frame in frame.duration }).reduce(0, { partialResult, length in partialResult + length})
                    let duration = model.slides[index].duration
                    
                    if local_t >= -1 && local_t <= duration {
                        model.slides[index].view(t: t, scale: scale)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .opacity((0..<duration).contains(local_t) ? 1 : 0)
                            .animation(Presentation.animation, value: t)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
