//
//  ECETimeline.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 4/15/23.
//

import Foundation
import SwiftUI

class ECETimeline: SlideModel {
    let name: String = "Timeline"
    let duration: CGFloat = 1
    
    func view(t: CGFloat, scale: CGFloat) -> AnyView {
        AnyView(
            ECETimelineView(t: t, scale: scale)
                .environmentObject(self)
        )
    }
}

struct CheckpointView: View {
    let topText: String
    let bottomText: String
    
    let scale: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8 * scale)
                .frame(width: 16 * scale, height: 60 * scale)
            
            VStack {
                Text(topText)
                    .font(.system(size: 50 * scale))
                
                Spacer()
                    .frame(height: 80)
                
                Text(bottomText)
                    .font(.system(size: 50 * scale))
            }
        }
    }
}

struct ECETimelineView: SlideView {
    @EnvironmentObject var model: ECETimeline
    
    var t: CGFloat
    var scale: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20 * scale)
                .foregroundColor(.white.opacity(0.2))
                .frame(width: t >= 0 ? 2640 * scale : 0, height: 40 * scale)
                .animation(Presentation.animation.delay(0.5), value: t)
            
            HStack {
                CheckpointView(topText: "Today", bottomText: "April 17th",  scale: scale)
                    .frame(maxWidth: .infinity)
                    .offset(y: t >= 0 ? 0 : 300 * scale)
                    .opacity(t >= 0 ? 1 : 0)
                    .animation(Presentation.animation.delay(1), value: t)
                
                CheckpointView(topText: "Peer Review", bottomText: "April 26th",  scale: scale)
                    .frame(maxWidth: .infinity)
                    .offset(y: t >= 0 ? 0 : 300 * scale)
                    .opacity(t >= 0 ? 1 : 0)
                    .animation(Presentation.animation.delay(1.1), value: t)
                
                CheckpointView(topText: "TA Review - Round 1", bottomText: "May 1st",  scale: scale)
                    .frame(maxWidth: .infinity)
                    .offset(y: t >= 0 ? 0 : 300 * scale)
                    .opacity(t >= 0 ? 1 : 0)
                    .animation(Presentation.animation.delay(1.2), value: t)
                
                CheckpointView(topText: "TA Review - Round 2", bottomText: "May 3rd",  scale: scale)
                    .frame(maxWidth: .infinity)
                    .offset(y: t >= 0 ? 0 : 300 * scale)
                    .opacity(t >= 0 ? 1 : 0)
                    .animation(Presentation.animation.delay(1.3), value: t)
                
                CheckpointView(topText: "PCBs Due", bottomText: "May 5th",  scale: scale)
                    .frame(maxWidth: .infinity)
                    .offset(y: t >= 0 ? 0 : 300 * scale)
                    .opacity(t >= 0 ? 1 : 0)
                    .animation(Presentation.animation.delay(1.4), value: t)
            }
            .padding(600 * scale)
        }
    }
}
