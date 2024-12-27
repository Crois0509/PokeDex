//
//  MainViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import UIKit
import RxSwift

final class MainViewModel {
    private let limit: Int = 20
    private let offset: Int = 0
    private let pokemonManager: PokemonServiceProtocol
    
    let disposeBag = DisposeBag()
    
    let pokemonImages = BehaviorSubject(value: [UIImage]())

    init(pokemonManager: PokemonServiceProtocol) {
        self.pokemonManager = pokemonManager

        fetchPokemonData()
    }
    
    private func fetchPokemonData() {
        self.pokemonManager.fetchPokemonList(limit: self.limit, offset: self.offset)
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
                
                guard let url = URL(string: URLManager.pokemonImage(id: data.id).sendURL()) else {
                    subject.onError(NetworkError.invalidURL)
                    return
                }
                
                guard let imageData = try? Data(contentsOf: url) else {
                    subject.onError(NetworkError.invalidURL)
                    return
                }
                
                guard let image = UIImage(data: imageData) else {
                    subject.onError(NetworkError.invalidURL)
                    return
                }
                
                subject.onNext([image])
                
            }, onError: { error in
                subject.onError(error)
                
            }).disposed(by: self.disposeBag)
    }
}
