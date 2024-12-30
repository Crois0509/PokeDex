//
//  SelectEffect.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit

final class SelectEffect: UIView {
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func configLabel(title: String) {
        self.titleLabel.text = title
    }
    
}

private extension SelectEffect {
    
    func setupUI() {
        configure()
        setupLabel()
        setupLayout()
    }
    
    func configure() {
        self.backgroundColor = .personalDark
        self.layer.cornerRadius = 30
        self.addSubview(self.titleLabel)
    }
    
    func setupLabel() {
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .white
        self.titleLabel.numberOfLines = 1
        self.titleLabel.backgroundColor = .clear
    }
    
    func setupLayout() {
        self.titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
