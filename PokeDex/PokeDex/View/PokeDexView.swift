//
//  PokeDexView.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import UIKit
import SnapKit

final class PokeDexView: UIView {
    
    private let logo = UIImageView()
    
    private let view: UIView?
    
    init(view: UIView?) {
        self.view = view
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupLogo()
        setupLayout()
    }
    
    private func setupLayout() {
        [self.logo, self.view!].forEach { self.addSubview($0) }
        
        self.logo.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        self.view?.snp.makeConstraints {
            $0.top.equalTo(self.logo.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupLogo() {
        self.logo.image = UIImage(named: "pokedexLogo")
        self.logo.backgroundColor = .clear
        self.logo.contentMode = .scaleAspectFit
    }
}
