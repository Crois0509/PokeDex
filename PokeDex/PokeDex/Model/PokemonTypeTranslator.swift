//
//  PokemonTypeTranslator.swift
//  PokeDex
//
//  Created by 장상경 on 12/28/24.
//

import Foundation

enum PokemonTypeName {
    private static let koreanTypeName: [String: String] = [
        "normal": "노말",
        "fire": "불꽃",
        "water": "물",
        "electric": "전기",
        "grass": "풀",
        "ice": "얼음",
        "fighting": "격투",
        "poison": "독",
        "ground": "땅",
        "flying": "비행",
        "psychic": "에스퍼",
        "bug": "벌레",
        "rock": "바위",
        "ghost": "고스트",
        "dragon": "드래곤",
        "dark": "어둠",
        "steel": "강철",
        "fairy": "페어리"
    ]
    
    static func getKoreanTypeName(for type: String) -> String {
        return koreanTypeName[type.lowercased()] ?? type
    }
}
