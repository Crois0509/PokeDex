//
//  ViewController.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import UIKit
import SnapKit

// 메인화면 뷰를 보여주는 뷰 컨트롤러
class MainViewController: UIViewController {
    
    private lazy var pokemonView = PokeDexView(view: PokemonCollectionView()) // 메인화면 뷰

    // MARK: - MainViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - MainViewController UI Setting Method
    
    /// VC와 뷰를 세팅하는 메소드
    private func setupUI() {
        self.view.backgroundColor = .personal
        self.view.addSubview(self.pokemonView)
        
        self.pokemonView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

