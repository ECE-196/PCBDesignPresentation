//
//  Frame.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 3/25/23.
//

import Foundation
import SwiftUI

protocol FrameModel: ObservableObject {
    var name: String { get }
    var duration: CGFloat { get }
    
    func view(t: CGFloat, scale: CGFloat) -> AnyView
}

protocol FrameView: View {
    var t: CGFloat { get set }
    var scale: CGFloat { get set }
}
