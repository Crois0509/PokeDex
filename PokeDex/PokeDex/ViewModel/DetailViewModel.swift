//
//  DetailViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/28/24.
//

import UIKit
import RxSwift

// 포켓몬의 디테일 뷰의 로직을 담당하는 모델
final class DetailViewModel {
    private let pokemonManager: PokemonServiceProtocol // 데이터 패치를 담당하는 객체
    
    private let disposeBag = DisposeBag()
    
    let pokemonDetailData = BehaviorSubject(value: [PokemonDetailDataModel]()) // 데이터 바인딩 객체
    
    // MARK: - DetailViewModel Initializer
    
    // 초기화시 파라미터로 PokemonServiceProtocol 타입의 값을 지정
    // 파라미터 값을 이용하여 포켓몬 매니저 초기화
    // 초기화시 파라미터로 받는 id를 사용하여 데이터를 불러오는 메소드 실행
    init(pokemonManager: PokemonServiceProtocol, id: Int) {
        self.pokemonManager = pokemonManager
        
        fetchPokemonData(id: id)
    }
    
    /// 네트워크 매니저를 통해 포켓몬의 자세한 정보를 불러오는 메소드
    /// - Parameter id: 불러올 포켓몬의 도감 번호
    private func fetchPokemonData(id: Int) {
        self.pokemonManager.fetchPokemonData(urlType: .pokemonDetails(id: id), modelType: PokemonDetailDataModel.self)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe(onSuccess: { [weak self] (details: PokemonDetailDataModel) in
                guard let self else { return }
                
                self.pokemonDetailData.onNext([details])
                
            }, onFailure: { error in
                self.pokemonDetailData.onError(error)
                
            }).disposed(by: self.disposeBag)
    }
    
    func capture(id: Int) -> Bool {
        let probability = Int.random(in: 0...100)
        
        switch id {
        case (1...99):
            guard (0...90).contains(probability) else { return false }
            return successCapture()
            
        case (100...199):
            guard (0...85).contains(probability) else { return false }
            return successCapture()
            
        case (200...299):
            guard (0...78).contains(probability) else { return false }
            return successCapture()
            
        case (300...399):
            guard (0...70).contains(probability) else { return false }
            return successCapture()
            
        case (400...499):
            guard (0...62).contains(probability) else { return false }
            return successCapture()
            
        case (500...599):
            guard (0...55).contains(probability) else { return false }
            return successCapture()
            
        case (600...699):
            guard (0...47).contains(probability) else { return false }
            return successCapture()
            
        case (700...799):
            guard (0...36).contains(probability) else { return false }
            return successCapture()
            
        case (800...899):
            guard (0...29).contains(probability) else { return false }
            return successCapture()
            
        case (900...999):
            guard (0...20).contains(probability) else { return false }
            return successCapture()
            
        case (1000...):
            guard (0...10).contains(probability) else { return false }
            return successCapture()
            
        default: break
        }
        return false
    }
    
    private func successCapture() -> Bool {
        // 코어 데이터에 저장
        
        return true
    }
}
