//
//  SearchTableView.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import SnapKit

final class SearchTableView: UIView {
    
    private let tableView = UITableView()
    
    var searchPokemonList: [(id: Int, name: String)] = []
    
    var selectedCell: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func reloadData() {
        self.searchPokemonList.sort(by: { $0.id < $1.id })
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func resetData() {
        self.searchPokemonList.removeAll()
        self.tableView.reloadData()
    }
    
}

private extension SearchTableView {
    
    func setupUI() {
        configure()
        setupTableView()
        setupLayout()
    }
    
    func configure() {
        self.backgroundColor = .clear
        self.addSubview(self.tableView)
    }
    
    func setupTableView() {
        self.tableView.backgroundColor = .clear
        self.tableView.rowHeight = 50
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
    
    func setupLayout() {
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension SearchTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.searchPokemonList[indexPath.row]
        self.selectedCell?(data.id)
    }
}

extension SearchTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchPokemonList.count
    }
    
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
