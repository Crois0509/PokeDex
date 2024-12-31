//
//  MainTabBarView.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit

enum TabBarItem: String, CaseIterable {
    case main = "도감"
    case search = "검색"
}

final class MainTabBarView: UIView {
        
    let viewModel = TabBarViewModel()
    
    private lazy var tabBarView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(MainTabBarCell.self, forCellWithReuseIdentifier: MainTabBarCell.id)
        
        return cv
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = .init(width: UIScreen.main.bounds.width / 2, height: 100)
        
        return layout
    }()
    
    private let effectView = SelectEffect()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
}

private extension MainTabBarView {
    
    func setupUI() {
        configure()
        setupTabBarViewLayout()
        setupEffectView()
    }
    
    func configure() {
        self.backgroundColor = .personal
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .init(width: 0, height: -2)
        self.layer.shadowRadius = 1
        
        [self.tabBarView, self.effectView].forEach { self.addSubview($0) }
    }
    
    func setupTabBarViewLayout() {
        self.tabBarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupEffectView() {
        self.effectView.configLabel(title: TabBarItem.main.rawValue)
        let constraintX: CGFloat = (UIScreen.main.bounds.width / 2) / 2 - 75
        self.effectView.frame = .init(x: constraintX, y: 20, width: 150, height: 60)
    }
    
    func moveEffectView(_ title: TabBarItem) {
        self.effectView.configLabel(title: title.rawValue)
        
        UIView.animate(withDuration: 0.3) {
            switch title {
            case .main:
                self.effectView.frame.origin.x = (self.bounds.width / 2) / 2 - 75
            case .search:
                self.effectView.frame.origin.x = self.bounds.width - ((self.bounds.width / 2) / 2 + 75)
            }
        }
    }
    
}

extension MainTabBarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.changePageIndex(indexPath.item)
        moveEffectView(TabBarItem.allCases[indexPath.item])
    }
}

extension MainTabBarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TabBarItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTabBarCell.id, for: indexPath) as? MainTabBarCell else {
            return UICollectionViewCell()
        }
        
        cell.configLabel(title: TabBarItem.allCases[indexPath.item].rawValue)
        
        return cell
    }
    
    
}
