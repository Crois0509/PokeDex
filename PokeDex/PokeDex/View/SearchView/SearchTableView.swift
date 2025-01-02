//
//  SearchTableView.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import SnapKit

// 검색 결과 테이블 뷰
final class SearchTableView: UIView {
    
    let tableView = UITableView()
    
    var searchPokemonList: [(id: Int, name: String)] = [] // 검색결과를 담는 배열
        
    // MARK: - SearchTableView Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    /// 검색 결과를 다시 불러오는 메소드
    func reloadData() {
        self.searchPokemonList.sort(by: { $0.id < $1.id })
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    /// 검색 결과를 초기화 하는 메소드
    func resetData() {
        self.searchPokemonList.removeAll()
        self.tableView.reloadData()
    }
    
}

// MARK: - SearchTableView UI Setting Method
private extension SearchTableView {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupTableView()
        setupLayout()
    }
    
    /// self에 대해 설정하는 메소드
    func configure() {
        self.backgroundColor = .clear
        self.addSubview(self.tableView)
    }
    
    /// 테이블뷰를 세팅하는 메소드
    func setupTableView() {
        self.tableView.backgroundColor = .clear
        self.tableView.rowHeight = 50
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.dataSource = self
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
    
    /// 모든 레이아웃을 설정하는 메소드
    func setupLayout() {
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

// MARK: - SearchTableView UITableViewDataSource Method
extension SearchTableView: UITableViewDataSource {
    
    // 셀의 수를 설정하는 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchPokemonList.count
    }
    
    // 셀을 설정하는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        let id = self.searchPokemonList[indexPath.row].id
        let name = self.searchPokemonList[indexPath.row].name
        
        cell.configLabel(id: id, name: name)
        
        return cell
    }
}
