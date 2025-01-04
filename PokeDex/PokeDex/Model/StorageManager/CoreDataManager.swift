//
//  Core.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import CoreData

final class CoreDataManager: CoreDataManaged {
    
    static let shared = CoreDataManager()
    private init() {}
    
    func savedPokemon(id: Int, name: String) {
        let description = NSEntityDescription.entity(forEntityName: String(describing: Pokemons.self), in: self.context)!
        let entity = Pokemons(entity: description, insertInto: self.context)
        entity.id = Int32(id)
        entity.name = name
        
        try? self.saveContext()
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
        try? self.saveContext()
    }
}
