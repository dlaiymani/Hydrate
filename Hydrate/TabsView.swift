//
//  TabView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

enum DefaultSettings {
    static let darkMode = false
}

struct TabsView: View {
    
    @AppStorage("colorScheme") private var colorScheme = 0

    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "drop.fill")
                    Text("Hydrate")
                }
            
            StatsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
            
            GridContainersView()
                .tabItem {
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                    Text("Containers")
                }
        }
        .accentColor(.purple)
        .preferredColorScheme(colorScheme == 0 ? .light : .dark)

       
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()

    }
}
