//
//  SearchViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import RxSwift

final class SearchViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let pokemonList = PokemonTranslator.pokemonList
    
    let searchPokemonList = PublishSubject<[(Int, String)]>()
    
    func search(text: String) {
        if let result = Int(text) {
            var searchList: [(Int, String)] = []
            
            let list = self.pokemonList.filter { $0.id.contains("\(result)") }
            guard list.count > 0 else { return }
            
            searchList += addList(list)
            
            self.searchPokemonList.onNext(searchList)
            
        } else {
            var searchList: [(Int, String)] = []
            
            let enList = self.pokemonList.filter { $0.name.0.contains(text.lowercased()) }
            let koList = self.pokemonList.filter { $0.name.1.contains(text) }
            guard enList.count > 0 || koList.count > 0 else { return }
            
            searchList += addList(enList)
            searchList += addList(koList)
            
            self.searchPokemonList.onNext(searchList)
        }
    }
    
    private func addList(_ list: [(id: String, name: PokemonTranslator.Names)]) -> [(Int, String)] {
        var searchList: [(Int, String)] = []
        
        list.forEach {
            let id: Int = Int($0.id) ?? 0
            let name: String = $0.name.1
            let item = (id, name)
            
            searchList.append(item)
        }
        
        return searchList
    }
}
