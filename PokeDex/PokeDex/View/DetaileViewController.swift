//
//  DetaileViewController.swift
//  PokeDex
//
//  Created by 장상경 on 12/28/24.
//

import UIKit
import SnapKit

final class DetaileViewController: UIViewController {
    
    private let detailView: PokemonDetailView
    
    init(detailView: PokemonDetailView) {
        self.detailView = detailView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .pointBlue
        self.view.backgroundColor = .personal
        self.view.addSubview(self.detailView)
        
        setupDetailViewLayout()
    }
    
    private func setupDetailViewLayout() {
        self.detailView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(self.view.bounds.height * 0.5)
        }
    }
}
