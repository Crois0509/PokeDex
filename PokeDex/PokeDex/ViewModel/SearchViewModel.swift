//
//  SearchViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import RxSwift

final class SearchViewModel {
    typealias Names = (String, String)
    
    private let pokemonManager: PokemonServiceProtocol
    
    private let disposeBag = DisposeBag()
    
    private var pokemonList: [(id: String, name: Names)] = []
        
    let searchPokemonList = PublishSubject<[(Int, String)]>()
    
    init(pokemonManager: PokemonServiceProtocol) {
        self.pokemonManager = pokemonManager
        dataLoad()
    }
    
    private func dataLoad() {
        var list = [(id: String, name: Names)]()
        
        self.pokemonManager.fetchPokemonData(urlType: .pokemonList(limit: 1025, offset: 0), modelType: PokemonDataModel.self)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .flatMap { [weak self] in
                guard let self else {
                    return Single.error(NetworkError.dataFetchFail)
                }
                return self.pokemonManager.fetchPokemonDetails($0.results)
            }
            .subscribe(onSuccess: { [weak self] (details: [PokemonDetailDataModel]) in
                guard let self else { return }
                
                for data in self.addData(data: details) {
                    let name: String = PokemonTranslator.getKoreanName(for: data.name)
                    let names: Names = (data.name, name)
                    let item = (id: "\(data.id)", name: names)
                    list.append(item)
                }
                
                self.pokemonList = list
                
            }, onFailure: { error in
                print(error)
                
            }).disposed(by: self.disposeBag)
        
    }
    
    func addImage(id: Int) -> UIImage {
        guard let image = NetworkManager.shared.fetchImage(id: id) else { return UIImage() }
        return image
    }
    
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
    
    private func addData(data: [PokemonDetailDataModel]) -> [(id: Int, name: String)] {
        var result: [(Int, String)] = []
        
        data.forEach {
            let id = $0.id
            let name = $0.name
            let item = (id, name)
            result.append(item)
        }
        
        return result
    }
    
    private func addList(_ list: [(id: String, name: Names)]) -> [(Int, String)] {
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
