///
//  ContentView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

struct MainView: View {
    @State private var volumeInPercent = 50.0
    var minVolume = 0.0
    var maxVolume = 100.0
    var body: some View {
        
        NavigationStack {
            VStack {
                WeekView()
                //       .padding(.top, 40)
                Spacer()
                
                MainRingView(volumeInPercent: $volumeInPercent)
                    .padding()
                
                HStack {
                    Image(systemName: "goforward")
                    Text("50% / 2000 cl")
                }
                .frame(width: 170, height: 40)
                .foregroundColor(.accentColor)
                .fontWeight(.bold)
                .background(Capsule().fill(Color(.systemGray6)))
                .padding()
                
                Spacer()
                
                HStack(alignment: .center) {
                    PlusButtonView()
                }
                .padding()
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: StatsView()) {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.purple)
                    }
                }
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


