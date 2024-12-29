//
//  URLManager.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import Foundation

// API 통신에 사용하는 URL을 관리하는 enume
enum APIEndpoint {
    case pokemonList(limit: Int, offset: Int)
    case pokemonDetails(id: Int)
    case pokemonImageURL(id: Int)
    case customURL(url: String)
    
    // 각 케이스별로 다른 URL을 get 하는 프로퍼티
    var urlString: String {
        switch self {
        case .pokemonList(limit: let limit, offset: let offset):
            return "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        case .pokemonDetails(id: let id):
            return "https://pokeapi.co/api/v2/pokemon/\(id)/"
        case .pokemonImageURL(id: let id):
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        case .customURL(url: let url):
            return url
        }
    }
}
