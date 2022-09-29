//
//  ColorPickerView.swift
//  Hydrate
//
//  Created by David Laiymani on 29/09/2022.
//

import SwiftUI

struct ColorPickerView: View {
    let colors = ["Maraschino", "Salmon", "Tangerine", "Lemon", "Cantaloupe", "Aqua", "Sky",
                   "Clover", "SeaFoam", "Lavender", "Plum"]
    
    @State private var selectedIndex = 6
    
    @Binding var colorString: String
    
    let rows = [
        GridItem(.fixed(40)),
        GridItem(.fixed(40))

    ]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 40) {
                ForEach(Array(colors.enumerated()), id: \.offset) { index, item in
                    ZStack {
                        Button {
                            colorString = colors[index]
                        } label: {
                            if (item == colorString) {
                                RoundedRectangle(cornerRadius: 11)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(item))
                                    .padding(8)
                                    .overlay(content: {
                                        RoundedRectangle(cornerRadius: 11)
                                            .foregroundColor(Color(item).opacity(0.1))
                                    })
                            } else {
                                RoundedRectangle(cornerRadius: 11)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(item))
                                    .padding(8)
                                    
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

//struct ColorPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorPickerView()
//    }
//}
