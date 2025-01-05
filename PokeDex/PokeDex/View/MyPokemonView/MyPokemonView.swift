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

final class MyPokemonView: UIView {
    
    private let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
    
    private let myPokemonTable = UITableView()
    
    private let infoLabel = UILabel()
    
    private var myPokemons: [(id: Int, name: String, obId: NSManagedObjectID)] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func reloadMyPokemons() {
        readMyPokemons()
        
    }
    
}

private extension MyPokemonView {
    
    func setupUI() {
        configure()
        setupTitleLabel()
        setupTableView()
        setupInfoLabel()
        setupLayout()
        readMyPokemons()
        selectCell()
    }
    
    func configure() {
        self.backgroundColor = .clear
        [self.titleLabel,
         self.myPokemonTable,
         self.infoLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setupTitleLabel() {
        self.titleLabel.text = "내 포켓몬"
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 50)
        self.titleLabel.textColor = .white
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textAlignment = .center
        self.titleLabel.backgroundColor = .clear
    }
    
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
    
    func setupInfoLabel() {
        self.infoLabel.text = "최대 6마리까지 등록 가능합니다"
        self.infoLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.infoLabel.textColor = .personalDark
        self.infoLabel.numberOfLines = 1
        self.infoLabel.textAlignment = .center
        self.infoLabel.backgroundColor = .clear
    }
    
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

extension MyPokemonView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
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
