//
//  SearchView.swift
//  PokeDex
//
//  Created by 장상경 on 12/31/24.
//

import UIKit
import SnapKit
import RxSwift

final class SearchView: UIView {
    
    private let searchBar = UITextField()
    
    private let searchResultsTableView = SearchTableView()
    
    private let viewModel = SearchViewModel(pokemonManager: PokemonManager())
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
}

private extension SearchView {
    
    func setupUI() {
        configure()
        setupSearchBar()
        setupLayout()
        addAction()
        bind()
        setupClosure()
    }
    
    func configure() {
        self.backgroundColor = .clear
        [self.searchBar,
         self.searchResultsTableView
        ].forEach {
            self.addSubview($0)
        }
    }
    
    func setupSearchBar() {
        self.searchBar.backgroundColor = .white
        self.searchBar.placeholder = "포켓몬의 도감 번호나 이름을 입력해 주세요!"
        self.searchBar.textColor = .black
        self.searchBar.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.searchBar.borderStyle = .none
        self.searchBar.layer.cornerRadius = 25
        self.searchBar.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        self.searchBar.leftViewMode = .always
        self.searchBar.clearButtonMode = .whileEditing
        self.searchBar.autocapitalizationType = .none
    }
    
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
    }
    
    func addAction() {
        self.searchBar.addTarget(self, action: #selector(search), for: .editingChanged)
    }
    
    @objc func search() {
        guard let text = self.searchBar.text else { return }
        
        if text.count <= 0 {
            self.searchResultsTableView.resetData()
        } else {
            self.viewModel.search(text: text)
        }
    }
    
    func bind() {
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
    
    func setupClosure() {
        DispatchQueue.main.async {
            self.searchResultsTableView.selectedCell = { [weak self] id in
                guard let self else { return }
                
                let detailView = PokemonDetailView(
                    id: id,
                    model: DetailViewModel(pokemonManager: PokemonManager(), id: id)
                )
                
                guard let view = self.window?.rootViewController as? UINavigationController else { return }
                view.pushViewController(DetaileViewController(detailView: detailView), animated: true)
            }
        }
    }
    
}
