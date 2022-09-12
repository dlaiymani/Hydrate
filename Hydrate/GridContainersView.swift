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

    
    private let numberOfColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var searchResults: [Container] {
        if searchText.isEmpty {
            return Container.mockContainerData
        } else {
            return Container.mockContainerData.filter { $0.name .contains(searchText) }
        }
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                Section {
                    LazyVGrid(columns: numberOfColumns, spacing: 20) {
                        ForEach(searchResults) { container in
                            if container.isFavorite {
                                ContainerView(container: container)
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
                        ForEach(searchResults) { container in
                            if !container.isFavorite {
                                ContainerView(container: container)
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
        .searchable(text: $searchText)
        .sheet(isPresented: $showingSheet) {
            AddContainerView()
        }
    }
}

struct NewContainer_Previews: PreviewProvider {
    static var previews: some View {
        GridContainersView()
    }
}
