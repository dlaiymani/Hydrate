//
//  TabView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

struct TabsView: View {
        
    //@EnvironmentObject var recipientViewModel: RecipientsViewModel
  //  @StateObject var recipientViewModel = RecipientsViewModel()


    
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
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()

    }
}
