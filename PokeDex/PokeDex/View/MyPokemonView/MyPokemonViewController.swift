//
//  MyPokemonViewController.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import SnapKit

// 내 포켓몬 뷰 컨트롤러
final class MyPokemonViewController: UIViewController {
    
    private let myPokemonView = MyPokemonView()
    
    // MARK: - MyPokemonViewController Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.myPokemonView.reloadMyPokemons()
    }
}

// MARK: - MyPokemonViewController UI Setting Method
private extension MyPokemonViewController {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupLayout()
    }
    
    /// self에 대해 설정하는 메소드
    func configure() {
        self.view.backgroundColor = .personal
        self.view.addSubview(self.myPokemonView)
    }
    
    /// 모든 레이아웃을 세팅하는 메소드
    func setupLayout() {
        self.myPokemonView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(100)
        }
    }
    
}
