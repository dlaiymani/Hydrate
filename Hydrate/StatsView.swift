//
//  StatsView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

enum StatsType: String, CaseIterable, Identifiable {
    case week
    case month
    case year
    
    var id: String { self.rawValue }
}

struct StatsView: View {
    
    @State var stateType: StatsType = .week
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
            
            NavigationStack {
                VStack(alignment: .leading) {
                    Picker("Stats type", selection: $stateType) {
                        ForEach(StatsType.allCases) { type in
                            Text(type.rawValue.capitalized)
                                .tag(type)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                   // .background(.white)
                    .overlay {
                        Capsule()
                            .fill(Color.gray)
                    }
                    
                    Spacer()
                }
                
                .navigationBarTitleDisplayMode(.large)
                .navigationBarTitle(Text("Stats"))
            }
        }
        
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
