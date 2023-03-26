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
        PresentationView()
            .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
