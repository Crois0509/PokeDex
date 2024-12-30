//
//  PokemonCollectionView.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import UIKit
import SnapKit
import RxSwift

// 포켓몬 도감 리스트를 보여주는 뷰
final class PokemonCollectionView: UIView {
    
    private let viewModel = MainViewModel(pokemonManager: PokemonManager()) // 로직 및 데이터 바인딩 객체
    
    private let disposeBag = DisposeBag()
    
    private var didFeched: Bool = true // 현재 데이터를 불러오는 중인지 확인
    
    private var pokemonImageList: [(image: UIImage,id: Int)] = []
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.delegate = self
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
    
    // MARK: - PokemonCollectionView Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
        bind()
    }
}

// MARK: - PokemonCollectionView UI Setting Method
private extension PokemonCollectionView {
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        self.backgroundColor = UIColor.personalDark
        self.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    /// 데이터 바인딩 메소드
    func bind() {
        self.viewModel.pokemonImages
            .observe(on: MainScheduler.instance)
//            .compactMap { $0.first }
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                
//                let image = data.image
//                let id = data.id
                
//                self.pokemonImageList.append((image: image, id: id))
                self.pokemonImageList += data
                self.pokemonImageList.sort(by: { $0.id < $1.id })
                
                self.collectionView.reloadData()
                self.didFeched = false
                
            }, onError: { error in
                print("Error: \(error)")
                
            }).disposed(by: self.disposeBag)
    }
    
    
}

// MARK: - PokemonCollectionView CollectionView Delegate Method
extension PokemonCollectionView: UICollectionViewDelegate {
    
    // 셀이 선택되었을 때 액션 구현
    // 선택된 셀의 포켓몬 정보를 확인할 수 있도록 네비게이션 구현
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailView = PokemonDetailView(
            image: self.pokemonImageList[indexPath.item].image,
            model: DetailViewModel(pokemonManager: PokemonManager(), id: indexPath.item + 1)
        )
        
        guard let view = self.window?.rootViewController as? UINavigationController else { return }
        view.pushViewController(DetaileViewController(detailView: detailView), animated: true)
    }
    
    // 스크롤이 진행 중일 때 액션
    // 현재 스크롤 위치를 확인하여 스크롤이 최하단에 있는 경우 데이터를 더 불러온다.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let visibleHeight = scrollView.contentSize.height
        let totalHeight = scrollView.frame.height
        let threshold = visibleHeight - totalHeight - 500
        
        if currentOffset >= threshold && !self.didFeched {
            self.viewModel.reload()
            self.didFeched = true
            self.layoutIfNeeded()
        }
    }
}

// MARK: - PokemonCollectionView CollectionView DataSource Method
extension PokemonCollectionView: UICollectionViewDataSource {
    
    // 컬렉션뷰 아이템 수를 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonImageList.count
    }
    
    // 컬렉션뷰의 아이템을 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.id, for: indexPath) as? PokemonCell else {
            return UICollectionViewCell()
        }
        
        cell.addImage(self.pokemonImageList[indexPath.item].image)
        
        return cell
    }
    
}
