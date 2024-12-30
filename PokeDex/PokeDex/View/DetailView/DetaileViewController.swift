//
//  DetaileViewController.swift
//  PokeDex
//
//  Created by 장상경 on 12/28/24.
//

import UIKit
import SnapKit

// 포켓몬 디테일뷰를 보여주는 뷰 컨트롤러
final class DetaileViewController: UIViewController {
    
    private let detailView: PokemonDetailView // 뷰 컨트롤러 초기화시 주입
    
    // MARK: - DetaileViewController Initializer
    init(detailView: PokemonDetailView) {
        self.detailView = detailView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DetaileViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - DetaileViewController UI Setting Method
private extension DetaileViewController {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupDetailViewLayout()
    }
    
    /// 뷰 컨트롤러를 설정하는 메소드
    func configure() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .pointBlue
        self.view.backgroundColor = .personal
        self.view.addSubview(self.detailView)
    }
    
    /// 디테일뷰의 레이아웃을 설정하는 메소드
    func setupDetailViewLayout() {
        self.detailView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(self.view.bounds.height * 0.5)
        }
    }
}
