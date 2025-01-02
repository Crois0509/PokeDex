//
//  SearchViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import RxSwift

// 검색 뷰 모델
final class SearchViewModel {
    typealias Names = (String, String)
    
    private let pokemonManager: PokemonServiceProtocol // 데이터 패치를 담당하는 인스턴스
    
    private let disposeBag = DisposeBag()
    
    private var pokemonList: [PokemonData] = [] // 모든 포켓몬에 대한 정보가 담긴 배열
    
    let searchPokemonList = PublishSubject<[(Int, String)]>() // 데이터 바인딩 객체
    
    // MARK: - SearchViewModel Initializer
    
    // 초기화시 파라미터로 PokemonServiceProtocol 타입의 값을 지정
    // 파라미터 값을 이용하여 포켓몬 매니저 초기화
    // 모든 포켓몬 데이터를 불러오는 메소드 실행(dataLoad)
    init(pokemonManager: PokemonServiceProtocol) {
        self.pokemonManager = pokemonManager
        dataLoad()
    }
    
    /// 검색한 값과 관련있는 포켓몬 데이터를 이벤트로 방출하는 메소드
    /// - Parameter text: 검색창 입력 값
    func search(text: String) {
        let list = containsSearchResult(text: text)
        
        guard list.count > 0 else { return }
        
        self.searchPokemonList.onNext(list)
    }
}

// MARK: - SearchViewModel Private Method
private extension SearchViewModel {
    
    /// 모든 포켓몬의 정보를 불러오는 메소드
    func dataLoad() {
        self.pokemonManager.fetchPokemonData(urlType: .pokemonList(limit: 1025, offset: 0), modelType: PokemonDataModel.self)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe(onSuccess: { [weak self] data in
                guard let self else { return }
                
                self.pokemonList = data.results
                
            }, onFailure: { error in
                print(error)
                
            }).disposed(by: self.disposeBag)
        
    }
    
    /// 입력된 값과 연관된 포켓몬 리스트를 반환하는 메소드
    /// - Parameter text: 입력 값
    /// - Returns: 포켓몬 ID, Name 배열
    func containsSearchResult(text: String) -> [(Int, String)] {
        var searchList: [(Int, String)] = []
        
        let list = self.pokemonList.enumerated().filter { index, data in
            PokemonTranslator.getKoreanName(for: data.name).contains(text) ||
            data.name.contains(text.lowercased()) ||
            (index + 1).contains(Int(text) ?? -1)
        }.map {
            ($0.offset, $0.element)
        }
        
        searchList += addData(datas: list)
        
        return searchList
    }
    
    /// 포켓몬 데이터 배열을 ID, Name 배열로 반환하는 메소드
    /// - Parameter datas: 포켓몬 ID와 포켓몬 데이터가 포함된 배열
    /// - Returns: 포켓몬 ID와 포켓몬 이름을 담은 튜플 배열
    func addData(datas: [(Int, PokemonData)]) -> [(id: Int, name: String)] {
        var result: [(Int, String)] = []
        
        datas.forEach { index, data in
            let id = index + 1
            let name = PokemonTranslator.getKoreanName(for: data.name)
            let item = (id, name)
            result.append(item)
        }
        
        return result
    }
}

// MARK: - Int Extension Method
extension Int {
    /// Int 타입끼리의 contains 메소드
    /// - Parameter digit: 비교할 값
    /// - Returns: digit이 self에 포함된 경우 true, 그렇지 않은 경우 false
    func contains(_ digit: Int) -> Bool {
        let number = String(self)
        let digitNumber = String(digit)
        
        return number.contains(digitNumber)
    }
}
