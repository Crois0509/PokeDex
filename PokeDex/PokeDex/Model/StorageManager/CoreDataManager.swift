//
//  Core.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import CoreData

// 코어데이터 키워드
enum PokemonsKeys: String {
    case id
    case name
}

// 코어데이터 관리 객체
final class CoreDataManager: CoreDataManaged {
    
    static let coreDatashared = CoreDataManager() // 싱글톤 패턴
    
    private init() {}
    
    /// 포켓몬 정보를 저장하는 메소드
    /// - Parameters:
    ///   - id: 포켓몬 id
    ///   - name: 포켓몬 이름
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
    
    /// 코어데이터의 모든 데이터를 가져오는 메소드
    /// - Returns: [Pokemons] = 나의 모든 포켓몬 정보
    func readAllData() -> [Pokemons] {
        let fetchRequest: NSFetchRequest<Pokemons> = Pokemons.fetchRequest()
        return (try? self.context.fetch(fetchRequest)) ?? []
    }
    
    func updatePokemon() {
        // 업데이트 기능 필요한 경우 구현
    }
    
    /// 특정 포켓몬을 제거하는 메소드
    /// - Parameter id: 해당 포켓몬의 NSManagedObjectID
    func deletePokemon(_ id: NSManagedObjectID) {
        let context = self.context
        guard let pokemon = search(id, context) else { return }
        if pokemon.managedObjectContext !== context {
            print("pokemon's context does not match self.context")
        }
        context.delete(pokemon)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    /// 포켓몬을 검색하는 기능
    /// - Parameters:
    ///   - id: 포켓몬 ID
    ///   - context: 어떤 컨테이너에서 검색할 것인지
    /// - Returns: NSManagedObject -> 특정 포켓몬 정보
    func search(_ id: NSManagedObjectID, _ context: NSManagedObjectContext) -> Pokemons? {
        do {
            let pokemon = try context.existingObject(with: id) as? Pokemons
            return pokemon
            
        } catch {
            print(error)
            return nil
        }
    }
}
