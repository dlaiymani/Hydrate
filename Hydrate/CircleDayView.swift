//
//  CircleDayView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

struct CircleDayView: View {
    var volumeInPercent: Double
    var day: String
    var currentDay: Bool

    var body: some View {
        VStack {
            if currentDay {
                Text(day)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.white)
                    .background(Color.purple)
                    .clipShape(Circle())
            } else {
                Text(day)
                    .foregroundColor(.purple)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
                
                
            
            Gauge(value: volumeInPercent, in: 0...100) {
                Text("cl")
            } currentValueLabel: {
                  
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(.purple)
            
            
        }
        
    }
}

struct CircleDayView_Previews: PreviewProvider {
    static var previews: some View {
        CircleDayView(volumeInPercent: 25, day: "M", currentDay: true)
    }
}
