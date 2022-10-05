//
//  AddContainerView.swift
//  Hydrate
//
//  Created by David Laiymani on 12/09/2022.
//

import SwiftUI

struct AddContainerView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipientViewModel: RecipientsViewModel
    @Environment(\.managedObjectContext) private var viewContext

    
    @State private var name: String = ""
    @State private var volume: String = ""
    @State private var showingIconSheet = false
    @State private var isShowingAlert = false
    
    
    @State var iconString: String = "rectangle.roundedbottom"
    @State var colorString: String = "Salmon"
    
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Name") {
                        TextField("Enter the name", text: $name)
                    }
                    
                    Section("Volume") {
                        HStack {
                            TextField("Enter the Volume", text: $volume)
                                .keyboardType(.decimalPad)
                            Text("cl")
                        }
                    }
                    
                    Section("Icon") {
                        IconPickerView(iconString: $iconString)
                    }
                    Section("Color") {
                        ColorPickerView(colorString: $colorString)
                    }
                    
                }
            }
            .navigationTitle("New Container")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(Color(.systemGray2))
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if (name.count == 0) {
                            alertMessage = "Your name must be at least 1 character long 🥲"
                            isShowingAlert = true
                        } else {
                            if volume.count == 0 {
                                alertMessage = "Your must specify a volume for your recipient 🥲"
                                isShowingAlert = true
                            } else {
                                let recipient = Recipient(name: name, icon: iconString, volume: Double(volume)!, color: colorString, isFavorite: false)
                                recipientViewModel.addRecipient(recipient: recipient)
                                dismiss()
                            }
                        }
                        
                    } label: {
                        Text("Add")
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .overlay(content: {
                                Capsule().fill(Color.purple.opacity(0.05))
                            })
                    }
                    .alert(isPresented: $isShowingAlert, content: {
                        Alert(title: Text(alertMessage))
                    })
                }
                
            }
            
        }

    }
}

//struct AddContainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEditContainerView()
//    }
//}
