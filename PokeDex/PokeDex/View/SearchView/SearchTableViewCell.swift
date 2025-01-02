//
//  SearchTableViewCell.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import SnapKit

// 테이블뷰 커스텀 셀
final class SearchTableViewCell: UITableViewCell {
    
    static let id: String = "SearchTableViewCell" // 셀 고유 아이디
    
    private let numberLabel = UILabel()
    private let nameLabel = UILabel()
    
    // MARK: - SearchTableViewCell Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    /// 레이블의 텍스트를 설정하는 메소드
    /// - Parameters:
    ///   - id: 포켓몬 ID
    ///   - name: 포켓몬 이름
    func configLabel(id: Int, name: String) {
        self.numberLabel.text = "No.\(id)"
        self.nameLabel.text = name
    }
}

// MARK: - SearchTableViewCell UI Setting Method
private extension SearchTableViewCell {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupLabel()
        setupLayout()
    }
    
    /// self에 대해 설정하는 메소드
    func configure() {
        self.backgroundColor = .personalDark
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.personal.cgColor
        self.layer.borderWidth = 2.5
        [self.numberLabel, self.nameLabel].forEach {
            self.addSubview($0)
        }
    }
    
    /// 레이블을 세팅하는 메소드
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
    
    /// 모든 레이아웃을 세팅하는 메소드
    func setupLayout() {
        self.numberLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
