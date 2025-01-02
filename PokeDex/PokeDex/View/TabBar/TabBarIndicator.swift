//
//  SelectEffect.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit

// 탭 바의 인디케이터
final class TabBarIndicator: UIView {
    
    private let titleLabel = UILabel()
    
    // MARK: - TabBarIndicator Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    /// 인디케이터 레이블을 설정하는 메소드
    /// - Parameter title: 레이블 텍스트
    func configLabel(title: String) {
        self.titleLabel.text = title
    }
    
}

// MARK: - TabBarIndicator UI Setting Method
private extension TabBarIndicator {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupLabel()
        setupLayout()
    }
    
    /// self에 대한 설정을 하는 메소드
    func configure() {
        self.backgroundColor = .personalDark
        self.layer.cornerRadius = 30
        self.addSubview(self.titleLabel)
    }
    
    /// 레이블을 세팅하는 메소드
    func setupLabel() {
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .white
        self.titleLabel.numberOfLines = 1
        self.titleLabel.backgroundColor = .clear
    }
    
    /// 레이아웃을 세팅하는 메소드
    func setupLayout() {
        self.titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
