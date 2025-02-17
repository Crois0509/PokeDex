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
    private let oshiMark = UIImageView()
    
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
        self.oshiMark.isHidden = oshiCheck(id: id)
    }
}

// MARK: - SearchTableViewCell UI Setting Method
private extension SearchTableViewCell {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupLabel()
        setupImageView()
        setupLayout()
    }
    
    /// self에 대해 설정하는 메소드
    func configure() {
        self.backgroundColor = .personalDark
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.personal.cgColor
        self.layer.borderWidth = 2.5
        [self.numberLabel, self.nameLabel, self.oshiMark].forEach {
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
    
    /// 이미지뷰를 세팅하는 메소드
    func setupImageView() {
        self.oshiMark.image = UIImage(systemName: "star.fill")
        self.oshiMark.contentMode = .scaleAspectFit
        self.oshiMark.tintColor = .white
        self.oshiMark.backgroundColor = .clear
        self.oshiMark.isHidden = true
    }
    
    /// 모든 레이아웃을 세팅하는 메소드
    func setupLayout() {
        self.numberLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
            $0.leading.equalToSuperview().inset(20)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.numberLabel.snp.trailing).offset(10)
        }
        
        self.oshiMark.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(20)
        }
    }
    
    /// 포켓몬이 내 포켓몬으로 등록되었는지 확인하는 메소드
    /// - Parameter id: 포켓몬 id
    /// - Returns: 등록되었는지 여부
    func oshiCheck(id: Int) -> Bool {
        let oshis = CoreDataManager.coreDatashared.readAllData()
        return oshis.filter { Int($0.id) == id }.isEmpty
    }
}
