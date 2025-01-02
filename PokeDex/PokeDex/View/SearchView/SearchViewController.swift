//
//  SearchViewController.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let searchView = PokeDexView(view: SearchView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        configure()
        setupLayout()
    }
    
    private func configure() {
        self.view.backgroundColor = .personal
        self.view.addSubview(self.searchView)
    }
    
    private func setupLayout() {
        self.searchView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
