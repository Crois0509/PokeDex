//
//  ViewController.swift
//  PokeDex
//
//  Created by 장상경 on 12/26/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var pokemonView = PokeDexView(view: PokemonCollectionView())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        self.view.backgroundColor = .personal
        self.view.addSubview(self.pokemonView)
        
        self.pokemonView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

