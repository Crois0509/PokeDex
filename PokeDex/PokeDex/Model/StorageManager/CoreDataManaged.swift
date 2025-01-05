//
//  CoreDataManager.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import CoreData

protocol CoreDataManaged: AnyObject {
    var persistentContainer: NSPersistentContainer { get }
    var context: NSManagedObjectContext { get }
    
    func savedPokemon(id: Int, name: String)
    func readAllData() -> [Pokemons]
    func updatePokemon()
    func deletePokemon(_ id: NSManagedObjectID)
    func saveContext() throws
}

extension CoreDataManaged {
    var persistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "MyPokemon")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data Error: \(error.localizedDescription)")
            }
        }
        return container
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() throws {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                print(error)
            }
        }
    }
}
