//
//  SearchView.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import SnapKit

final class SearchView: UIView {
    
    private let searchBar = UITextField()
    private let searchResultsTableView = SearchTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
}

private extension SearchView {
    
    func setupUI() {
        configure()
        setupSearchBar()
        setupLayout()
    }
    
    func configure() {
        self.backgroundColor = .clear
        [self.searchBar, self.searchResultsTableView].forEach {
            self.addSubview($0)
        }
    }
    
    func setupSearchBar() {
        self.searchBar.placeholder = "포켓몬의 도감 번호나 이름을 입력해 주세요!"
        self.searchBar.textColor = .black
        self.searchBar.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.searchBar.borderStyle = .none
        self.searchBar.layer.cornerRadius = 25
        self.searchBar.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.searchBar.clearButtonMode = .whileEditing
    }
    
    func setupLayout() {
        self.searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        self.searchResultsTableView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar.snp.bottom).offset(20)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }
    
}
