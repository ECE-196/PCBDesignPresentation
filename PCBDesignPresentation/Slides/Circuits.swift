//
//  Circuits.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 3/26/23.
//

import Foundation
import SwiftUI
import PresentationKit

class Circuits: SlideModel {
    let name: String = "Circuits"
    let duration: CGFloat = 6
    var transition: PresentationKit.Transition = .fade
    var teleprompt: [String]? = [
        "Now, can someone tell me what this is? [Schematic]",
        "How about this? You guys should be very familiar with this! [Breadboard]",
        "Or this? [PCB]",
        "These are *all* circuits!",
        "They're just different ways to manifest a circuit in the world.",
        "We're going to focus on the relationship between these particular representations of circuits.\nCan someone tell me why you may want to make a PCB as opposed to using a breadboard? So what *is* a PCB? Like what exactly makes them up?"
    ]
    
    func view(t: CGFloat, scale: CGFloat) -> AnyView {
        AnyView(
            CircuitsView(t: t, scale: scale)
                .environmentObject(self)
        )
    }
}

struct CircuitsView: SlideView {
    @EnvironmentObject var model: Circuits
    
    var t: CGFloat
    var scale: CGFloat
    
    var body: some View {
        VStack {
            if t == 3 {
                Text("CIRCUITS")
                    .font(.system(size: 400 * scale))
                    .bold()
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            HStack {
                VStack {
                    Image("circuits_schematic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: (t >= 1 ? 64 : 0) * scale))
                    
                    if t >= 3 {
                        Text("Schematic")
                            .font(.system(size: 100 * scale))
                            .italic()
                            .opacity(t >= 4 ? 1 : 0)
                            .offset(y: t >= 4 ? 0 : 100 * scale)
                            .animation(Presentation.animation, value: t)
                    }
                }
                
                if (1...4).contains(t) {
                    VStack {
                        Image("circuits_breadboard")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 64 * scale))
                        
                        if t >= 3 {
                            Text("Breadboard")
                                .font(.system(size: 100 * scale))
                                .italic()
                                .opacity(t >= 4 ? 1 : 0)
                                .offset(y: t >= 4 ? 0 : 100 * scale)
                                .animation(Presentation.animation.delay(0.1), value: t)
                        }
                    }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .scale))
                }
                
                if t >= 2 {
                    VStack {
                        Image("circuits_pcb")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 64 * scale))
                        
                        if t >= 3 {
                            Text("PCB")
                                .font(.system(size: 100 * scale))
                                .italic()
                                .opacity(t >= 4 ? 1 : 0)
                                .offset(y: t >= 4 ? 0 : 100 * scale)
                                .animation(Presentation.animation.delay(t <= 4 ? 0.2 : 0), value: t)
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
            }
        }
        .padding((t >= 1 ? 100 : 0) * scale)
    }
}
