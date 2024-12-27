//
//  FetchModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import UIKit
import RxSwift

protocol PokemonServiceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) -> Single<PokemonDataModel>
    func fetchPokemonDetails(_ datas: [PokemonData]) -> Single<[PokemonDetailDataModel]>
}

final class PokemonManager: PokemonServiceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) -> Single<PokemonDataModel> {
        guard let url = URL(string: URLManager.pokemonData(limit: limit, offset: offset).sendURL()) else {
            print(NetworkError.invalidURL.errorDescription)
            return Single.error(NetworkError.invalidURL)
        }
        
        return NetworkManager.shared.fetch(url: url)
    }
    
    func fetchPokemonDetails(_ datas: [PokemonData]) -> Single<[PokemonDetailDataModel]> {
        return Observable.from(datas)
            .flatMap { data -> Single<PokemonDetailDataModel> in
                guard let url = URL(string: data.url) else {
                    return Single.error(NetworkError.invalidURL)
                }
                return NetworkManager.shared.fetch(url: url)
            }
            .toArray()
    }
}
