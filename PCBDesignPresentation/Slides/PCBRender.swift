//
//  PCBRender.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 4/3/23.
//

import Foundation
import SwiftUI
import AVKit

class PCBRender: SlideModel {
    let name: String = "PCB Render"
    let duration: CGFloat = 13
    
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
            } else {
                Text("Error loading video.")
            }
        }
        .onAppear {
            players = (1...Int(model.duration)).map { index in
                AVPlayer(url: createLocalUrl(for: "pcb_\(index)", ofType: "mp4")!)
            }
        }
        .onChange(of: t) { newValue in
            if let players {
                if (0..<model.duration).contains(newValue) {
                    if newValue > t {
                        players[Int(newValue)].seek(to: .zero)
                        players[Int(newValue)].play()
                    }
                }
            }
        }
    }
}
