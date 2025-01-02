//
//  MainTabBarView.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

// 탭 바 아이템 스페이스
enum TabBarItem: String, CaseIterable {
    case main = "도감"
    case search = "검색"
}

// 탭 바 뷰
final class MainTabBarView: UIView {
        
    let viewModel = TabBarViewModel() // 로직 및 데이터 바인딩 객체
    
    private let disposeBag = DisposeBag()
    
    private lazy var tabBarView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
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
    
    private let effectView = TabBarIndicator() // 애니메이션 인디케이터
    
    // MARK: - MainTabBarView Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
}

// MARK: - MainTabBarView UI Setting Method
private extension MainTabBarView {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupTabBarViewLayout()
        setupEffectView()
        bind()
    }
    
    /// self에 대해 설정하는 메소드
    func configure() {
        self.backgroundColor = .personal
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .init(width: 0, height: -2)
        self.layer.shadowRadius = 1
        
        [self.tabBarView, self.effectView].forEach { self.addSubview($0) }
    }
    
    /// 모든 레이아웃을 세팅하는 메소드
    func setupTabBarViewLayout() {
        self.tabBarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 인디케이터를 세팅하는 메소드
    func setupEffectView() {
        self.effectView.configLabel(title: TabBarItem.main.rawValue)
        let constraintX: CGFloat = (UIScreen.main.bounds.width / 2) / 2 - 75
        self.effectView.frame = .init(x: constraintX, y: 20, width: 150, height: 60)
    }
    
    /// 데이터 바인딩 메소드
    func bind() {
        self.tabBarView.rx.itemSelected
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                
                self?.viewModel.changePageIndex(indexPath.item)
                self?.moveEffectView(TabBarItem.allCases[indexPath.item])
                
            }, onError: { error in
                
                print(error)
                
            }).disposed(by: self.disposeBag)
            
    }
    
    /// 인디케이터의 애니메이션을 설정하는 메소드
    /// - Parameter title: 인디케이터의 레이블 값
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

// MARK: - MainTabBarView UICollectionViewDataSource Method
extension MainTabBarView: UICollectionViewDataSource {
    
    // 셀 수량 설정 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TabBarItem.allCases.count
    }
    
    // 셀 설정 메소드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTabBarCell.id, for: indexPath) as? MainTabBarCell else {
            return UICollectionViewCell()
        }
        
        cell.configLabel(title: TabBarItem.allCases[indexPath.item].rawValue)
        
        return cell
    }
    
    
}
