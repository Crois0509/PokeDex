//
//  PokemonDetailView.swift
//  PokeDex
//
//  Created by 장상경 on 12/28/24.
//

import UIKit
import SnapKit

final class PokemonDetailView: UIView {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let detailLabel = UILabel()
    
    init(image: UIImage, data: PokemonDetailDataModel) {
        super.init(frame: .zero)
        self.imageView.image = image
        self.nameLabel.text = "No.\(data.id) \(data.name)"
        self.detailLabel.text = "타입: \(data.types[0].type.name)\n키: \(data.height) m\n몸무게: \(data.weight) kg"
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private func configure() {
        self.backgroundColor = .personalDark
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        [self.imageView,
         self.nameLabel,
         self.detailLabel].forEach { self.addSubview($0) }
        
        setupImage()
        setupNameLabel()
        setupDetailLabel()
        setupLayout()
    }
    
    private func setupImage() {
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = .clear
    }
    
    private func setupNameLabel() {
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.nameLabel.textAlignment = .center
        self.nameLabel.textColor = .white
        self.nameLabel.numberOfLines = 1
        self.nameLabel.backgroundColor = .clear
    }
    
    private func setupDetailLabel() {
        self.detailLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.detailLabel.textAlignment = .center
        self.detailLabel.textColor = .white
        self.detailLabel.numberOfLines = 3
        self.detailLabel.backgroundColor = .clear
    }
    
    private func setupLayout() {
        self.imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(120)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        self.detailLabel.snp.makeConstraints {
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
