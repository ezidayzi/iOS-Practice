//
//  RedViewController.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

import RxCocoa
import RxSwift

protocol RedViewControllable: AnyObject {
    func performTransition(_ redViewController: RedViewController, to transition: RedFlow)
}

final class RedViewController: UIViewController {
    weak var redViewControllable: RedViewControllable?
    
    let disposeBag = DisposeBag()
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("dismiss", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let button2: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("push", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpButton()
        
        button.rx.tap.bind{
            self.redViewControllable?.performTransition(self, to: .dismiss)
        }.disposed(by: disposeBag)
            
        button2.rx.tap.bind{
            self.redViewControllable?.performTransition(self, to: .push)
        }.disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.navigationController?.isBeingDismissed ?? false {
            print("Red: navigationController isBeingDismissed")
        }
        
        if self.navigationController?.isMovingFromParent ?? false {
            print("Red: navigationController isMovingFromParent")
        }
        
        if isBeingDismissed {
            print("isBeingDismissed")
        }
        
        if isMovingFromParent {
            print("isMovingFromParent")
        }
    }
    
    private func setUpButton() {
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 117).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(button2)
        button2.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -30).isActive = true
        button2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 117).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }

}

