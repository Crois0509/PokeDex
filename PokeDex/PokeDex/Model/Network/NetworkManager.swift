//
//  NetworkManager.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import UIKit
import RxSwift

// API 통신을 관리하는 네트워크 모델
final class NetworkManager {
    /// shard = 싱글톤 패턴으로 이를 활용하여 네트워크 작업 진행
    static let shared = NetworkManager()
    private init() {}
    
    /// URL을 통해 API 통신을 통해 데이터를 디코딩하는 메소드
    /// - Parameter url: 디코딩할 URL
    /// - Returns: Single 타입 -> 디코딩한 값을 데이터 바인딩
    func fetch<T: Decodable>(url: URL) -> Single<T> {
        return Single.create { observer in
            
            let session = URLSession(configuration: .default)
            session.configuration.httpMaximumConnectionsPerHost = 5
            session.dataTask(with: url) { (data, response, error) in
                
                guard let data, error == nil else {
                    observer(.failure(error!))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode)
                else {
                    observer(.failure(NetworkError.dataFetchFail))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    observer(.success(decodedData))
                    
                } catch {
                    print(NetworkError.decodingFail.errorDescription, error)
                    observer(.failure(NetworkError.decodingFail))
                }
                
            }.resume()
            
            return Disposables.create()
        }
    }
}
