//
//  EditContainerView.swift
//  Hydrate
//
//  Created by David Laiymani on 12/09/2022.
//

import SwiftUI

struct EditContainerView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipientViewModel: RecipientsViewModel
    @Environment(\.managedObjectContext) private var viewContext

    
    @State private var name: String = ""
    @State private var volume: String = ""
    @State private var color = Color.cyan
    @State private var showingIconSheet = false
    @State private var isShowingAlertName = false
    @State private var isShowingAlertVolume = false
    
    
    @State var iconString: String = ""
    @State var colorString: String = ""
    
    var recipient: RecipientEntity
    
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
//                if let recipient = recipient {
//                    name = recipient.name ?? ""
//                    volume = String(recipient.volume)
//                    iconString = recipient.icon ?? ""
//                    colorString = recipient.color ?? ""
//                    buttonText = "Edit"
//                } else {
//                    name = ""
//                    volume = ""
//                    iconString = ""
//                    colorString = ""
//                }
            }
            
            .alert(isPresented: $isShowingAlertName, content: {
                Alert(title: Text("Your name must be at least 1 character long 😪"))
            })
            .alert(isPresented: $isShowingAlertVolume, content: {
                Alert(title: Text("Your must specify a volume for your recipient 😪"))
            })
            .navigationTitle("Edit Container")
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
                            if (name.count == 0) {
                                isShowingAlertName = true
                            } else {
                                if volume.count == 0 {
                                    isShowingAlertVolume = true
                                } else {
                                    updateRecipient()
                                    dismiss()
                                }
                            }
                        
                    } label: {
                        Text("Edit")
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
            self.name = self.recipient.name!
            self.volume = String(self.recipient.volume)
            self.iconString = self.recipient.icon!
            self.colorString = self.recipient.color!
        }
    }
    
    func updateRecipient() {
        
            self.recipient.name = self.name
            self.recipient.volume = Double(self.volume)!
            self.recipient.icon = self.iconString
            self.recipient.color = self.colorString
        do {
            let viewContext = self.recipient.managedObjectContext
            try viewContext?.save()
            
        } catch {
            fatalError("Error \(error.localizedDescription)")
        }

    }
    
}

//struct AddContainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEditContainerView()
//    }
//}
