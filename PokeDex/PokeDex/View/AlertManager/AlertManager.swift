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
    
    func showActionSheet(on viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        viewController.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true)
        }
    }
    
    func showAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        viewController.present(alert, animated: true)
    }
}
