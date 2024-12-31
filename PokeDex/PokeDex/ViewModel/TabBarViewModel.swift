//
//  TabBarViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import RxCocoa

final class TabBarViewModel {
    
    let pageIndex = PublishRelay<Int>()
    
    func changePageIndex(_ index: Int) {
        self.pageIndex.accept(index)
    }
}
