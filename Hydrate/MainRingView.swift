//
//  MainRIngView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

struct MainRingView: View {
    
    @Binding var volumeInPercent: Double
    
    var body: some View {
        ZStack {
            Gauge(value: volumeInPercent, in: 0...100) {
                Text("cl")
            } currentValueLabel: {
                VStack {
                    Text(volumeInPercent.formatted())
                       // .font(.title3)
                    Text("cl")
                        .font(.system(size: 8))
                        .foregroundColor(.secondary)
                }
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(.purple)
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
