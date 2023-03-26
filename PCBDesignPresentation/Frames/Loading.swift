//
//  Loading.swift
//  PCBDesignPresentation
//
//  Created by Adin Ackerman on 3/25/23.
//

import Foundation
import SwiftUI

class Loading: FrameModel {
    var name: String = "Loading"
    var duration: CGFloat = 1
    
    let startTime = "11:42 AM"
    
    @Published var formatter: DateFormatter
    var timer: Timer = Timer()
    @Published var counter: Int = 0
    @Published var flag1: Bool = false
    @Published var flag2: Bool = false
    
    var begin: Bool {
        let components1 = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let components2 = Calendar.current.dateComponents([.hour, .minute], from: formatter.date(from: startTime)!)
        
        let seconds1 = components1.hour! * 60 + components1.minute!
        let seconds2 = components2.hour! * 60 + components2.minute!
        
        return seconds1 >= seconds2
    }
    
    init() {
        formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        timer = .scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { time in
            if self.counter == 19 {
                self.counter = 0
            } else {
                self.counter += 1
            }
            
            if [19, 0, 9, 10].contains(self.counter) {
                self.flag2.toggle()
            }
            
            if self.counter % 10 == 0 {
                self.flag1.toggle()
            }
        })
    }
    
    func view(t: CGFloat, scale: CGFloat) -> AnyView {
        AnyView(
            LoadingView(t: t, scale: scale)
                .environmentObject(self)
        )
    }
}

struct LoadingView: FrameView {
    @EnvironmentObject var model: Loading
    
    var t: CGFloat
    var scale: CGFloat
    
    var body: some View {
        VStack {
            let date = Date.now
            
            
            // clock
            Text(model.formatter.string(from: date))
                .font(.system(size: (model.begin ? 400 : 200) * scale))
                .bold()
            
            // loading animation
            if !model.begin {
                Rectangle()
                    .fill(.primary)
                    .frame(width: (model.flag2 ? 100 : 50) * scale, height: 50 * scale)
                    .offset(x: (model.flag1 ? -100 : 100) * scale)
                    .animation(.spring(response: 0.2, dampingFraction: 0.65), value: model.counter)
            }
            
            // footer message
            Text(model.begin ? "Time to begin!" : "Awesome presentation loading...")
                .font(.system(size: (model.begin ? 100 : 50) * scale))
                .fontWeight(model.begin ? .regular : .light)
                .foregroundColor(.secondary)
                .padding((model.begin ? 10 : 100) * scale)
        }
    }
}
