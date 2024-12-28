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
    
    private var pokemonImageList: [UIImage] = []
    
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
            .subscribe(onNext: { [weak self] images in
                DispatchQueue.main.async {
                    self?.pokemonImageList.append(contentsOf: images)
                    self?.collectionView.reloadData()
                }
                
            }, onError: { error in
                print(error)
                
            }).disposed(by: self.viewModel.disposeBag)
    }
    
}

extension PokemonCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailView = PokemonDetailView(
            image: self.pokemonImageList[indexPath.item],
            model: DetailViewModel(pokemonManager: PokemonManager(), id: indexPath.item)
        )
        
        guard let view = self.window?.rootViewController as? UINavigationController else { return }
        view.pushViewController(DetaileViewController(detailView: detailView), animated: true)
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
        
        cell.addImage(self.pokemonImageList[indexPath.item])
        
        return cell
    }
    
}
