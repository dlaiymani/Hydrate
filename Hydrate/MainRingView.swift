//
//  MainRIngView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

struct MainRingView: View {
    
    @Binding var volumeInPercent: Int
    
    let gradient = Gradient(colors: [.purple, .indigo])
    
    var body: some View {
        
        ZStack {
            
            Gauge(value: Double(volumeInPercent), in: 0...100) {
                
            } currentValueLabel: {
                VStack {
                    HStack(spacing: 0) {
                        RollingText(font: .caption, weight: .regular, value: $volumeInPercent)
                        Text("%")
                            .font(.caption)
                    }
                }
                .foregroundColor(Color.purple)
            }
            
            .tint(gradient)
            .gaugeStyle(.accessoryCircular)
            .scaleEffect(3.5)
        }
        .frame(width: 200, height: 200)
    }
}

struct MainRIngView_Previews: PreviewProvider {
    static var previews: some View {
        MainRingView(volumeInPercent: .constant(33))
    }
}
