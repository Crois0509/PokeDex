//
//  MainTabBarController.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit
import RxSwift

// 탭 바 컨트롤러
final class MainTabBarController: UIViewController {
    
    private let mainTabBar = MainTabBarView()
    private let disposeBag = DisposeBag()
    
    private let viewControllers: [UIViewController] // 탭바가 관리할 뷰 컨트롤러 목록
    private var currentVC: UIViewController? // 현재 뷰 컨트롤러
    
    // MARK: - MainTabBarController Initializer
    
    // 초기화시 탭 바가 관리할 뷰 컨트롤러 목록을 파라미터로 받음
    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MainTabBarController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - MainTabBarController UI Setting Method
private extension MainTabBarController {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupLayout()
        displayViewController(0)
        bind()
    }
    
    /// self에 대해 설정하는 메소드
    func configure() {
        self.view.backgroundColor = .personal
        self.view.addSubview(self.mainTabBar)
    }
    
    /// 모든 레이아웃을 설정하는 메소드
    func setupLayout() {
        self.mainTabBar.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
    /// 현재 뷰 컨트롤러를 바꾸는 메소드
    /// - Parameter index: 페이지 인덱스
    func displayViewController(_ index: Int) {
        if let currentVC = self.currentVC {
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }
        
        let selectedVC = viewControllers[index]
        self.addChild(selectedVC)
        self.view.insertSubview(selectedVC.view, belowSubview: self.mainTabBar)
        
        selectedVC.view.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.mainTabBar.snp.top)
        }
        selectedVC.didMove(toParent: self)
        
        self.currentVC = selectedVC
    }
    
    /// 데이터 바인딩 메소드
    func bind() {
        self.mainTabBar.viewModel.pageIndex
            .withUnretained(self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, index in
                
                UIView.transition(with: owner.view, duration: 0.3, options: .transitionCrossDissolve) {
                    owner.displayViewController(index)
                }
                
            }).disposed(by: self.disposeBag)
    }
}
