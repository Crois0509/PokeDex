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
    
    private var pokemonList: [PokemonDetailDataModel] = []
        
    let searchPokemonList = PublishSubject<[(Int, String)]>()
    
    init(pokemonManager: PokemonServiceProtocol) {
        self.pokemonManager = pokemonManager
        dataLoad()
    }
    
    private func dataLoad() {
        self.pokemonManager.fetchPokemonData(urlType: .pokemonList(limit: 25, offset: 0), modelType: PokemonDataModel.self)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .flatMap { [weak self] in
                guard let self else {
                    return Single.error(NetworkError.dataFetchFail)
                }
                return self.pokemonManager.fetchPokemonDetails($0.results)
            }
            .subscribe(onSuccess: { [weak self] (details: [PokemonDetailDataModel]) in
                guard let self else { return }
                
                self.pokemonList = details
                
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
            
            let list = self.pokemonList.filter { $0.id.contains(result) }
            guard list.count > 0 else { return }
            
            searchList += addData(data: list)
            
            self.searchPokemonList.onNext(searchList)
            
        } else {
            var searchList: [(Int, String)] = []
            
            let enList = self.pokemonList.filter { $0.name.contains(text.lowercased()) }
            let koList = self.pokemonList.filter { PokemonTranslator.getKoreanName(for: $0.name).contains(text) }
            guard enList.count > 0 || koList.count > 0 else { return }
            
            searchList += addData(data: enList)
            searchList += addData(data: koList)
            
            self.searchPokemonList.onNext(searchList)
        }
    }
    
    private func addData(data: [PokemonDetailDataModel]) -> [(id: Int, name: String)] {
        var result: [(Int, String)] = []
        
        data.forEach {
            let id = $0.id
            let name = PokemonTranslator.getKoreanName(for: $0.name)
            let item = (id, name)
            result.append(item)
        }
        
        return result
    }
}

extension Int {
    func contains(_ digit: Int) -> Bool {
        let number = String(self)
        let digitNumber = String(digit)
        
        return number.contains(digitNumber)
    }
}
