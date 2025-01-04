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
    
    private let sideMenuButton = UILabel()
    
    var isPresentSideMenu: (() -> Void)?
    
    // MARK: - MainViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
}
// MARK: - MainViewController UI Setting Method
private extension MainViewController {
    
    /// VC와 뷰를 세팅하는 메소드
    func setupUI() {
        configure()
        setupSideButton()
        setupLayout()
        addTappedAction()
    }
    
    func configure() {
        self.view.backgroundColor = .personal
        [self.pokemonView,
         self.sideMenuButton].forEach { self.view.addSubview($0) }
    }
    
    func setupSideButton() {
        self.sideMenuButton.text = "My"
        self.sideMenuButton.font = .boldSystemFont(ofSize: 20)
        self.sideMenuButton.textColor = .white
        self.sideMenuButton.numberOfLines = 1
        self.sideMenuButton.textAlignment = .center
        self.sideMenuButton.backgroundColor = .clear
        self.sideMenuButton.isUserInteractionEnabled = true
    }
    
    func addTappedAction() {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(presentSideMenu))
        self.sideMenuButton.addGestureRecognizer(tapped)
    }
    
    @objc func presentSideMenu() {
        self.isPresentSideMenu?()
    }
        
    func setupLayout() {
        self.pokemonView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.sideMenuButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalToSuperview().inset(30)
        }
    }
}

