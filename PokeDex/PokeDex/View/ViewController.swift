//
//  ViewController.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    private lazy var testVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .personal
        return vc
    }()
    
    private lazy var mainVC = MainTabBarController(viewControllers: [
        MainViewController(),
        self.testVC
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(mainVC)
        view.addSubview(mainVC.view)
        mainVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainVC.didMove(toParent: self)
    }
    
}
