//
//  Slide.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 3/25/23.
//

import Foundation
import SwiftUI

protocol SlideModel: ObservableObject {
    var name: String { get }
    var duration: CGFloat { get }
    
    func view(t: CGFloat, scale: CGFloat) -> AnyView
}

protocol SlideView: View {
    var t: CGFloat { get set }
    var scale: CGFloat { get set }
}
