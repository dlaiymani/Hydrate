//
//  AppearanceView.swift
//  Hydrate
//
//  Created by David Laiymani on 04/10/2022.
//

import SwiftUI




struct AppearanceView: View {
    
    @AppStorage("colorScheme") private var colorScheme = 0
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.white)
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .selected)
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
    }
    
    var body: some View {
        VStack {
            List {
                Section(header:
                    HStack {
                        Text("THEME")
                        Spacer()
                        Label("Pro", systemImage: "lock")
                            .font(.caption)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 2)
                            .foregroundColor(.purple)
                            .background(Capsule().fill(Color.white))
                    }) {
                        NavigationLink {
                            EmptyView()
                        } label: {
                            Label {
                                Text("App Icon")
                            } icon: {
                                Image(systemName: "square.dashed")
                                .foregroundColor(.purple)
                            }
                            .font(.body)
                        }
                } // End Section
                Section(header:
                    HStack {
                        Text("THEME")
                        Spacer()
                        Label("Pro", systemImage: "lock")
                            .font(.caption)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 2)
                            .foregroundColor(.purple)
                            .background(Capsule().fill(Color.white))
                    }) {
                        Picker("", selection: $colorScheme) {
                            // Text("System").tag(0)
                            Text("Light").tag(0)
                            Text("Dark").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .font(.title3)
                }// End Section
                
            }
            
        }
        .navigationTitle("Appearance")
        .preferredColorScheme(colorScheme == 0 ? .light : .dark)
    }
        
}

struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
    }
}

