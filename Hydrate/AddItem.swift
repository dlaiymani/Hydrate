//
//  AddItem.swift
//  Hydrate
//
//  Created by David Laiymani on 16/09/2022.
//

import SwiftUI

struct AddItem: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)], predicate: NSPredicate(format: "name == %@", "Cup")) var items: FetchedResults<Item>
    
    
    var body: some View {
        VStack {
            Button {
                let item = Item(context: managedObjectContext)
                item.name = "Cup"
                item.volume = 120
                item.color = "Color.blue"
                item.icon = "snow"
                item.isFavorite = true
                PersistenceController.shared.save()
            } label: {
                Text("Add Item")
            }
            
            List {
                ForEach(items, id: \.self) { item in
                    Text("\(item.name ?? "Unknown")")
                }
                .onDelete(perform: removeItem)
            }
            
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            PersistenceController.shared.delete(item)
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem()
    }
}
