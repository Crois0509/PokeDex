//
//  SearchView.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// 포켓몬 검색 뷰
final class SearchView: UIView {
    
    private let searchBar = UITextField() // 검색바
    
    private let searchResultsTableView = SearchTableView() // 검색 결과 테이블
    
    private let resultLabel = UILabel() // 검색 결과에 대한 레이블
    
    private let clearButton = UIButton()
    
    private let viewModel = SearchViewModel(pokemonManager: PokemonManager()) // 로직 및 데이터 바인딩 객체
    
    private let disposeBag = DisposeBag()
    
    // MARK: - SearchView Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
}

// MARK: - SearchView UI Setting Method
private extension SearchView {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupSearchBar()
        setupResultLabel()
        setupClearButton()
        setupLayout()
        addAction()
        hideKeyboardWhenTappedAround()
        bind()
        changeSearchResult()
    }
    
    /// self에 대한 설정을 하는 메소드
    func configure() {
        self.backgroundColor = .clear
        [self.searchBar,
         self.searchResultsTableView,
         self.resultLabel,
         self.clearButton
        ].forEach {
            self.addSubview($0)
        }
    }
    
    /// 검색바에 대한 세팅을 하는 메소드
    func setupSearchBar() {
        self.searchBar.backgroundColor = .white
        self.searchBar.textColor = .black
        self.searchBar.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.searchBar.borderStyle = .none
        self.searchBar.layer.cornerRadius = 25
        self.searchBar.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        self.searchBar.leftViewMode = .always
        self.searchBar.autocapitalizationType = .none
        self.searchBar.keyboardType = .default
        
        setupPlaceHolder()
    }
    
    /// 클리어버튼을 세팅하는 메소드
    func setupClearButton() {
        self.clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        self.clearButton.tintColor = .gray
        self.clearButton.backgroundColor = .clear
        self.clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        self.clearButton.isHidden = true
    }
    
    /// 텍스트필드 플레이스홀더를 세팅하는 메소드
    func setupPlaceHolder() {
        let placeholderText = "포켓몬의 도감 번호나 이름을 입력해 주세요!"
        self.searchBar.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.3)]
        )
    }
    
    /// 검색 결과 레이블에 대한 세팅을 하는 메소드
    func setupResultLabel() {
        self.resultLabel.text = "검색 결과가 없습니다"
        self.resultLabel.textColor = .personalDark
        self.resultLabel.numberOfLines = 1
        self.resultLabel.textAlignment = .center
        self.resultLabel.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    /// 검색 결과 레이블의 상태를 변경하는 메소드
    func changeSearchResult() {
        switch self.searchResultsTableView.searchPokemonList.isEmpty {
        case true:
            self.resultLabel.isHidden = false
        case false:
            self.resultLabel.isHidden = true
        }
    }
    
    /// 모든 UI의 레이아웃을 설정하는 메소드
    func setupLayout() {
        self.searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(50)
        }
        
        self.searchResultsTableView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar.snp.bottom).offset(20)
            $0.trailing.leading.bottom.equalToSuperview().inset(10)
        }
        
        self.resultLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.clearButton.snp.makeConstraints {
            $0.trailing.equalTo(self.searchBar.snp.trailing).inset(10)
            $0.centerY.equalTo(self.searchBar)
            $0.width.height.equalTo(30)
        }
    }
    
    /// 키보드를 숨기는 메소드
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    /// 검색바에 액션을 추가하는 메소드
    func addAction() {
        self.searchBar.addTarget(self, action: #selector(search), for: .editingChanged)
    }
    
    /// 데이터 바인딩 메소드
    func bind() {
        bindSearchPokemonList()
        bindTableViewSelect()
    }
    
    /// 검색 결과에 대한 데이터 바인딩 메소드
    func bindSearchPokemonList() {
        self.viewModel.searchPokemonList
            .withUnretained(self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, data in
                
                owner.searchResultsTableView.searchPokemonList = data
                owner.searchResultsTableView.reloadData()
                
            }, onError: { error in
                print(error)
                
            }).disposed(by: self.disposeBag)
    }
    
    /// 테이블뷰 셀 선택에 대한 데이터 바인딩 메소드
    func bindTableViewSelect() {
        self.searchResultsTableView.tableView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                
                let id = owner.searchResultsTableView.searchPokemonList[indexPath.row].id
                owner.presentDetailView(id: id)
                
            }, onError: { error in
                
                print(error)
                
            }).disposed(by: self.disposeBag)
    }
    
    /// 네비게이션을 통해 디테일뷰로 이동하는 메소드
    /// - Parameter id: 포켓몬의 ID
    func presentDetailView(id: Int) {
        DispatchQueue.main.async {
            let detailView = PokemonDetailView(
                id: id,
                model: DetailViewModel(pokemonManager: PokemonManager(), id: id)
            )
            
            guard let view = self.window?.rootViewController as? UINavigationController else { return }
            view.pushViewController(DetaileViewController(detailView: detailView), animated: true)
        }
    }
    
}

// MARK: - SearchView Objective-C Method
@objc extension SearchView {
    
    /// 검색바의 텍스트에 변화가 생겼을 때 실행되는 액션
    func search() {
        guard let text = self.searchBar.text else { return }
        
        if text.count <= 0 {
            self.searchResultsTableView.resetData()
            self.clearButton.isHidden = true
            changeSearchResult()
        } else {
            self.searchResultsTableView.resetData()
            self.viewModel.search(text: text)
            self.clearButton.isHidden = false
            changeSearchResult()
        }
    }
    
    /// 현재 뷰를 초기상태로 복원
    func hideKeyboard() {
        self.endEditing(true)
    }
    
    /// 검색바를 클리어하는 액션
    func clearText() {
        self.searchBar.text = ""
        search()
    }
}
