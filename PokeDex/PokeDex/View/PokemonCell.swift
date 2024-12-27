//
//  PokemonCell.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import UIKit
import SnapKit

final class PokemonCell: UICollectionViewCell {
    static let id: String = "PokemonCell"
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        self.addSubview(self.imageView)
        setupImageView()
    }
    
    private func setupImageView() {
        self.imageView.backgroundColor = .clear
        self.imageView.contentMode = .scaleAspectFit
        
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func addImage(_ image: UIImage?) {
        self.imageView.image = image
    }
}
