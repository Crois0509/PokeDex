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
    
    var didSelect: ((Int) -> Void)?
    
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
    }
    
    func configure() {
        self.backgroundColor = .personal
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .init(width: 0, height: -2)
        self.layer.shadowRadius = 1
        
        self.addSubview(self.tabBarView)
    }
    
    func setupTabBarViewLayout() {
        self.tabBarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension MainTabBarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?(indexPath.item)
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
