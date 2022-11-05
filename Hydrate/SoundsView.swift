//
//  SoundsView.swift
//  Hydrate
//
//  Created by David Laiymani on 05/11/2022.
//

import SwiftUI

struct SoundsView: View {
    
    @AppStorage("colorScheme") private var colorScheme = 0
    @AppStorage("sounds") private var soundIsOn = true
    @AppStorage("vibrations") private var vibrationIsOn = true
    

    var body: some View {
        VStack {
            List {
                Section(header: Text("")) {
                    HStack {
                        Toggle(isOn: $soundIsOn) {
                            Label {
                                Text("Sounds")
                            } icon: {
                                Image(systemName: "speaker.wave.3.fill")
                                    .foregroundColor(.purple)
                            }
                            .font(.body)
                        }
                        .tint(.accentColor)
                    }
                    
                } // End Section
                Section() {
                    
                    Toggle(isOn: $vibrationIsOn) {
                        Label {
                            Text("Vibrations")
                        } icon: {
                            Image(systemName: "hand.tap.fill")
                                .foregroundColor(.purple)
                        }
                        .font(.body)
                    }
                    .tint(.accentColor)
                }// End Section
                
            }
           // .listStyle(.insetGrouped)
           // .padding()
        }
        .navigationTitle("Sounds and Vibrations")

    }
}

struct SoundsView_Previews: PreviewProvider {
    static var previews: some View {
        SoundsView()
    }
}
