//
//  MainViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import UIKit
import RxSwift

// 메인 뷰의 로직을 담당하는 모델
final class MainViewModel {
    private let pokemonManager: PokemonServiceProtocol // 데이터 패치를 담당하는 인스턴스
    
    private var limit: Int = 25 // 한 번에 불러올 포켓몬 데이터 수
    
    private var offset: Int = 0 // 몇 번째 포켓몬부터 불러올 것인지 선택
    
    private let pokemons: Int = 1025 // 최대 포켓몬 수
            
    let disposeBag = DisposeBag()
    
    let pokemonList = PublishSubject<[PokemonData]>() // 데이터 바인딩 객체
    
    // MARK: - MainViewModel Initializer
    
    // 초기화시 파라미터로 PokemonServiceProtocol 타입의 값을 지정
    // 파라미터 값을 이용하여 포켓몬 매니저 초기화
    // MainViewModel이 초기화될 때 데이터를 불러오는 메소드 실행
    init(pokemonManager: PokemonServiceProtocol) {
        self.pokemonManager = pokemonManager
        
        fetchPokemonData(urlType: .pokemonList(limit: self.limit, offset: self.offset))
    }
    
    /// 스크롤을 모두 완료하면 새로운 데이터 리스트를 불러오는 메소드
    func reload() {
        fetchPokemonData(urlType: .pokemonList(limit: self.limit, offset: self.offset))
    }
    
    /// 현재 포켓몬 도감 번호가 최대 포켓몬 수 이하인지 확인하는 메소드
    /// - Returns: 최대 포켓몬 수보다 작을 경우 true, 클 경우 false
    func getCurrentOffset() -> Bool {
        return self.offset < self.pokemons
    }
}

// MARK: - MainViewModel Private Method
private extension MainViewModel {
    /// 포켓몬 디테일 데이터를 불러오는 메소드
    /// - Parameter urlType: URL 타입을 지정 -> 어떤 데이터를 불러올지 설정
    func fetchPokemonData(urlType: APIEndpoint) {
        self.pokemonManager.fetchPokemonData(
            urlType: urlType,
            modelType: PokemonDataModel.self
        )
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
        .subscribe(onSuccess: { [weak self] data in
            guard let self else { return }
            
            self.pokemonList.onNext(data.results)
            self.offset += self.limit // 다시 메소드를 호출했을 때 다음 포켓몬 리스트를 불러오기 위한 로직
            
        }, onFailure: { [weak self] error in
            self?.pokemonList.onError(error)
            
        }).disposed(by: self.disposeBag)
    }
}
