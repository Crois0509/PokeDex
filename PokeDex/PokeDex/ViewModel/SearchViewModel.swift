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
    
    private var pokemonList: [PokemonData] = []
        
    let searchPokemonList = PublishSubject<[(Int, String)]>()
    
    init(pokemonManager: PokemonServiceProtocol) {
        self.pokemonManager = pokemonManager
        dataLoad()
    }
    
    private func dataLoad() {
        self.pokemonManager.fetchPokemonData(urlType: .pokemonList(limit: 1025, offset: 0), modelType: PokemonDataModel.self)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe(onSuccess: { [weak self] data in
                guard let self else { return }
                
                self.pokemonList = data.results
                
            }, onFailure: { error in
                print(error)
                
            }).disposed(by: self.disposeBag)
        
    }
    
    func search(text: String) {
        if let result = Int(text) {
            var searchList: [(Int, String)] = []
            
            let list = self.pokemonList.enumerated().filter { index, _ in
                (index + 1).contains(result)
            }.map {
                ($0.offset, $0.element)
            }
            
            guard list.count > 0 else { return }
            
            searchList += addData(datas: list)
            
            self.searchPokemonList.onNext(searchList)
            
        } else {
            var searchList: [(Int, String)] = []
            
            let enList = self.pokemonList.enumerated().filter { index, data in
                data.name.contains(text.lowercased())
            }.map {
                ($0.offset, $0.element)
            }
            
            let koList = self.pokemonList.enumerated().filter { index, data in
                PokemonTranslator.getKoreanName(for: data.name).contains(text)
            }.map {
                ($0.offset, $0.element)
            }
            
            guard enList.count > 0 || koList.count > 0 else { return }
            
            searchList += addData(datas: enList)
            searchList += addData(datas: koList)
         
            self.searchPokemonList.onNext(searchList)
        }
    }
    
    private func addData(datas: [(Int, PokemonData)]) -> [(id: Int, name: String)] {
        var result: [(Int, String)] = []
        
        datas.forEach { index, data in
            let id = index + 1
            let name = PokemonTranslator.getKoreanName(for: data.name)
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
