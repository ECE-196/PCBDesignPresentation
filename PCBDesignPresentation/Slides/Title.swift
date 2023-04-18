//
//  Title.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 3/25/23.
//

import Foundation
import SwiftUI

class Title: SlideModel {
    let name: String = "Title"
    let duration: CGFloat = 2
    
    func view(t: CGFloat, scale: CGFloat) -> AnyView {
        AnyView(
            TitleView(t: t, scale: scale)
                .environmentObject(self)
        )
    }
}

struct TitleView: SlideView {
    @EnvironmentObject var model: Title
    
    var t: CGFloat
    var scale: CGFloat
    
    var body: some View {
        ZStack {
            Color.init(red: 36/255, green: 37/255, blue: 56/255) // hack to hide loading text mask
            
            VStack(alignment: .leading) {
                Text("PCB Design")
                    .font(.system(size: 300 * scale))
                    .fontWeight(.bold)
                    .offset(y: t >= 1 ? 0 : 100 * scale)
                    .opacity(t >= 1 ? 1 : 0)
                    .animation(Presentation.animation, value: t)
                
                Text("ECE 196")
                    .font(.system(size: 150 * scale))
                    .fontWeight(.medium)
                    .offset(y: t >= 1 ? 0 : 100 * scale)
                    .opacity(t >= 1 ? 1 : 0)
                    .animation(Presentation.animation.delay(0.1), value: t)
                
                Text("By Adin Ackerman")
                    .font(.system(size: 100 * scale))
                    .fontWeight(.thin)
                    .italic()
                    .foregroundColor(.secondary)
                    .offset(y: t >= 1 ? 0 : 100 * scale)
                    .opacity(t >= 1 ? 1 : 0)
                    .animation(Presentation.animation.delay(0.2), value: t)
            }
        }
    }
}
