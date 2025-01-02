//
//  PokemonCell.swift
//  PokeDex
//
//  Created by 장상경 on 12/27/24.
//

import UIKit
import SnapKit
import Kingfisher

// 메인뷰의 컬렉션뷰 커스텀 셀
final class PokemonCell: UICollectionViewCell {
    static let id: String = "PokemonCell"
    
    private let imageView = UIImageView()
    
    // MARK: - PokemonCell Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    // 셀 재사용 옵션 설정
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
    
    func addImage(_ id: Int) {
        guard let url = URL(string: APIEndpoint.pokemonImageURL(id: id).urlString) else { return }
        self.imageView.kf.setImage(with: url)
    }
}
 
// MARK: - PokemonCell UI Setting Method
private extension PokemonCell {
    
    /// 모든 UI를 세팅하는 메소드
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        self.addSubview(self.imageView)
        setupImageView()
    }
    
    /// 이미지뷰를 세팅하는 메소드
    private func setupImageView() {
        self.imageView.backgroundColor = .clear
        self.imageView.contentMode = .scaleAspectFit
        
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    

}
