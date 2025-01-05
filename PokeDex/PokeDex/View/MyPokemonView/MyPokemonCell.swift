//
//  MyPokemonCell.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import SnapKit
import Kingfisher

// 내 포켓몬 뷰 커스텀 셀
final class MyPokemonCell: UITableViewCell {
    
    static let id: String = "MyPokemonCell" // 고유 ID
    
    private let pokemon = UIImageView()
    
    private let numberLabel = UILabel()
    
    private let nameLabel = UILabel()
    
    private let blankLabel = UILabel()
    
    // MARK: - MyPokemonCell Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    // 셀 재사용 옵션
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setupUI()
    }
    
    /// 셀의 이미지, 레이블 등을 세팅하는 메소드
    /// - Parameters:
    ///   - id: 포켓몬 id
    ///   - name: 포켓몬 이름
    func configCell(id: Int?, name: String?) {
        if let id = id {
            guard let url = URL(string: APIEndpoint.pokemonImageURL(id: id).urlString) else { return }
            self.pokemon.kf.setImage(with: url)
            self.nameLabel.text = name
            self.nameLabel.isHidden = false
            self.numberLabel.text = "No.\(id)"
            self.numberLabel.isHidden = false
        } else {
            self.blankLabel.isHidden = false
            self.isUserInteractionEnabled = false
            guard let url = URL(string: APIEndpoint.monsterBall.urlString) else { return }
            self.pokemon.kf.setImage(with: url)
        }
    }
}

// MARK: - MyPokemonCell UI Setting Method
private extension MyPokemonCell {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupImageView()
        setupLabel()
        setupLayout()
    }
    
    /// self에 대해 설정하는 메소드
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
    
    /// 이미지뷰를 세팅하는 메소드
    func setupImageView() {
        self.pokemon.contentMode = .scaleToFill
        self.pokemon.backgroundColor = .white
        self.pokemon.layer.cornerRadius = 25
    }
    
    /// 레이블에 대해 세팅하는 메소드
    func setupLabel() {
        [self.numberLabel,
         self.nameLabel,
         self.blankLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            $0.textColor = .white
            $0.numberOfLines = 1
            $0.textAlignment = .left
            $0.isHidden = true
        }
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        self.blankLabel.text = "빈 슬롯입니다."
    }
    
    /// 모든 레이아웃을 세팅하는 메소드
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
