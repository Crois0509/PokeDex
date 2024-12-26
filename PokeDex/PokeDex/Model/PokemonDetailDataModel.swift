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
    let height: Int
    let weight: Int
    let sprites: [Sprites]
    let types: [PokemonTypes]
}

struct Sprites: Decodable {
    let frontDefault: String
    
    enum CondingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonTypes: Decodable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
}
