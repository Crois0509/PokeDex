//
//  PokemonDetailModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import Foundation

struct PokemonDetailDataModel: Decodable {
    let id: Int
    let name: String
    let height: Double
    let weight: Double
    let types: [PokemonTypes]
}

struct PokemonTypes: Decodable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
}
