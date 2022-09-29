//
//  AddContainerView.swift
//  Hydrate
//
//  Created by David Laiymani on 12/09/2022.
//

import SwiftUI

struct AddEditContainerView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipientViewModel: RecipientsViewModel
    
    
    @State private var name: String = ""
    @State private var volume: String = ""
    @State private var color = Color.cyan
    @State private var showingIconSheet = false
    @State private var isShowingAlertName = false
    @State private var isShowingAlertVolume = false
    
    
    @State var iconString: String = ""
    @State var colorString: String = ""

    
    var recipient: RecipientEntity?
    
    init(recipient: RecipientEntity?) {
        self.recipient = recipient
    }
    
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
            .onAppear {
                if let recipient = recipient {
                    name = recipient.name ?? ""
                    volume = String(recipient.volume)
                    iconString = recipient.icon ?? ""
                    colorString = recipient.color ?? ""
                } else {
                    name = ""
                    volume = ""
                    iconString = ""
                    colorString = ""
                }
            }
           
            .alert(isPresented: $isShowingAlertName, content: {
                Alert(title: Text("Your name must be at least 1 character long 😪"))
            })
            .alert(isPresented: $isShowingAlertVolume, content: {
                Alert(title: Text("Your must specify a volume for your recipient 😪"))
            })
            .navigationTitle("New Container")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(Color(.systemGray3))
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                     //   recipientViewModel.deleteRecipient(recipient!)
                        
                        
                        if (name.count == 0) {
                            isShowingAlertName = true
                        } else {
                            if volume.count == 0 {
                                isShowingAlertVolume = true
                            } else {
                              //  let color = UIColor(color).cgColor
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
                    
                }
            }
        }
        .onAppear {
            //            name = self.recipient!.name ?? ""
            //            volume = String(self.recipient.volume)
            
        }
    }
}

//struct AddContainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEditContainerView()
//    }
//}
