//
//  PokemonCollectionView.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import UIKit
import SnapKit
import RxSwift

final class PokemonCollectionView: UIView {
    
    private let viewModel = MainViewModel(pokemonManager: PokemonManager())
    
    private let disposeBag = DisposeBag()
    
    private var didFeched: Bool = true
    
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
    
    private func setupUI() {
        self.backgroundColor = UIColor.personalDark
        self.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    private func bind() {
        self.viewModel.pokemonImages
            .observe(on: MainScheduler.instance)
            .compactMap { $0.first } // 첫 번째 요소를 안전하게 언래핑
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                
                let image = data.image
                let id = data.id
                
                // 정렬된 상태로 삽입
                self.pokemonImageList.append((image: image, id: id))
                self.pokemonImageList.sort(by: { $0.id < $1.id })
                
                self.collectionView.reloadData()
                self.didFeched = false
                
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: self.disposeBag)
    }

    
}

extension PokemonCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailView = PokemonDetailView(
            image: self.pokemonImageList[indexPath.item].image,
            model: DetailViewModel(pokemonManager: PokemonManager(), id: indexPath.item + 1)
        )
        
        guard let view = self.window?.rootViewController as? UINavigationController else { return }
        view.pushViewController(DetaileViewController(detailView: detailView), animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = scrollView.contentOffset.y
        let visibleHeight = scrollView.contentSize.height
        let totalHeight = scrollView.frame.height
        let threshold = totalHeight - visibleHeight
        
        if currentOffset >= threshold && !self.didFeched {
            self.viewModel.reload()
            self.didFeched = true
        }
    }
}

extension PokemonCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.id, for: indexPath) as? PokemonCell else {
            return UICollectionViewCell()
        }
        
        cell.addImage(self.pokemonImageList[indexPath.item].image)
        
        return cell
    }
    
}
