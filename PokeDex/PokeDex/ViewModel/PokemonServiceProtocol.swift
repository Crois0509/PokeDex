//
//  FetchModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import UIKit
import RxSwift

protocol PokemonServiceProtocol {
    func fetchPokemonData<T: Decodable>(urlType: URLManager, modelType: T.Type) -> Single<T>
    func fetchPokemonDetails(_ datas: [PokemonData]) -> Single<[PokemonDetailDataModel]>
}

final class PokemonManager: PokemonServiceProtocol {
    
    func fetchPokemonData<T: Decodable>(urlType: URLManager, modelType: T.Type) -> Single<T> {
        guard let url = URL(string: urlType.sendURL) else {
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
