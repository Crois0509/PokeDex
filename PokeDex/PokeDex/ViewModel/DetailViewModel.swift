//
//  DetailViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/28/24.
//

import UIKit
import RxSwift

final class DetailViewModel {
    private let pokemonManager: PokemonServiceProtocol
    
    private let disposeBag = DisposeBag()
    
    let pokemonDetailData = BehaviorSubject(value: [PokemonDetailDataModel]())
    
    init(pokemonManager: PokemonServiceProtocol, id: Int) {
        self.pokemonManager = pokemonManager
        
        fetchPokemonData(id: id)
    }
    
    private func fetchPokemonData(id: Int) {
        self.pokemonManager.fetchPokemonData(urlType: .pokemonDetailData(id: id), modelType: PokemonDetailDataModel.self)
            .subscribe(onSuccess: { [weak self] (details: PokemonDetailDataModel) in
                guard let self else { return }
                
                self.pokemonDetailData.onNext([details])
                
            }, onFailure: { error in
                self.pokemonDetailData.onError(error)
                
            }).disposed(by: self.disposeBag)
    }
}
