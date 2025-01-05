//
//  PokeDexView.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import UIKit
import SnapKit

// 포켓몬 도감 화면을 구현하는 뷰
final class PokeDexView: UIView {
    
    private let logo = UIImageView()
    
    private let view: UIView? // 어떤 뷰를 넣을 것인지 초기화시 선택
    
    // MARK: - PokeDexView Initializer
    init(view: UIView?) {
        self.view = view
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PokeDexView UI Setting Method
private extension PokeDexView {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        setupLogo()
        setupLayout()
        setupLogoGesture()
    }
    
    /// 모든 레이아웃을 세팅하는 메소드
    func setupLayout() {
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
    
    /// 로고의 UI를 세팅하는 메소드
    func setupLogo() {
        self.logo.image = UIImage(named: "pokedexLogo")
        self.logo.backgroundColor = .clear
        self.logo.contentMode = .scaleAspectFit
        self.logo.isUserInteractionEnabled = true
    }
    
    /// 로고에 액션을 추가하는 메소드
    func setupLogoGesture() {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(resetScroll))
        self.logo.addGestureRecognizer(tapped)
    }
    
    /// 스크롤을 리셋하는 메소드
    @objc func resetScroll() {
        if let view = self.view as? PokemonCollectionView {
            view.resetScroll()
        } else if let view = self.view as? SearchView {
            view.resetScroll()
        }
    }
}
