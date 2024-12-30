//
//  MainTabBarCell.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit

final class MainTabBarCell: UICollectionViewCell {
    
    static let id: String = "MainTabBarCell"
    
    private let tabLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.tabLabel.frame.contains(point) {
            return super.hitTest(point, with: event)
        } else {
            return nil
        }
    }
    
    private func setupUI() {
        configure()
        setupLabel()
        setupLayout()
    }
    
    private func configure() {
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.contentView.addSubview(self.tabLabel)
    }
    
    private func setupLabel() {
        self.tabLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        self.tabLabel.textColor = .personalDark
        self.tabLabel.numberOfLines = 1
        self.tabLabel.textAlignment = .center
    }
    
    private func setupLayout() {
        self.tabLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configLabel(title: String) {
        self.tabLabel.text = title
    }
}
