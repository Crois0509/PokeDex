//
//  PokemonDetailView.swift
//  PokeDex
//
//  Created by 장상경 on 12/28/24.
//

import UIKit
import SnapKit
import RxSwift

// 포켓몬 디테일 뷰
final class PokemonDetailView: UIView {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: DetailViewModel // 초기화시 주입
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()
    
    // MARK: - PokemonDetailView Initializer
    init(image: UIImage, model: DetailViewModel) {
        self.viewModel = model
        super.init(frame: .zero)
        
        setupUI()
        bind()
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PokemonDetailView UI Setting Method
private extension PokemonDetailView {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupImageView()
        setupNameLabel()
        setupInfoLabel()
        setupLayout()
    }
    
    /// UIView 설정
    func configure() {
        self.backgroundColor = .personalDark
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        [self.imageView,
         self.nameLabel,
         self.infoLabel].forEach { self.addSubview($0) }
    }
    
    /// 이미지뷰를 설정하는 메소드
    func setupImageView() {
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = .clear
        self.imageView.image = UIImage(systemName: "person") // 테스트
    }
    
    /// 이름 레이블을 설정하는 메소드
    func setupNameLabel() {
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.nameLabel.textAlignment = .center
        self.nameLabel.textColor = .white
        self.nameLabel.numberOfLines = 1
        self.nameLabel.backgroundColor = .clear
    }
    
    /// 정보 레이블을 설정하는 메소드
    func setupInfoLabel() {
        self.infoLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        self.infoLabel.textAlignment = .center
        self.infoLabel.textColor = .white
        self.infoLabel.numberOfLines = 3
        self.infoLabel.backgroundColor = .clear
    }
    
    /// 모든 UI의 레이아웃을 설정하는 메소드
    func setupLayout() {
        self.imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(250)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        self.infoLabel.snp.makeConstraints {
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    /// 레이블 값을 설정하는 메소드
    /// - Parameters:
    ///   - id: 포켓몬 도감 번호
    ///   - name: 포켓몬 이름
    ///   - type: 포켓몬의 타입
    ///   - height: 포켓몬의 키
    ///   - weight: 포켓몬의 무게
    func labelConfig(id: Int, name: String, type: String, height: Double, weight: Double) {
        self.nameLabel.text = "No.\(id) \(name)"
        self.infoLabel.text = "타입: \(type)\n키: \(height) m\n몸무게: \(weight) kg"
        self.infoLabel.lineSpacing(10)
    }
    
    /// 포켓몬의 타입 목록을 String 타입으로 변환하는 메소드
    /// - Parameter pokemonTypes: 포켓몬의 타입 목록
    /// - Returns: 포켓몬의 타입(String)
    func convertPokemonTypes(_ pokemonTypes: [PokemonTypes]) -> String {
        var result: String = ""
        
        if pokemonTypes.count > 1 {
            var types = [String](repeating: "", count: pokemonTypes.count)
            for type in pokemonTypes {
                let typeName = PokemonTypeName.getKoreanTypeName(for: type.type.name)
                
                types[type.slot - 1] = typeName
            }
            result = types.joined(separator: ", ")
            
        } else {
            let typeName = PokemonTypeName.getKoreanTypeName(for: pokemonTypes.first?.type.name ?? "")
            result = typeName
        }
        
        return result
    }
    
    /// 데이터 바인딩 메소드
    func bind() {
        self.viewModel.pokemonDetailData
            .observe(on: MainScheduler.instance)
            .compactMap { $0.first }
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
                
                let type = owner.convertPokemonTypes(data.types)
                
                let name = PokemonTranslator.getKoreanName(for: data.name)
                
                owner.labelConfig(id: data.id,
                                 name: name,
                                 type: type,
                                 height: data.height / 10,
                                 weight: data.weight / 10)
                
                
            }, onError: { error in
                print(error)
                
            }).disposed(by: self.disposeBag)
    }
}

// MARK: - UILabel Extension
extension UILabel {
    
    /// 텍스트의 줄 간격을 설정하는 메소드
    /// - Parameter spacing: 줄 간격 크기
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
