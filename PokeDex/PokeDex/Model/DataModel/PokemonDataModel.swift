//
//  PokemonData.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import Foundation

// 포켓몬 리스트를 가져오는 데이터 타입
struct PokemonDataModel: Decodable {
    let next: String
    let results: [PokemonData]
}

// 각 포켓몬의 데이터를 담은 데이터 타입
struct PokemonData: Decodable {
    let name: String
    let url: String
}
