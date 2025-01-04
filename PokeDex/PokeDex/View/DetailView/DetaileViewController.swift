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
    
    private let capturedButton = UIButton()
    
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
        setupCapturedButton()
        addAction()
        setupDetailViewLayout()
    }
    
    /// 뷰 컨트롤러를 설정하는 메소드
    func configure() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .pointBlue
        self.view.backgroundColor = .personal
        self.view.addSubview(self.detailView)
        self.view.addSubview(self.capturedButton)
    }
    
    func setupCapturedButton() {
        self.capturedButton.setTitle("포획하기", for: .normal)
        self.capturedButton.setTitleColor(.white, for: .normal)
        self.capturedButton.backgroundColor = .pointBlue
        self.capturedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        self.capturedButton.titleLabel?.numberOfLines = 1
        self.capturedButton.titleLabel?.textAlignment = .center
        self.capturedButton.layer.cornerRadius = 20
    }
    
    func addAction() {
        self.capturedButton.addTarget(self, action: #selector(tryPokemonCapture), for: .touchUpInside)
    }
    
    @objc func tryPokemonCapture() {
        
    }
    
    /// 디테일뷰의 레이아웃을 설정하는 메소드
    func setupDetailViewLayout() {
        self.detailView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(self.view.bounds.height * 0.5)
        }
        
        self.capturedButton.snp.makeConstraints {
            $0.top.equalTo(self.detailView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(60)
        }
    }
}
