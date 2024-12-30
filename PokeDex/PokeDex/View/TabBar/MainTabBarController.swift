//
//  MainTabBarController.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit

final class MainTabBarController: UIViewController {
    
    private let mainTabBar = MainTabBarView()
    
    private let viewControllers: [UIViewController]
    private var currentVC: UIViewController?
    
    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension MainTabBarController {
    
    func setupUI() {
        configure()
        setupLayout()
        displayViewController(0)
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
    
}
