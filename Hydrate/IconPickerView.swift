//
//  IconPickerView.swift
//  Hydrate
//
//  Created by David Laiymani on 12/09/2022.
//

import SwiftUI

struct IconPickerView: View {
    @Environment(\.dismiss) var dismiss
    
    let symbols = ["wineglass", "wineglass.fill", "rectangle.roundedbottom", "rectangle.roundedbottom.fill", "rectangle.portrait.bottomhalf.filled", "cup.and.saucer", "cup.and.saucer.fill",
                   "takeoutbag.and.cup.and.straw", "takeoutbag.and.cup.and.straw.fill"]
    
    @State private var selectedIndex = 6
    
    @Binding var iconString: String
    
    let rows = [
        GridItem(.fixed(40)),
        GridItem(.fixed(40))
    ]

    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 40) {
                ForEach(Array(symbols.enumerated()), id: \.offset) { index, item in
                    ZStack {
                        Button {
                       //     selectedIndex = index
                            iconString = symbols[index]
                        } label: {
                            if (item == iconString) {
                                Image(systemName: item)
                                    .font(.title2)
                                    .foregroundColor(.purple)
                                    .padding(8)
                                    .overlay(content: {
                                        RoundedRectangle(cornerRadius: 11)
                                            .foregroundColor(Color.purple.opacity(0.1))
                                    })
                            } else {
                                Image(systemName: item)
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            print(iconString)
        }
    }
}


//struct IconPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        IconPickerView()
//    }
//}
