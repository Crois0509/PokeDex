//
//  MainTabBarController.swift
//  PokeDex
//
//  Created by 장상경 on 12/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// 탭 바 컨트롤러
final class MainTabBarController: UIViewController {
    
    private let mainTabBar = MainTabBarView()
    private let disposeBag = DisposeBag()
    
    private let viewControllers: [UIViewController] // 탭바가 관리할 뷰 컨트롤러 목록
    private var currentVC: UIViewController? // 현재 뷰 컨트롤러
    
    private let blockingView = UIView()
    private let tapped = UITapGestureRecognizer()
    
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
    }
    
    /// self에 대해 설정하는 메소드
    func configure() {
        self.view.backgroundColor = .personal
        self.view.addSubview(self.mainTabBar)
        self.view.addSubview(self.blockingView)
    }
    
    /// 사이드바가 열렸을 때 백그라운드 뷰를 세팅하는 메소드
    func setupBlockingView() {
        self.blockingView.backgroundColor = .black.withAlphaComponent(0.3)
        self.blockingView.isHidden = true
        self.blockingView.addGestureRecognizer(self.tapped)
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
        changePageIndex()
        presentSideMenu()
        dismissSideMenu()
    }
    
    /// 현재 탭을 바꾸는 메소드
    func changePageIndex() {
        self.mainTabBar.viewModel.pageIndex
            .withUnretained(self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, index in
                
                UIView.transition(with: owner.view, duration: 0.3, options: .transitionCrossDissolve) {
                    owner.displayViewController(index)
                }
                
            }).disposed(by: self.disposeBag)
    }
    
    /// 사이드 메뉴를 표시하는 메소드
    func presentSideMenu() {
        guard let vc = self.viewControllers.first as? MainViewController else { return }
        vc.tapGesture.rx.event
            .subscribe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, event in
                
                let sideView = MyPokemonViewController()
                
                owner.addChild(sideView)
                owner.view.addSubview(sideView.view)
                sideView.view.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                    $0.leading.equalTo(owner.view.snp.trailing)
                    $0.width.equalTo(sideView.view.bounds.width)
                }
                
                owner.view.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    owner.blockingView.isHidden = false
                    
                    sideView.view.frame.origin.x -= sideView.view.bounds.width - 100
                    
                    owner.view.layoutIfNeeded()
                }, completion: { _ in
                    sideView.didMove(toParent: owner)
                })
                
            }).disposed(by: self.disposeBag)
    }
    
    
    /// 사이드 메뉴를 닫는 메소드
    func dismissSideMenu() {
        self.tapped.rx.event
            .subscribe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, event in
                
                guard let sideView = owner.children.last as? MyPokemonViewController else { return }
                
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    sideView.view.frame.origin.x += sideView.view.bounds.width
                    owner.blockingView.isHidden = true
                    owner.view.layoutIfNeeded()
                    
                }, completion: { _ in
                    sideView.view.removeFromSuperview()
                    sideView.removeFromParent()
                })
                
            }).disposed(by: self.disposeBag)
    }
}
