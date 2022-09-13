//
//  ProfileView.swift
//  Hydrate
//
//  Created by David Laiymani on 13/09/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var showProfileSheet: Bool


    var body: some View {
        ZStack(alignment: .topTrailing) {
            NavigationStack {
                VStack {
                    
                    // Message et icone pour passer pro
                    
                    List {
                        Section("") {
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label("Profile", systemImage: "person.fill")
                                    .foregroundColor(.purple)
                                   .font(.title3)
                            } // Sex, Weight, activity, unit, goal
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label("Notifications", systemImage: "bell.badge")
                                    .foregroundColor(.purple)
                                   .font(.title3)
                            }
                          
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label("Weather", systemImage: "cloud.sun")
                                    .foregroundColor(.purple)
                                   .font(.title3)
                            }
                        }
                        
                        
                        Section {
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label("Hydrate for Mac", systemImage: "laptopcomputer.and.iphone")
                                    .foregroundColor(.blue)
                                   .font(.title3)
                            }
                            
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label("FAQ", systemImage: "questionmark.circle")
                                    .foregroundColor(.blue)
                                   .font(.title3)
                            }
                            
                        }
                        
                        Section("Contact") {
                            HStack {
                                Label("Twitter", systemImage: "bird")
                                    .foregroundColor(Color(.systemMint))
                                    .font(.title3)
                                
                                Spacer()
                                
                                Text("@HydrateApp")
                                    .foregroundColor(.gray)
                            }
                            HStack {
                                Label("Developer", systemImage: "bird")
                                    .foregroundColor(.mint)
                                    .font(.title3)
                                
                                Spacer()
                                
                                Text("@david_laiymani")
                                    .foregroundColor(.gray)
                            }
                           
                            VStack(alignment: .leading) {
                                Label("Email", systemImage: "envelope.badge")
                                    .foregroundColor(.mint)
                                    .font(.title3)
                                
                                Text("hydrate_app@icloud.com")
                                    .font(.subheadline)
                                    .foregroundColor(.mint)

                                    
                            }
                            
                            
                        }
                        
                        Section() {
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label("What's New", systemImage: "questionmark.circle")
                                    .foregroundColor(.blue)
                                   .font(.title3)
                            }
                            HStack {
                                Label("Web Site", systemImage: "globe")
                                    .foregroundColor(.blue)
                                    .font(.title3)
                                
                                Spacer()
                                
                                Text("hydrate.app")
                                    .foregroundColor(.gray)
                            }
                            
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Label("Privacy Policy", systemImage: "hand.raised.circle")
                                    .foregroundColor(.blue)
                                    .font(.title3)
                            }
                        }
                    }
                }
                .navigationTitle("Settings")
            }
            
            Button {
                showProfileSheet = false
            } label: {
                Image(systemName: "x.circle.fill")
                    .font(.title)
                    .foregroundColor(Color(.systemGray4))
            }
            .padding()
            
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showProfileSheet: .constant(true))
    }
}
