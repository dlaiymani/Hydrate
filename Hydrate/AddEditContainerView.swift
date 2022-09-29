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

    
    @State var emojisPicked: Bool = true
    @State var iconString: String = ""
    
    @Binding var recipient: RecipientEntity?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Name") {
                        TextField("Enter the name", text: $name)
                            .onAppear {
                                if let recipient = recipient {
                                    name = recipient.name ?? ""
                                } else {
                                    name = ""
                                }
                            }
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
                        .onAppear {
                        //    self.color = Color(cgColor: CGColor(red: recipient?.red, green: recipient?.green, blue: recipient?.blue, alpha: recipient?.opacity))
                        }
                    }
                    Section("Volume") {
                        HStack {
                            TextField("Enter the Volume", text: $volume)
                                .onAppear {
                                    if let recipient = recipient {
                                        volume = "\(recipient.volume)"
                                    } else {
                                        volume = ""
                                    }
                                }
                                .keyboardType(.decimalPad)
                            Text("cl")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingIconSheet) {
                IconPickerView(emojisPicked: $emojisPicked, iconString: $iconString)
            }
            .alert(isPresented: $isShowingAlertName, content: {
                Alert(title: Text("Your name must be at least 1 character long 😪"))
            })
            .alert(isPresented: $isShowingAlertVolume, content: {
                Alert(title: Text("Your must specify a volume for your recipient 😪"))
            })
            .navigationTitle("New Container")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let recipient = recipient {
                            recipientViewModel.deleteRecipient(recipient)
                        }
                        
                        if (name.count == 0) {
                            isShowingAlertName = true
                        } else {
                            if volume.count == 0 {
                                isShowingAlertVolume = true
                            } else {
                                let color = UIColor(color).cgColor
                                let recipient = Recipient(name: name, icon: iconString, volume: Double(volume)!, red: color.components![0], green: color.components![1], blue: color.components![2], opacity: color.components![3], isFavorite: false)
                                recipientViewModel.addRecipient(recipient: recipient)
                                dismiss()
                            }
                        }
                        
                        
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
