//
//  IconPickerView.swift
//  Hydrate
//
//  Created by David Laiymani on 12/09/2022.
//

import SwiftUI

struct IconPickerView: View {
    @Environment(\.dismiss) var dismiss
    
    let emojis = ["🍺", "🍷", "🍸", "🥃", "🍹", "🥛", "🥂", "🧋", "☕️", "🥤", "🧉", "🍵", "🍼"]
    
    let symbols = ["wineglass", "wineglass.fill", "rectangle.roundedbottom", "rectangle.roundedbottom.fill", "rectangle.portrait.bottomhalf.filled", "cup.and.saucer", "cup.and.saucer.fill",
    "takeoutbag.and.cup.and.straw", "takeoutbag.and.cup.and.straw.fill"]
    
    @State private var selectedIndex = IndexPath(row: 0, section: 9)

    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                Section {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(emojis.enumerated()), id: \.offset) { index, item in
                            ZStack {
                                Button {
                                    selectedIndex = IndexPath(row: 0, section: index)
                                } label: {
                                    if (selectedIndex.row == 0) && (index == selectedIndex.section) {
                                        Text(item)
                                            .font(.title)
                                            .background(
                                                Capsule().fill(Color(.systemGray4))
                                                    .frame(width: 40, height: 40))
                                    } else {
                                        Text(item)
                                            .font(.title)
                                    }
                                }
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Emojis")
                        Spacer()
                    }
                    .foregroundColor(.accentColor)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                }

                Section {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(symbols.enumerated()), id: \.offset) { index, item in
                            ZStack {
                                Button {
                                    selectedIndex = IndexPath(row: 1, section: index)
                                } label: {
                                    if (selectedIndex.row == 1) && (index == selectedIndex.section) {
                                        Image(systemName: item)
                                            .font(.title2)
                                            .foregroundColor(.black)
                                            .background(
                                                Capsule().fill(Color(.systemGray4))
                                                    .frame(width: 40, height: 40))
                                    } else {
                                        Image(systemName: item)
                                            .font(.title2)
                                            .foregroundColor(.black)
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Symbols")
                        Spacer()
                    }
                    .foregroundColor(.accentColor)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                }
                
                
            }
            .navigationTitle("Pick an Icon")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(Color(.systemGray3))
                    }
                }
            }
        }
        
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView()
    }
}
