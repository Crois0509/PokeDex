//
//  PokemonCollectionView.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// 포켓몬 도감 리스트를 보여주는 뷰
final class PokemonCollectionView: UIView {
    
    private let viewModel = MainViewModel(pokemonManager: PokemonManager()) // 로직 및 데이터 바인딩 객체
    
    private let disposeBag = DisposeBag()
    
    private var didFeched: Bool = true // 현재 데이터를 불러오는 중인지 확인
    
    private var pokemonList: [PokemonData] = []
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.id)
        
        return cv
    }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let width = (UIScreen.main.bounds.width / 3) - 15
        layout.itemSize = .init(width: width, height: width)
        
        return layout
    }()
    
    private var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - PokemonCollectionView Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        bind()
        setupUI()
    }
}

// MARK: - PokemonCollectionView UI Setting Method
private extension PokemonCollectionView {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupActivityIndicator()
        setupLayout()
    }
    
    /// 뷰를 세팅하는 메소드
    func configure() {
        self.backgroundColor = UIColor.personalDark
        [self.collectionView,
         self.activityIndicator].forEach { self.addSubview($0) }
    }
    
    /// 로딩바를 세팅하는 메소드
    func setupActivityIndicator() {
        self.activityIndicator.color = .white
        self.activityIndicator.style = .large
        self.activityIndicator.backgroundColor = .black.withAlphaComponent(0.3)
        self.activityIndicator.isHidden = true
    }
    
    /// 모든 UI의 레이아웃을 설정하는 메소드
    func setupLayout() {
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        self.activityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 데이터 로드 상태에 따라 로딩바 액션을 지정하는 메소드
    func dataFetched() {
        switch self.didFeched {
        case true:
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
        case false:
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    /// 데이터 바인딩 메소드
    func bind() {
        bindPokemonList()
        bindSelectCell()
        bindDidScroll()
    }
    
    /// 포켓몬 리스트를 바인딩하는 메소드
    func bindPokemonList() {
        self.viewModel.pokemonList
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, data in
                
                owner.pokemonList += data
                
                owner.collectionView.reloadData()
                owner.didFeched = false
                owner.dataFetched()
                
            }, onError: { [weak self] error in
                print("Error: \(error)")
                self?.didFeched = false
                self?.dataFetched()
                
            }).disposed(by: self.disposeBag)
    }
    
    /// 컬렉션뷰의 아이템 선택에 대해 바인딩하는 메소드
    func bindSelectCell() {
        self.collectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, indexPath in
                
                let detailView = PokemonDetailView(
                    id: indexPath.item + 1,
                    model: DetailViewModel(pokemonManager: PokemonManager(), id: indexPath.item + 1)
                )
                
                guard let view = owner.window?.rootViewController as? UINavigationController else { return }
                view.pushViewController(DetaileViewController(detailView: detailView), animated: true)
                
            }, onError: { error in
                
                print(error)
                
            }).disposed(by: self.disposeBag)
    }
    
    /// 컬렉션뷰의 스크롤에 대해 바인딩하는 메소드
    func bindDidScroll() {
        self.collectionView.rx.didScroll
            .withUnretained(self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, scrollView in
                
                let currentOffset = owner.collectionView.contentOffset.y
                let visibleHeight = owner.collectionView.contentSize.height
                let totalHeight = owner.frame.height
                let threshold = visibleHeight - totalHeight + 100
                
                if currentOffset > threshold && !owner.didFeched {
                    guard self.viewModel.getCurrentOffset() else { return }
                    owner.viewModel.reload()
                    owner.didFeched = true
                    owner.dataFetched()
                }
                
            }, onError: { error in
                
                print(error)
                
            }).disposed(by: self.disposeBag)
    }
    
}

// MARK: - PokemonCollectionView CollectionView DataSource Method
extension PokemonCollectionView: UICollectionViewDataSource {
    
    // 컬렉션뷰 아이템 수를 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    // 컬렉션뷰의 아이템을 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.id, for: indexPath) as? PokemonCell else {
            return UICollectionViewCell()
        }
        
        cell.addImage(indexPath.item + 1)
        
        return cell
    }
    
}
