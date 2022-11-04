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
    @State private var volumeForCpt = 0
    @State private var volumeInPercentage = 0
    @State private var showProfileSheet = false
    @State private var goalReached = false
    @State var alreadyCongrats = false
    @State private var showCongratsSheet = false
    
    let date: Date
    let dateFormatter: DateFormatter
        
    init() {
        date = Date()
        dateFormatter = DateFormatter()
      //  dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "E d MMM" // OR "dd-MM-yyyy"
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                if showCongratsSheet {
                    GoalReachedView(alreadyCongrats: $alreadyCongrats)
                        .presentationDetents([.fraction(0.5)])
                        .opacity(showCongratsSheet ? 1.0 : 0.0)
                }
                
                VStack {
                    WeekView()
                    
                    Spacer()
                    
                    Text(date, formatter: dateFormatter)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.purple)

                    
                    ZStack {
                        MainRingView(volumeInPercent: $volumeInPercentage)
                            .padding()
                        if volumeInPercentage >= 100 {
                          //  ConfettisView()
                        }
                    }
                    HStack {
                        Image(systemName: "trophy")
                        
                        HStack(spacing: 0) {
                            RollingText(font: .body, weight: .regular, value: $volumeForCpt)
                            Text(String(" / " + String(format: "%.0f", profile[0].goal) + " cl"))
                        }
                            
                     //   Text(String(format: "%.0f",volume) + " / " +
                       //      String(format: "%.0f", profile[0].goal) + " cl")
                    }
                    .frame(width: 190, height: 40)
                    .foregroundColor(.purple)
                    .fontWeight(.regular)
                    .background(Capsule().fill(Color(.systemGray6)))
                    .padding()
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        PlusButtonView(volume: $volume, goal: profile[0].goal)
                    }
                    .padding()
                }
                .blur(radius: showCongratsSheet ? 20 : 0)
                .disabled(showCongratsSheet)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showProfileSheet = true
                        } label: {
                            Image(systemName: "gear")                    }
                    }
                }
            }
        }
        
        .onChange(of: volume) { newVolume in
            volumeInPercentage = Int(computePercentage(goal: profile[0].goal, drinkedVolume: newVolume))
            volumeForCpt = Int(volume)
            if volumeInPercentage > 100 {
                volumeInPercentage = 100
                goalReached = true
                showCongratsSheet = goalReached && !alreadyCongrats
            }
        }
        .onChange(of: alreadyCongrats) { newCongrats in
            showCongratsSheet = goalReached && !newCongrats
        }
        .sheet(isPresented: $showProfileSheet) {
            SettingsView(showProfileSheet: $showProfileSheet)
        }
    
        //        .sheet(isPresented: $showCongratsSheet, onDismiss: {
        //            alreadyCongrats = true
        //        }) {
        //            GoalReachedView()
        //                .presentationDetents([.fraction(0.5)])
        //        }
        
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


