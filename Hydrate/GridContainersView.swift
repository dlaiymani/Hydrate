//
//  NewContainer.swift
//  Hydrate
//
//  Created by David Laiymani on 10/09/2022.
//

import SwiftUI

struct GridContainersView: View {
    
    @State private var searchText = ""
    @State private var showingSheet = false
    @State private var isEditing = false
    
    @EnvironmentObject var recipientViewModel: RecipientsViewModel
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) var recipients: FetchedResults<RecipientEntity>
    
    private let numberOfColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    private var shouldShowMenu = true
    
    @State private var recipient: RecipientEntity?
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                Section {
                    LazyVGrid(columns: numberOfColumns, spacing: 20) {
                        ForEach(recipients) { container in
                            if container.isFavorite {
                                GridContainerCell(container: container)
                            }
                        }
                    }
                } header: {
                    HStack() {
                        Text(Image(systemName: "heart.fill"))
                        Text("Favorites")
                        Spacer()
                    }
                    .foregroundColor(.accentColor)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                }
                
                Section {
                    LazyVGrid(columns: numberOfColumns, spacing: 20) {
                        ForEach(recipients) { container in
                            if !container.isFavorite {
                                GridContainerCell(container: container)
                            }
                        }
                    }
                } header: {
                    HStack() {
                        Text(Image(systemName: "takeoutbag.and.cup.and.straw.fill"))
                        Text("Others")
                        Spacer()
                    }
                    .foregroundColor(.accentColor)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationBarTitle(Text("Select a Container"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.purple)
                    }
                }
            }
        }
        .onChange(of: searchText, perform: { newValue in
            if !searchText.isEmpty {
                recipients.nsPredicate = NSPredicate(format: "name CONTAINS[c] %@", searchText)
            } else {
                recipients.nsPredicate = nil
            }
        })
        .searchable(text: $searchText)
        .fullScreenCover(isPresented: $showingSheet) {
            AddEditContainerView(recipient: self.$recipient)
        }
        
    }
}

//struct NewContainer_Previews: PreviewProvider {
//    static var previews: some View {
//  //      GridContainersView()
//           // .environmentObject(RecipientsViewModel())
//    }
//}
