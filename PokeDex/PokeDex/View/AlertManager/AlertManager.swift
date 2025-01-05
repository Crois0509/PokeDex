//
//  AlertManager.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit

final class AlertManager {
    static let alert = AlertManager()
    private init() {}
    
    func showActionSheet(on viewController: UIViewController, message: String, _ completion: (() -> Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        viewController.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true)
            completion?()
        }
    }
    
    func showAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    func confirmThrowPokemon(on viewController: UIViewController, _ completion: (() -> Void)?) {
        let alert = UIAlertController(title: "경고", message: "정말 포켓몬을\n놓아주시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "아니요", style: .cancel))
        alert.addAction(UIAlertAction(title: "네", style: .destructive, handler: { _ in
            completion?()
        }))
        viewController.present(alert, animated: true)
    }
}
