//
//  CoreDataManager.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import CoreData

// 코어 데이터 프로토콜
protocol CoreDataManaged: AnyObject {
    var persistentContainer: NSPersistentContainer { get }
    
    func savedPokemon(id: Int, name: String)
    func readAllData() -> [Pokemons]
    func updatePokemon()
    func deletePokemon(_ id: NSManagedObjectID)
}

// 코어데이터 기본 구현
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
    
}
