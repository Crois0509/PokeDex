//
//  MainTabBarController.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit
import RxSwift

// 탭 바 컨트롤러
final class MainTabBarController: UIViewController {
    
    private let mainTabBar = MainTabBarView()
    private let disposeBag = DisposeBag()
    
    private let viewControllers: [UIViewController] // 탭바가 관리할 뷰 컨트롤러 목록
    private var currentVC: UIViewController? // 현재 뷰 컨트롤러
    
    private let blockingView = UIView()
    
    // MARK: - MainTabBarController Initializer
    
    // 초기화시 탭 바가 관리할 뷰 컨트롤러 목록을 파라미터로 받음
    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MainTabBarController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - MainTabBarController UI Setting Method
private extension MainTabBarController {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupBlockingView()
        setupLayout()
        displayViewController(0)
        bind()
        presentSideMenu()
    }
    
    /// self에 대해 설정하는 메소드
    func configure() {
        self.view.backgroundColor = .personal
        self.view.addSubview(self.mainTabBar)
        self.view.addSubview(self.blockingView)
    }
    
    /// 모든 레이아웃을 설정하는 메소드
    func setupLayout() {
        self.mainTabBar.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        self.blockingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 현재 뷰 컨트롤러를 바꾸는 메소드
    /// - Parameter index: 페이지 인덱스
    func displayViewController(_ index: Int) {
        if let currentVC = self.currentVC {
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }
        
        let selectedVC = viewControllers[index]
        self.addChild(selectedVC)
        self.view.insertSubview(selectedVC.view, belowSubview: self.mainTabBar)
        
        selectedVC.view.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.mainTabBar.snp.top)
        }
        selectedVC.didMove(toParent: self)
        
        self.currentVC = selectedVC
    }
    
    /// 데이터 바인딩 메소드
    func bind() {
        self.mainTabBar.viewModel.pageIndex
            .withUnretained(self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, index in
                
                UIView.transition(with: owner.view, duration: 0.3, options: .transitionCrossDissolve) {
                    owner.displayViewController(index)
                }
                
            }).disposed(by: self.disposeBag)
    }
    
    func setupBlockingView() {
        self.blockingView.backgroundColor = .black.withAlphaComponent(0.3)
        self.blockingView.isHidden = true
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(dismissSideMenu))
        self.blockingView.addGestureRecognizer(tapped)
    }
    
    @objc func dismissSideMenu() {
        guard let sideView = self.children.last as? MyPokemonViewController else { return }
        
        UIView.animate(withDuration: 0.5) {
            sideView.view.removeFromSuperview()
            sideView.removeFromParent()
            self.blockingView.isHidden = true
        }
    }
    
    func presentSideMenu() {
        guard let vc = self.viewControllers.first as? MainViewController else { return }
        vc.isPresentSideMenu = {
            let sideView = MyPokemonViewController()
            
            UIView.animate(withDuration: 0.5) {
                self.blockingView.isHidden = false
                self.addChild(sideView)
                self.view.addSubview(sideView.view)
                sideView.view.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                    $0.leading.equalToSuperview().inset(100)
                    $0.trailing.equalToSuperview().offset(100)
                }
                sideView.didMove(toParent: self)
            }
        }
    }
}
