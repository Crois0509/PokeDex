//
//  TabBarViewModel.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import RxCocoa

// 탭바의 뷰 모델
final class TabBarViewModel {
    
    let pageIndex = PublishRelay<Int>() // 현재 페이지 인덱스
    
    /// 페이지 인덱스를 바꾸고 이벤트를 방출하는 메소드
    /// - Parameter index: 페이지 인덱스
    func changePageIndex(_ index: Int) {
        self.pageIndex.accept(index)
    }
}
