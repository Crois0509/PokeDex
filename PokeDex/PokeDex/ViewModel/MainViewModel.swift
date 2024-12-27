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
    
    private let pokeDexData = BehaviorSubject(value: [PokemonDetailDataModel]())
    let pokemonImages = BehaviorSubject(value: [UIImage]())

    init() {
        fetchPokemonData(self.pokeDexData)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.fetchPokemonImage(self.pokemonImages)
        }
    }
    
    private func fetchData<T: Decodable>(url: URL, decodingType: T.Type) -> Single<T> {
        return NetworkManager.shared.fetch(url: url)
    }
    
    private func fetchPokemonData(_ subject: BehaviorSubject<[PokemonDetailDataModel]>) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            print(NetworkError.invalidURL.errorDescription)
            return
        }
        
        fetchData(url: url, decodingType: PokemonDataModel.self)
            .subscribe(onSuccess: { [weak self] data in
                self?.fetchPokemonDetaileData(data.results, subject)
                
            }, onFailure: { error in
                subject.onError(error)
                print(NetworkError.dataFetchFail.errorDescription)
                
            }).disposed(by: self.disposeBag)
    }
    
    private func fetchPokemonDetaileData(_ datas: [PokemonData], _ subject: BehaviorSubject<[PokemonDetailDataModel]>) {
        
        Observable.from(datas)
            .flatMap { data -> Single<PokemonDetailDataModel> in
                guard let url = URL(string: data.url) else {
                    return Single.error(NetworkError.invalidURL)
                }
                return self.fetchData(url: url, decodingType: PokemonDetailDataModel.self)
            }
            .toArray()
            .subscribe(onSuccess: { dataList in
                subject.onNext(dataList)
                
            }, onFailure: { error in
                subject.onError(error)
                
            }).disposed(by: self.disposeBag)
    }
    
    private func fetchPokemonImage(_ subject: BehaviorSubject<[UIImage]>) {
        guard let list = try? self.pokeDexData.value().sorted(by: { $0.id < $1.id }) else { return }
        
        Observable.from(list)
            .subscribe(onNext: { data in
                
                guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(data.id).png") else {
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
