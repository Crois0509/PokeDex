//
//  MainTabBarCell.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit

// 탭 바 셀
final class MainTabBarCell: UICollectionViewCell {
    
    static let id: String = "MainTabBarCell" // 셀 고유 ID
    
    private let tabLabel = UILabel()
    
    // MARK: - MainTabBarCell Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    // 터치영역 설정
    // 레이블 외의 영역을 터치하면 터치 이벤트가 발생하지 않음
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.tabLabel.frame.contains(point) {
            return super.hitTest(point, with: event)
        } else {
            return nil
        }
    }
    
    /// 레이블의 텍스트를 설정하는 메소드
    /// - Parameter title: 레이블 텍스트
    func configLabel(title: String) {
        self.tabLabel.text = title
    }
}

// MARK: - MainTabBarCell UI Setting Method
private extension MainTabBarCell {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupLabel()
        setupLayout()
    }
    
    /// self를 설정하는 메소드
    func configure() {
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.contentView.addSubview(self.tabLabel)
    }
    
    /// 레이블을 세팅하는 메소드
    func setupLabel() {
        self.tabLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        self.tabLabel.textColor = .personalDark
        self.tabLabel.numberOfLines = 1
        self.tabLabel.textAlignment = .center
    }
    
    /// 모든 레이아웃을 세팅하는 메소드
    func setupLayout() {
        self.tabLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    
}
