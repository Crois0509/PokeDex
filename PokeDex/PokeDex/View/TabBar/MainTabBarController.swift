//
//  MainTabBarController.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit
import RxSwift

final class MainTabBarController: UIViewController {
    
    private let mainTabBar = MainTabBarView()
    private let disposeBag = DisposeBag()
    
    private let viewControllers: [UIViewController]
    private var currentVC: UIViewController?
    
    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension MainTabBarController {
    
    func setupUI() {
        configure()
        setupLayout()
        displayViewController(0)
        bind()
    }
    
    func configure() {
        self.view.backgroundColor = .personal
        self.view.addSubview(self.mainTabBar)
    }
    
    func setupLayout() {
        self.mainTabBar.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
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
