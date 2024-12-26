//
//  NetworkManager.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import Foundation
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T: Decodable>(url: URL) -> Single<T> {
        return Single.create { observer in
            
            let session = URLSession(configuration: .default)
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
