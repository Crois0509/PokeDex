//
//  MyPokemonCell.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import SnapKit
import Kingfisher

final class MyPokemonCell: UITableViewCell {
    
    static let id: String = "MyPokemonCell"
    
    private let pokemon = UIImageView()
    
    private let numberLabel = UILabel()
    
    private let nameLabel = UILabel()
    
    private let blankLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func configCell(id: Int?, name: String?) {
        if let id = id {
            guard let url = URL(string: APIEndpoint.pokemonImageURL(id: id).urlString) else { return }
            self.pokemon.kf.setImage(with: url)
            self.nameLabel.text = name
            self.numberLabel.text = "No.\(id)"
        } else {
            self.blankLabel.isHidden = false
            guard let url = URL(string: APIEndpoint.monsterBall.urlString) else { return }
            self.pokemon.kf.setImage(with: url)
        }
    }
}

private extension MyPokemonCell {
    
    func setupUI() {
        configure()
        setupImageView()
        setupLabel()
        setupLayout()
    }
    
    func configure() {
        self.backgroundColor = .personalDark
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.personal.cgColor
        self.layer.borderWidth = 5
        [self.pokemon,
         self.numberLabel,
         self.nameLabel,
         self.blankLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setupImageView() {
        self.pokemon.contentMode = .scaleToFill
        self.pokemon.backgroundColor = .white
        self.pokemon.layer.cornerRadius = 25
    }
    
    func setupLabel() {
        [self.numberLabel,
         self.nameLabel,
         self.blankLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            $0.textColor = .white
            $0.numberOfLines = 1
            $0.textAlignment = .left
        }
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        self.blankLabel.isHidden = true
        self.blankLabel.text = "빈 슬롯입니다."
    }
    
    func setupLayout() {
        self.pokemon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        self.numberLabel.snp.makeConstraints {
            $0.leading.equalTo(self.pokemon.snp.trailing).offset(15)
            $0.top.equalToSuperview().inset(15)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.leading.equalTo(self.numberLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        self.blankLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.pokemon.snp.trailing).offset(15)
        }
    }
    
}
