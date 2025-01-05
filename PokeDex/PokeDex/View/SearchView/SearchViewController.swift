//
//  SearchViewController.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import SnapKit

// 검색뷰 컨트롤러
final class SearchViewController: UIViewController {
    
    private let searchView = PokeDexView(view: SearchView()) // 검색 화면
    
    // MARK: - SearchViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // 뷰 컨트롤러 터치시 편집을 종료(키보드 내리기)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - SearchViewController UI Setting Method
private extension SearchViewController {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupLayout()
    }
    
    /// self에 대한 설정을 하는 메소드
    func configure() {
        self.view.backgroundColor = .personal
        self.view.addSubview(self.searchView)
    }
    
    /// 모든 레이아웃을 설정하는 메소드
    func setupLayout() {
        self.searchView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
