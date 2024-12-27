//
//  MainViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import UIKit
import RxSwift

final class MainViewModel {
    private let pokemonManager: PokemonServiceProtocol
    
    let disposeBag = DisposeBag()
    
    let pokemonImages = BehaviorSubject(value: [UIImage]())

    init(pokemonManager: PokemonServiceProtocol) {
        self.pokemonManager = pokemonManager

        fetchPokemonData()
    }
    
    private func fetchPokemonData() {
        self.pokemonManager.fetchPokemonList(limit: 20, offset: 0)
            .flatMap { self.pokemonManager.fetchPokemonDetails($0.results) }
            .subscribe(onSuccess: { [weak self] details in
                guard let self else { return }
                
                self.fetchPokemonImage(details: details, self.pokemonImages)
                
            }, onFailure: { [weak self] error in
                self?.pokemonImages.onError(error)
                
            }).disposed(by: self.disposeBag)
    }
    
    private func fetchPokemonImage(details: [PokemonDetailDataModel], _ subject: BehaviorSubject<[UIImage]>) {
        let list = details.sorted(by: { $0.id < $1.id })
        
        Observable.from(list)
            .subscribe(onNext: { data in
                
                guard let image = NetworkManager.shared.fetchImage(id: data.id) else {
                    subject.onError(NetworkError.dataFetchFail)
                    return
                }
                
                subject.onNext([image])
                
            }, onError: { error in
                subject.onError(error)
                
            }).disposed(by: self.disposeBag)
    }
}
