//
//  RecipientsViewModel.swift
//  Hydrate
//
//  Created by David Laiymani on 18/09/2022.
//

import SwiftUI
import CoreData

class RecipientsViewModel: ObservableObject {
    
    @AppStorage("userOnboarded") var userOnboarded: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    
    init() {
        if !userOnboarded {
            for recipient in Recipient.mockContainerData {
                addRecipient(recipient: recipient)
            }
            userOnboarded = true
        }
    }
    
    func addRecipient(recipient: Recipient) {
        let newEntity = RecipientEntity(context: PersistenceController.shared.container.viewContext)
        newEntity.id = recipient.id
        newEntity.name = recipient.name
        newEntity.icon = recipient.icon
        newEntity.volume = recipient.volume
        newEntity.color = recipient.color
        newEntity.isFavorite = recipient.isFavorite
        PersistenceController.shared.save()

    }
    
    func deleteRecipient(_ recipient: RecipientEntity) {
        PersistenceController.shared.delete(recipient)
    }
}

