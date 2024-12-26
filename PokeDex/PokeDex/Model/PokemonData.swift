//
//  PokemonData.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import Foundation

struct PokemonData: Decodable {
    let next: String
    let results: [Results]
}

struct Results: Decodable {
    let name: String
    let url: String
}
