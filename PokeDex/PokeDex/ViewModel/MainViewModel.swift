//
//  MainViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import UIKit
import RxSwift

final class MainViewModel {
    private let limit: Int = 20
    private let offset: Int = 0
    
    let disposeBag = DisposeBag()
    
    let pokeDexData = BehaviorSubject(value: [PokemonDataModel]())
}
