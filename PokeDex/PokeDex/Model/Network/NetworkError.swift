//
//  NetworkError.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import Foundation

// 네트워크 에러를 정의해두는 enum
enum NetworkError: LocalizedError {
    case invalidURL
    case dataFetchFail
    case decodingFail
    
    // 네트워크 에러의 각 케이스 별 메세지
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
