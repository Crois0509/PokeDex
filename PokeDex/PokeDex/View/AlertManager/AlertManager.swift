//
//  AlertManager.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit

// 알럿을 모두 관리하는 객체
final class AlertManager {
    static let alert = AlertManager() // 싱글톤 패턴
    private init() {}
    
    /// 액션시트 형태의 알럿을 호출하는 메소드
    /// - Parameters:
    ///   - viewController: 알럿이 표시될 뷰 컨트롤러
    ///   - message: 알럿에 표시할 메세지
    ///   - completion: 알럿이 종료된 후 실행할 액션
    func showActionSheet(on viewController: UIViewController, message: String, _ completion: (() -> Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        viewController.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true)
            completion?()
        }
    }
    
    /// 알럿을 호출하는 메소드
    /// - Parameters:
    ///   - viewController: 알럿이 표시될 뷰 컨트롤러
    ///   - title: 알럿 타이틀
    ///   - message: 알럿 메세지
    func showAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    /// 포켓몬을 놓아줄 때 표시할 알럿
    /// - Parameters:
    ///   - viewController: 알럿이 표시될 뷰 컨트롤러
    ///   - completion: destructive 타입의 액션을 선택했을 때 실행될 액션
    func confirmThrowPokemon(on viewController: UIViewController, _ completion: (() -> Void)?) {
        let alert = UIAlertController(title: "경고", message: "정말 포켓몬을\n놓아주시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "아니요", style: .cancel))
        alert.addAction(UIAlertAction(title: "네", style: .destructive, handler: { _ in
            completion?()
        }))
        viewController.present(alert, animated: true)
    }
}
