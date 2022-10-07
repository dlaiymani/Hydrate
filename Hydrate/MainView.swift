///
//  ContentView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

struct MainView: View {
    
    @FetchRequest(sortDescriptors: []) var profile: FetchedResults<ProfileEntity>

    @State private var volumeInPercent = 0.0
    @State private var showProfileSheet = false
    
  //  @EnvironmentObject var recipientViewModel: RecipientsViewModel

    @StateObject var recipientVM = RecipientsViewModel()
    
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
                    Text(String(format: "%.2f",volumeInPercent) + "% / " + String(format: "%.0f", profile[0].goal) + " cl")
                   // Text(String(format: "%.2f % / %.0f cl",volumeInPercent, profile[0].goal))

                }
                .frame(width: 170, height: 40)
                .foregroundColor(.accentColor)
                .fontWeight(.bold)
                .background(Capsule().fill(Color(.systemGray6)))
                .padding()
                
                Spacer()
                
                HStack(alignment: .center) {
                    PlusButtonView(volumeInPercent: $volumeInPercent)
                }
                .padding()
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showProfileSheet = true
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.purple)
                    }
                }
            }
            .onAppear {
               // recipientViewModel.loadRecipients()
            }
        }
        .sheet(isPresented: $showProfileSheet) {
            SettingsView(showProfileSheet: $showProfileSheet)
        }
        
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


