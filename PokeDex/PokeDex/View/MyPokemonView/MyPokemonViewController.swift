//
//  MyPokemonViewController.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import SnapKit

final class MyPokemonViewController: UIViewController {
    
    private let myPokemonView = MyPokemonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

private extension MyPokemonViewController {
    
    func setupUI() {
        configure()
        setupLayout()
    }
    
    func configure() {
        self.view.backgroundColor = .personal
        self.view.addSubview(self.myPokemonView)
    }
    
    func setupLayout() {
        self.myPokemonView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(100)
        }
    }
    
}
