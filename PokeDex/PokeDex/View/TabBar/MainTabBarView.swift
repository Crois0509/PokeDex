//
//  MainTabBarView.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit

final class MainTabBarView: UIView {
    
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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        self.layer.shadowOffset = .init(width: 0, height: 2)
        self.layer.shadowRadius = 5
        
        self.addSubview(self.tabBarView)
    }
    
    func setupTabBarViewLayout() {
        self.tabBarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension MainTabBarView: UICollectionViewDelegate {
    
}

extension MainTabBarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
