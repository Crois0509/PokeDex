//
//  Core.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import CoreData

enum PokemonsKeys: String {
    case id
    case name
}

final class CoreDataManager: CoreDataManaged {
    
    static let coreDatashared = CoreDataManager()
    private init() {}
    
    func savedPokemon(id: Int, name: String) {
        let context = self.context
        guard let description = NSEntityDescription.entity(forEntityName: String(describing: Pokemons.self), in: context) else { return }
        let entity: NSManagedObject = NSManagedObject.init(entity: description, insertInto: context)
        entity.setValue(id, forKey: PokemonsKeys.id.rawValue)
        entity.setValue(name, forKey: PokemonsKeys.name.rawValue)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func readAllData() -> [Pokemons] {
        let fetchRequest: NSFetchRequest<Pokemons> = Pokemons.fetchRequest()
        return (try? self.context.fetch(fetchRequest)) ?? []
    }
    
    func updatePokemon() {
        // 업데이트 기능 필요한 경우 구현
    }
    
    func deletePokemon(_ pokemon: Pokemons) {
        self.context.delete(pokemon)
        
        do {
            try self.saveContext()
        } catch {
            print(error)
        }
    }
}
