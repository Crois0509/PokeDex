//
//  MyPokemonView.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import SnapKit

final class MyPokemonView: UIView {
    
    private let titleLabel = UILabel()
    
    private let myPokemonTable = UITableView()
    
    private let infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
}

private extension MyPokemonView {
    
    func setupUI() {
        configure()
        setupTitleLabel()
        setupTableView()
        setupInfoLabel()
        setupLayout()
    }
    
    func configure() {
        self.backgroundColor = .clear
        [self.titleLabel,
         self.myPokemonTable,
         self.infoLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setupTitleLabel() {
        self.titleLabel.text = "내 포켓몬"
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 50)
        self.titleLabel.textColor = .white
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textAlignment = .center
        self.titleLabel.backgroundColor = .clear
    }
    
    func setupTableView() {
        self.myPokemonTable.dataSource = self
        self.myPokemonTable.backgroundColor = .clear
        self.myPokemonTable.rowHeight = 80
        self.myPokemonTable.separatorStyle = .none
        self.myPokemonTable.showsVerticalScrollIndicator = false
        self.myPokemonTable.showsHorizontalScrollIndicator = false
        self.myPokemonTable.isScrollEnabled = true
        self.myPokemonTable.register(MyPokemonCell.self, forCellReuseIdentifier: MyPokemonCell.id)
    }
    
    func setupInfoLabel() {
        self.infoLabel.text = "최대 6마리까지 등록 가능합니다"
        self.infoLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.infoLabel.textColor = .personalDark
        self.infoLabel.numberOfLines = 1
        self.infoLabel.textAlignment = .center
        self.infoLabel.backgroundColor = .clear
    }
    
    func setupLayout() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        self.myPokemonTable.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(10)
//            $0.height.equalTo(500)
        }
        
        self.infoLabel.snp.makeConstraints {
            $0.top.equalTo(self.myPokemonTable.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
}

extension MyPokemonView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPokemonCell.id, for: indexPath) as? MyPokemonCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}
