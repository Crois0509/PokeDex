//
//  PokemonData.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import Foundation

struct PokemonDataModel: Decodable {
    let next: String
    let results: [PokemonData]
}

struct PokemonData: Decodable {
    let name: String
    let url: String
}
