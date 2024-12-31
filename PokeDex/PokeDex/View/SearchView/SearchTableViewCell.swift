//
//  SearchTableViewCell.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import SnapKit

final class SearchTableViewCell: UITableViewCell {
    
    static let id: String = "SearchTableViewCell"
    
    private let numberLabel = UILabel()
    private let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func configLabel(id: Int, name: String) {
        self.numberLabel.text = "No.\(id)"
        self.nameLabel.text = name
    }
}

private extension SearchTableViewCell {
    
    func setupUI() {
        configure()
        setupLabel()
        setupLayout()
    }
    
    func configure() {
        self.backgroundColor = .personalDark
        self.layer.cornerRadius = 20
        [self.numberLabel, self.nameLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setupLabel() {
        [self.numberLabel, self.nameLabel].forEach {
            $0.textColor = .white
            $0.backgroundColor = .clear
            $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            $0.numberOfLines = 1
        }
        self.numberLabel.textAlignment = .left
        self.nameLabel.textAlignment = .right
    }
    
    func setupLayout() {
        self.numberLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
