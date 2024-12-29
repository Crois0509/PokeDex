//
//  URLManager.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import Foundation

enum URLManager {
    case pokemonData(limit: Int, offset: Int)
    case pokemonDetailData(id: Int)
    case pokemonImage(id: Int)
    case otherURL(url: String)
    
    var sendURL: String {
        switch self {
        case .pokemonData(limit: let limit, offset: let offset):
            return "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        case .pokemonDetailData(id: let id):
            return "https://pokeapi.co/api/v2/pokemon/\(id)/"
        case .pokemonImage(id: let id):
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        case .otherURL(url: let url):
            return url
        }
    }
}
