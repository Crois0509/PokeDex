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
    private var limit: Int = 20
    private var offset: Int = 0
    private var existentPokemons: Set<Int> = []
    private var nextURL: String = ""
    
    let disposeBag = DisposeBag()
    
    let pokemonImages = BehaviorSubject(value: [(image: UIImage,id: Int)]())
    
    init(pokemonManager: PokemonServiceProtocol) {
        self.pokemonManager = pokemonManager
        
        fetchPokemonData(urlType: .pokemonData(limit: self.limit, offset: self.offset))
    }
    
    func reload() {
        fetchPokemonData(urlType: .otherURL(url: self.nextURL))
    }
    
    private func fetchPokemonData(urlType: URLManager) {
        self.pokemonManager.fetchPokemonData(
            urlType: urlType,
            modelType: PokemonDataModel.self
        )
        .observe(on: MainScheduler.asyncInstance)
        .flatMap { [weak self] in
            guard let self else {
                return Single.error(NetworkError.dataFetchFail)
            }
            self.nextURL = $0.next
            return self.pokemonManager.fetchPokemonDetails($0.results)
        }
        .subscribe(onSuccess: { [weak self] (details: [PokemonDetailDataModel]) in
            guard let self else { return }
            
//            self.offset += limit
            self.fetchPokemonImage(details: details, self.pokemonImages)
            
        }, onFailure: { [weak self] error in
            self?.pokemonImages.onError(error)
            
        }).disposed(by: self.disposeBag)
    }
    
    private func fetchPokemonImage(details: [PokemonDetailDataModel], _ subject: BehaviorSubject<[(image: UIImage,id: Int)]>) {
        
        var uniqueDetails = details.filter { !self.existentPokemons.contains($0.id) }
        uniqueDetails.forEach { self.existentPokemons.insert($0.id) }
        uniqueDetails.sort(by: { $0.id < $1.id })
        
        Observable.from(uniqueDetails)
            .map { data -> (UIImage, Int) in
                guard let image = NetworkManager.shared.fetchImage(id: data.id) else {
                    subject.onError(NetworkError.dataFetchFail)
                    return (UIImage(), 0)
                }
                return (image, data.id)
            }
            .subscribe(onNext: { data in
                
                subject.onNext([(image: data.0,id: data.1)])
                
            }, onError: { error in
                subject.onError(error)
                
            }).disposed(by: self.disposeBag)
    }
}
