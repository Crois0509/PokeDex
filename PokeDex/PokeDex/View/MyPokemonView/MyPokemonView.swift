//
//  MyPokemonView.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import CoreData

// 내 포켓몬 뷰
final class MyPokemonView: UIView {
    
    private let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
    
    private let myPokemonTable = UITableView()
    
    private let infoLabel = UILabel()
    
    private var myPokemons: [(id: Int, name: String, obId: NSManagedObjectID)] = [] // 내 포켓몬 배열
    
    // MARK: - MyPokemonView Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    /// 내 포켓몬 목록을 다시 불러오는 메소드
    func reloadMyPokemons() {
        readMyPokemons()
    }
    
}

// MARK: - MyPokemonView UI Setting Method
private extension MyPokemonView {
    
    /// 모든 UI를 세팅하는 메소드
    func setupUI() {
        configure()
        setupTitleLabel()
        setupTableView()
        setupInfoLabel()
        setupLayout()
        readMyPokemons()
        selectCell()
    }
    
    /// self에 대해 설정하는 메소드
    func configure() {
        self.backgroundColor = .clear
        [self.titleLabel,
         self.myPokemonTable,
         self.infoLabel].forEach {
            self.addSubview($0)
        }
    }
    
    /// 타이틀 레이블을 세팅하는 메소드
    func setupTitleLabel() {
        self.titleLabel.text = "내 포켓몬"
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 50)
        self.titleLabel.textColor = .white
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textAlignment = .center
        self.titleLabel.backgroundColor = .clear
    }
    
    /// 테이블 뷰를 세팅하는 메소드
    func setupTableView() {
        self.myPokemonTable.dataSource = self
        self.myPokemonTable.backgroundColor = .clear
        self.myPokemonTable.rowHeight = 80
        self.myPokemonTable.separatorStyle = .none
        self.myPokemonTable.showsVerticalScrollIndicator = false
        self.myPokemonTable.showsHorizontalScrollIndicator = false
        self.myPokemonTable.isScrollEnabled = false
        self.myPokemonTable.register(MyPokemonCell.self, forCellReuseIdentifier: MyPokemonCell.id)
    }
    
    /// 정보 레이블을 세팅하는 메소드
    func setupInfoLabel() {
        self.infoLabel.text = "최대 6마리까지 등록 가능합니다"
        self.infoLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.infoLabel.textColor = .personalDark
        self.infoLabel.numberOfLines = 1
        self.infoLabel.textAlignment = .center
        self.infoLabel.backgroundColor = .clear
    }
    
    /// 모든 레이아웃을 세팅하는 메소드
    func setupLayout() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        self.myPokemonTable.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(10)
            $0.height.equalTo(500)
        }
        
        self.infoLabel.snp.makeConstraints {
            $0.top.equalTo(self.myPokemonTable.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    /// 내 포켓몬 정보를 불러오는 메소드
    func readMyPokemons() {
        let pokemons = CoreDataManager.coreDatashared.readAllData()
        var myPokemons: [(id: Int, name: String, obId: NSManagedObjectID)] = []
        pokemons.forEach {
            let id = Int($0.id)
            let name = $0.name ?? ""
            let obId = $0.objectID
            let item = (id, name, obId)
            myPokemons.append(item)
        }
        self.myPokemons = myPokemons
        self.myPokemonTable.reloadData()
    }
    
    /// 셀을 선택했을 때 액션을 설정하는 메소드
    func selectCell() {
        self.myPokemonTable.rx.itemSelected
            .withUnretained(self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, indexPath in
                                
                let pokemon = owner.myPokemons[indexPath.row]
                let id = pokemon.id
                let obID = pokemon.obId
                
                owner.presentDetailView(id: id, obID: obID)
                
            }).disposed(by: self.disposeBag)
    }
    
    /// 네비게이션을 통해 디테일뷰로 이동하는 메소드
    /// - Parameter id: 포켓몬의 ID
    func presentDetailView(id: Int, obID: NSManagedObjectID) {
        DispatchQueue.main.async {
            let detailView = PokemonDetailView(
                id: id,
                model: DetailViewModel(pokemonManager: PokemonManager(), id: id)
            )
            
            let detailVC = DetailViewController(detailView: detailView, obID)
            
            guard let view = self.window?.rootViewController as? UINavigationController else { return }
            view.pushViewController(detailVC, animated: true)
        }
    }
    
}

// MARK: - MyPokemonView UITableViewDataSource Method
extension MyPokemonView: UITableViewDataSource {
    
    // 테이블 뷰 셀 수 = 최대 6마리 제한임으로 항상 6으로 고정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // 셀을 설정하는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPokemonCell.id, for: indexPath) as? MyPokemonCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        if self.myPokemons.isEmpty || self.myPokemons.count - 1 < indexPath.row {
            cell.configCell(id: nil, name: nil)
        } else {
            let id = Int(self.myPokemons[indexPath.row].id)
            let name = PokemonTranslator.getKoreanName(for: self.myPokemons[indexPath.row].name)
            
            cell.configCell(id: id, name: name)
        }
        
        return cell
    }
    
}
