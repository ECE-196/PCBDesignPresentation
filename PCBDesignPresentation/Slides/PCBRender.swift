//
//  PCBRender.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 4/3/23.
//

import Foundation
import SwiftUI
import AVKit
import PresentationKit

class PCBRender: SlideModel {
    let name: String = "PCB Render"
    let duration: CGFloat = 13
    var transition: PresentationKit.Transition = .fade
    var teleprompt: [String]? = [
        "Here's an old PCB of mine that we are going to explore. As you can see, the components (the circuit elements) sit on top of the board.",
        "Underneath, the copper is exposed to be soldered to the component pads. Components that sit on the board like this are called Surface Mounted Components (SMD).\nA PCB is basically a rats nest of wires...",
        "...segmented as layers of copper. These pillars you see are how these layers can connect to each other (vias). All this is represented in your computer...",
        "...like this. Different colors indicate different layers.",
        "The top layer...",
        "...inner layers...",
        "...",
        "...and the bottom layer...",
        "...make up our hand crafted circuit sandwich. Delicious.",
        "Let's focusing in on one component.",
        "This footprint corresponds to this symbol in the schematic.",
        "The pins on the schematic also correspond to the pads on the footprint. These are the areas of exposed copper that...",
        "...touch the component on its little pins.\nOk, Adin, you sold me, how can I design my own PCB. Well, we are going to use a really special tool called...",
    ]
    
    func view(t: CGFloat, scale: CGFloat) -> AnyView {
        AnyView(
            PCBRenderView(t: t, scale: scale)
                .environmentObject(self)
        )
    }
}

/// This implementation is pretty gross
struct PCBRenderView: SlideView {
    @EnvironmentObject var model: PCBRender
    
    var t: CGFloat
    var scale: CGFloat
    
    @State var players: [AVPlayer]?
    
    var body: some View {
        ZStack {
            if let players {
                ForEach(0..<players.count, id: \.self) { i in
                    let player = players[i]
                    AVPlayerControllerRepresented(player: player)
                        .opacity(i <= Int(t) ? 1 : 0)
                }
                .animation(.none, value: t)
            } else {
                Text("Error loading video.")
            }
        }
        .onAppear {
            players = (1...Int(model.duration)).map { index in
                AVPlayer(url: createLocalUrl(for: "pcb_\(index)", ofType: "mp4")!)
            }
        }
        .onChange(of: t) { _, newValue in
            if let players {
                if (0..<model.duration).contains(newValue) {
                    if newValue >= t {
                        players[Int(newValue)].seek(to: .zero)
                        players[Int(newValue)].play()
                    }
                }
            }
        }
    }
}
