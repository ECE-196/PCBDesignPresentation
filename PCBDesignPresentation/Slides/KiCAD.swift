//
//  KiCAD.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 4/15/23.
//

import Foundation
import SwiftUI

class KiCAD: SlideModel {
    let name: String = "KiCAD"
    let duration: CGFloat = 2
    
    func view(t: CGFloat, scale: CGFloat) -> AnyView {
        AnyView(
            KiCADView(t: t, scale: scale)
                .environmentObject(self)
        )
    }
}

struct KiCADView: SlideView {
    @EnvironmentObject var model: KiCAD
    
    var t: CGFloat
    var scale: CGFloat
    
    var body: some View {
        ZStack {
            VStack {
                if t > 0 {
                    Color.clear
                        .frame(width: 1000 * scale, height: 1000 * scale)
                }
                
                HStack {
                    let size = (t > 0 ? 500 : 0) * scale
                    
                    Image("eeschema")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size, height: size)
                    
                    Image("pcbnew")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size, height: size)
                }
            }
            
            VStack {
                Image("kicad")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 1000 * scale, height: 1000 * scale)
                    .scaleEffect(t >= 0 ? 1 : 0)
                
                
                if t > 0 {
                    HStack {
                        Color.clear
                            .frame(width: 500 * scale, height: 500 * scale)
                        
                        Color.clear
                            .frame(width: 500 * scale, height: 500 * scale)
                    }
                }
            }
        }
    }
}
