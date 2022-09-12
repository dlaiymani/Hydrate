//
//  AddContainerView.swift
//  Hydrate
//
//  Created by David Laiymani on 12/09/2022.
//

import SwiftUI

struct AddContainerView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var volume: String = ""
    @State private var color = Color.cyan
    @State private var showingIconSheet = false

    
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Name") {
                        TextField("Enter the name", text: $name)
                    }
                    Section("Icon") {
                        HStack {
                            Text("Icon")
                            Spacer()
                            Button {
                                showingIconSheet.toggle()
                            } label: {
                                Text("🥤")
                                    .font(.title)
                            }
                        }
                    }
                    Section("Color") {
                        ColorPicker("Color", selection: $color)
                    }
                    Section("Volume") {
                        HStack {
                            TextField("Enter the Volume", text: $volume)
                                .keyboardType(.decimalPad)
                            Text("cl")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingIconSheet) {
                IconPickerView()
            }
            .navigationTitle("New Container")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddContainerView_Previews: PreviewProvider {
    static var previews: some View {
        AddContainerView()
    }
}
