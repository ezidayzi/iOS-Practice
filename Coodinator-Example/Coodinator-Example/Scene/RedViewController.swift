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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpButton()
        
        button.rx.tap.bind{
            self.redViewControllable?.performTransition(self, to: .dismiss)
        }.disposed(by: disposeBag)
            

    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        if isBeingDismissed || isMovingFromParent {
            print("사라짐 \(self.description)")
        }
        
    }

    private func setUpButton() {
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 117).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}

