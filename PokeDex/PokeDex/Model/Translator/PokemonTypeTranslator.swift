//
//  PokemonTypeTranslator.swift
//  PokeDex
//
//  Created by 장상경 on 12/28/24.
//

import Foundation

// 포켓몬의 타입을 한국어로 변환해주는 enum
enum PokemonTypeName {
    // 타입의 영어이름과 한국어 이름을 매칭한 배열
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
    
    /// 영어로 된 타입 이름을 한국어로 바꿔주는 메소드
    /// - Parameter type: 타입의 영어명
    /// - Returns: 타입의 한국어명 -> 매칭되는 값이 없을 경우 입력한 영어명을 그대로 사용
    static func getKoreanTypeName(for type: String) -> String {
        return koreanTypeName[type.lowercased()] ?? type
    }
}
