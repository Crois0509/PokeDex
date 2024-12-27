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
    
    let disposeBag = DisposeBag()
    
    let pokeDexData = BehaviorSubject(value: [PokemonData]())
    
    init() {
        fetchPokeDex(self.pokeDexData)
    }
    
    private func fetchData<T: Decodable>(url: URL, decodingType: T.Type) -> Single<T> {
        return NetworkManager.shared.fetch(url: url)
    }
    
    private func fetchPokeDex(_ subject: BehaviorSubject<[PokemonData]>) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            print(NetworkError.invalidURL.errorDescription)
            return
        }
        
        fetchData(url: url, decodingType: PokemonDataModel.self)
            .subscribe(onSuccess: { data in
                subject.onNext(data.results)
                
            }, onFailure: { error in
                subject.onError(error)
                print(NetworkError.dataFetchFail.errorDescription)
                
            }).disposed(by: self.disposeBag)
    }
}
