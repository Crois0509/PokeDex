//
//  FetchModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import UIKit
import RxSwift

// 뷰 모델이 공통으로 사용할 메소드를 정의하는 프로토콜
protocol PokemonServiceProtocol {
    func fetchPokemonData<T: Decodable>(urlType: APIEndpoint, modelType: T.Type) -> Single<T>
}

// 뷰 모델이 공통으로 사용할 메소드를 구현하는 객체
final class PokemonManager: PokemonServiceProtocol {
    
    /// 네트워크 매니저를 사용해서 데이터를 디코딩하고 옵저버블로 반환해주는 메소드
    /// - Parameters:
    ///   - urlType: 디코딩할 URL
    ///   - modelType: 디코딩할 데이터 모델 타입
    /// - Returns: 디코딩된 데이터를 가진 옵저버블 타입
    func fetchPokemonData<T: Decodable>(urlType: APIEndpoint, modelType: T.Type) -> Single<T> {
        guard let url = URL(string: urlType.urlString) else {
            print(NetworkError.invalidURL.errorDescription)
            return Single.error(NetworkError.invalidURL)
        }
        
        return NetworkManager.shared.fetch(url: url)
    }
}
