///
//  ContentView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

struct MainView: View {
    
    @FetchRequest(sortDescriptors: []) var profile: FetchedResults<ProfileEntity>

    @State private var volume = 0.0
    @State private var volumeInPercentage = 0.0
    @State private var showProfileSheet = false
    @State private var goalReached = false
    @State private var alreadyCongrats = false
    @State private var showCongratsSheet = false
    
        
    var body: some View {
        
        NavigationStack {
            
            VStack {
                WeekView()
                
                Spacer()
                
                ZStack {
                    MainRingView(volumeInPercent: $volumeInPercentage)
                        .padding()
                    if volumeInPercentage >= 100 {
                        ConfettisView()
                    }
                }
                
                HStack {
                  Image(systemName: "trophy")
                    
                    Text(String(format: "%.0f",volume) + " / " +
                                        String(format: "%.0f", profile[0].goal) + " cl")
                }
                .frame(width: 190, height: 40)
                .foregroundColor(.purple)

                .fontWeight(.bold)
                .background(Capsule().fill(Color(.systemGray6)))
                .padding()
                
                Spacer()
                
                HStack(alignment: .center) {
                    PlusButtonView(volume: $volume)
                    
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showProfileSheet = true
                    } label: {
                        Image(systemName: "gear")                    }
                }
            }
        }
        .onChange(of: volume) { newVolume in
            volumeInPercentage = computePercentage(goal: profile[0].goal, drinkedVolume: newVolume)
            if volumeInPercentage > 100 {
                volumeInPercentage = 100
                goalReached = true
                showCongratsSheet = goalReached && !alreadyCongrats
            }
        }
        .sheet(isPresented: $showProfileSheet) {
            SettingsView(showProfileSheet: $showProfileSheet)
        }
        .sheet(isPresented: $showCongratsSheet, onDismiss: {
            alreadyCongrats = true
        }) {
                GoalReachedView()
                    .presentationDetents([.fraction(0.5)])
        }
        
    }
    
    func computePercentage(goal: Double, drinkedVolume: Double) -> Double {
        return (drinkedVolume / goal) * 100
    }
}


struct ConfettisView: View {
    var body: some View {
        Circle()
            .fill(Color.green)
            .frame(width: 12, height: 12)
            .modifier(ParticlesModifier())
        Circle()
            .fill(Color.blue)
            .frame(width: 12, height: 12)
            .modifier(ParticlesModifier())
        Circle()
            .fill(Color.red)
            .frame(width: 12, height: 12)
            .modifier(ParticlesModifier())
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}


