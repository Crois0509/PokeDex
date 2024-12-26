//
//  NetworkError.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case dataFetchFail
    case decodingFail
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "잘못된 URL 입니다."
        case .dataFetchFail:
            return "데이터를 불러오는데 실패했습니다."
        case .decodingFail:
            return "디코딩에 실패했습니다."
        }
    }
}
