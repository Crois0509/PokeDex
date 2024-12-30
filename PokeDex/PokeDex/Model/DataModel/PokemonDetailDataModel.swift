//
//  PokemonDetailModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import Foundation

// 포켓몬의 상세한 데이터를 담고 있는 데이터 타입
struct PokemonDetailDataModel: Decodable {
    let id: Int
    let name: String
    let height: Double
    let weight: Double
    let types: [PokemonTypes]
}

// 포켓몬의 타입의 순서와 타입에 대한 속성을 가진 데이터 타입
struct PokemonTypes: Decodable {
    let slot: Int
    let type: PokemonType
}

// 포켓몬의 타입 이름을 가진 데이터 타입
struct PokemonType: Decodable {
    let name: String
}
