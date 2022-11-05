//
//  ProfileView.swift
//  Hydrate
//
//  Created by David Laiymani on 13/09/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @AppStorage("colorScheme") private var colorScheme = 0

    @Binding var showProfileSheet: Bool
    
    
    var body: some View {
        NavigationStack  {
            ZStack(alignment: .topTrailing) {
                VStack {
                    List {
                        Section("") {
                            ZStack {
                                NavigationLink(destination: Text("Hello, World!")) {
                                    EmptyView()
                                }
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Hydrate")
                                            .font(.title)
                                            .foregroundColor(.white).bold()
                                            .padding(.bottom,14)
                                        
                                        ZStack {
                                            
                                        }
                                        Text("Pro")
                                            .font(.title3).bold()
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 2)
                                            .foregroundColor(.purple)
                                            .background(Capsule().fill(Color.white))
                                        
                                    }
                                    .padding(10)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .padding(7)
                                        .foregroundColor(.purple)
                                        .background(Circle().fill(Color.white))
                                }
                            }
                    //        .listRowBackground(Color.purple.opacity(0.8))
                            .listRowBackground(LinearGradient(colors: [Color.purple, Color.indigo], startPoint: .topLeading, endPoint: .bottomTrailing))

                        }
                        
                        Section("") {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                Label {
                                    Text("Profile")
                                } icon: {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.purple)
                                }
                                .font(.body)
                            } // Sex, Weight, activity, unit, goal
                            NavigationLink {
                                AppearanceView()
                            } label: {
                                Label {
                                    Text("Appearance")
                                } icon: {
                                    Image(systemName: "paintpalette.fill")
                                        .foregroundColor(.purple)
                                }
                                .font(.body)
                            }
                            
                            NavigationLink {
                                SoundsView()
                            } label: {
                                Label {
                                    Text("Sounds and Vibrations")
                                } icon: {
                                    Image(systemName: "speaker.wave.3.fill")
                                        .foregroundColor(.purple)
                                }
                                .font(.body)
                            }
                            
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label {
                                    Text("Notifications")
                                } icon: {
                                    Image(systemName: "bell.badge")
                                        .foregroundColor(.purple)
                                }
                                .font(.body)
                            }
                            
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label {
                                    Text("Weather")
                                } icon: {
                                    Image(systemName: "cloud.sun")
                                        .foregroundColor(.purple)
                                }
                                .font(.body)
                            }
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label {
                                    Text("Siri Shortcuts")
                                } icon: {
                                    Image(systemName: "square.2.layers.3d.bottom.filled")
                                        .foregroundColor(.purple)
                                }
                                .font(.body)
                            }
                        }
                        
                        
                        Section {
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label {
                                    Text("Hydrate for Mac")
                                } icon: {
                                    Image(systemName: "laptopcomputer.and.iphone")
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label {
                                    Text("FAQ")
                                } icon: {
                                    Image(systemName: "questionmark.circle")
                                        .foregroundColor(.blue)
                                }
                                .font(.body)
                            }
                        }
                        
                        Section("Contact") {
                            HStack {
                                Label {
                                    Text("Twitter")
                                } icon: {
                                    Image(systemName: "bird")
                                        .foregroundColor(.mint)
                                }
                                
                                Spacer()
                                
                                Text("@HydrateApp")
                                    .foregroundColor(.gray)
                            }
                            HStack {
                                Label {
                                    Text("Developer")
                                } icon: {
                                    Image(systemName: "bird")
                                        .foregroundColor(.mint)
                                }
                                
                                Spacer()
                                
                                Text("@david_laiymani")
                                    .foregroundColor(.gray)
                            }
                            
                            VStack(alignment: .leading) {
                                Label {
                                    Text("Email")
                                } icon: {
                                    Image(systemName: "envelope.badge")
                                        .foregroundColor(.mint)
                                }
                                
                                Text("hydrate_app@icloud.com")
                                    .font(.subheadline)
                                    .foregroundColor(.mint)
                            }
                        }
                        
                        Section() {
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label {
                                    Text("What's New")
                                } icon: {
                                    Image(systemName: "questionmark.circle")
                                        .foregroundColor(.blue)
                                }
                            }
                            HStack {
                                Label {
                                    Text("Web Site")
                                } icon: {
                                    Image(systemName: "globe")
                                        .foregroundColor(.blue)
                                }
                                
                                Spacer()
                                
                                Text("hydrate.app")
                                    .foregroundColor(.gray)
                            }
                            
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label {
                                    Text("Privacy Policy")
                                } icon: {
                                    Image(systemName: "hand.raised.circle")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showProfileSheet = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2.weight(Font.Weight.regular))
                                .accentColor(Color(.systemGray))
                                .symbolRenderingMode(.hierarchical)

                               // .foregroundColor(.black)
                                //.foregroundColor(Color(.systemGray2))
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showProfileSheet = false
                        } label: {
                            Text("Share App")
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .overlay(content: {
                                    Capsule().fill(Color.indigo.opacity(0.05))
                                })
                        }
                    }
                    
                }
            }
            .preferredColorScheme(colorScheme == 0 ? .light : .dark)

        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showProfileSheet: .constant(true))
    }
}
