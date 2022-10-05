//
//  PersistencController.swift
//  Hydrate
//
//  Created by David Laiymani on 16/09/2022.
//

import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer = NSPersistentContainer(name: "Hydrate")
    
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func getRecipients() -> [RecipientEntity] {
        let request: NSFetchRequest<RecipientEntity> = RecipientEntity.fetchRequest()
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func getProfile() -> [ProfileEntity] {
        let request: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
    func getRecipientById(id: NSManagedObjectID) -> RecipientEntity? {
        do {
            return try container.viewContext.existingObject(with: id) as! RecipientEntity
        } catch {
            return nil
        }
    }

    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
    
    
    
}
