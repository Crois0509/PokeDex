//
//  PokemonDetailView.swift
//  PokeDex
//
//  Created by 장상경 on 12/28/24.
//

import UIKit
import SnapKit
import RxSwift

final class PokemonDetailView: UIView {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: DetailViewModel
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let detailLabel = UILabel()
    
    init(image: UIImage, model: DetailViewModel) {
        self.viewModel = model
        super.init(frame: .zero)
        
        configure()
        bind()
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .personalDark
        self.layer.cornerRadius = 20
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
        self.imageView.image = UIImage(systemName: "person") // 테스트
    }
    
    private func setupNameLabel() {
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.nameLabel.textAlignment = .center
        self.nameLabel.textColor = .white
        self.nameLabel.numberOfLines = 1
        self.nameLabel.backgroundColor = .clear
    }
    
    private func setupDetailLabel() {
        self.detailLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        self.detailLabel.textAlignment = .center
        self.detailLabel.textColor = .white
        self.detailLabel.numberOfLines = 3
        self.detailLabel.backgroundColor = .clear
    }
    
    private func setupLayout() {
        self.imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(250)
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
    
    private func labelConfig(id: Int, name: String, type: String, height: Double, weight: Double) {
        self.nameLabel.text = "No.\(id) \(name)"
        self.detailLabel.text = "타입: \(type)\n키: \(height) m\n몸무게: \(weight) kg"
        self.detailLabel.lineSpacing(10)
    }
    
    private func bind() {
        self.viewModel.pokemonDetailData
            .subscribe(onNext: { [weak self] data in
                guard let self, let data = data.first else { return }
                var type: String = ""
                
                if data.types.count > 1 {
                    var types = [String](repeating: "", count: data.types.count)
                    for type in data.types {
                        let typeName = PokemonTypeName.getKoreanTypeName(for: type.type.name)
                        
                        types[type.slot - 1] = typeName
                    }
                    type = types.joined(separator: ", ")
                    
                } else {
                    let typeName = PokemonTypeName.getKoreanTypeName(for: data.types.first?.type.name ?? "")
                    type = typeName
                }
                
                let name = PokemonTranslator.getKoreanName(for: data.name)
                
                DispatchQueue.main.async {
                    self.labelConfig(id: data.id,
                                     name: name,
                                     type: type,
                                     height: data.height / 10,
                                     weight: data.weight / 10)
                }
                
            }, onError: { error in
            
                
                
            }).disposed(by: self.disposeBag)
    }
}

extension UILabel {
    func lineSpacing(_ spacing: CGFloat) {
        guard let text = self.text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        style.alignment = .center
        attributeString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attributeString.length))
        
        self.attributedText = attributeString
    }
}
