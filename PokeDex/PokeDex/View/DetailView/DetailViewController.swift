//
//  DetaileViewController.swift
//  PokeDex
//
//  Created by 장상경 on 12/28/24.
//

import UIKit
import SnapKit
import CoreData

// 포켓몬 디테일뷰를 보여주는 뷰 컨트롤러
final class DetailViewController: UIViewController {
    enum DetailState {
        case dex, myPokemon
    }
    
    private var state: DetailState
    
    private var objectID: NSManagedObjectID?
    
    private let detailView: PokemonDetailView // 뷰 컨트롤러 초기화시 주입
    
    private let capturedButton = UIButton()
    
    // MARK: - DetaileViewController Initializer
    init(detailView: PokemonDetailView) {
        self.detailView = detailView
        self.state = .dex
        super.init(nibName: nil, bundle: nil)
    }
    
    init(detailView: PokemonDetailView, _ objectID: NSManagedObjectID) {
        self.detailView = detailView
        self.state = .myPokemon
        self.objectID = objectID
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
private extension DetailViewController {
    
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
        let title = self.state == .dex ? "포획하기" : "놓아주기"
        self.capturedButton.setTitle(title, for: .normal)
        self.capturedButton.setTitleColor(.white, for: .normal)
        self.capturedButton.backgroundColor = .pointBlue
        self.capturedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        self.capturedButton.titleLabel?.numberOfLines = 1
        self.capturedButton.titleLabel?.textAlignment = .center
        self.capturedButton.layer.cornerRadius = 20
    }
    
    func addAction() {
        switch self.state {
        case .dex:
            self.capturedButton.addTarget(self, action: #selector(tryPokemonCapture), for: .touchUpInside)
            
        case .myPokemon:
            self.capturedButton.addTarget(self, action: #selector(throwPokemon), for: .touchUpInside)
        }
    }
    
    @objc func tryPokemonCapture() {
        if CoreDataManager.coreDatashared.readAllData().count >= 6 {
            AlertManager.alert.showAlert(on: self, title: "포획 실패", message: "내 포켓몬이 슬롯이 가득 차서\n더이상 포켓몬을 포획할 수 없습니다.\n내 포켓몬 슬롯을 비운 후\n다시 시도해 주세요.")
            
        } else {
            switch self.detailView.successCapturedPokemon() {
            case true:
                AlertManager.alert.showAlert(on: self, title: "포획 성공!", message: "포켓몬이 내 포켓몬에\n저장되었습니다.")
                
            case false:
                AlertManager.alert.showActionSheet(on: self, message: "포획 실패!", nil)
                
            }
        }
    }
    
    @objc func throwPokemon() {
        AlertManager.alert.confirmThrowPokemon(on: self) { [weak self] in
            guard let self, let id = self.objectID else { return }
            CoreDataManager.coreDatashared.deletePokemon(id)
            
            AlertManager.alert.showActionSheet(on: self, message: "포켓몬을 놓아주었다") {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
