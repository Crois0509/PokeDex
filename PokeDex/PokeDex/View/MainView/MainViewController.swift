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
    
    lazy var tapGesture = UITapGestureRecognizer()
        
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
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupSideButton()
        setupLayout()
        addTappedAction()
    }
    
    /// self에 대해 설정하는 메소드
    func configure() {
        self.view.backgroundColor = .personal
        [self.pokemonView,
         self.sideMenuButton].forEach { self.view.addSubview($0) }
    }
    
    /// 사이드 버튼을 세팅하는 메소드
    func setupSideButton() {
        self.sideMenuButton.text = "MY"
        self.sideMenuButton.font = .boldSystemFont(ofSize: 20)
        self.sideMenuButton.textColor = .white
        self.sideMenuButton.numberOfLines = 1
        self.sideMenuButton.textAlignment = .center
        self.sideMenuButton.backgroundColor = .clear
        self.sideMenuButton.isUserInteractionEnabled = true
    }
    
    /// 사이드 버튼에 액션을 추가하는 메소드
    func addTappedAction() {
        self.sideMenuButton.addGestureRecognizer(self.tapGesture)
    }
    
    /// 모든 레이아웃을 세팅하는 메소드
    func setupLayout() {
        self.pokemonView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.sideMenuButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
    }
}

