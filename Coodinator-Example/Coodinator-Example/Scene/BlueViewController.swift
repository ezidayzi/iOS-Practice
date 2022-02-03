//
//  BlueViewController.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

import RxCocoa
import RxSwift

protocol BlueViewControllable: AnyObject {
    func performTransition(_ redViewController: BlueViewController, to transition: RedFlow)
}

final class BlueViewController: UIViewController {
    weak var controllable: BlueViewControllable?
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
        view.backgroundColor = .blue
        
        setUpButton()
        
        button.rx.tap.bind{
            self.controllable?.performTransition(self, to: .dismiss)
        }.disposed(by: disposeBag)
            
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.navigationController?.isBeingDismissed ?? false {
            print("Blue: navigationController isBeingDismissed")
        }
        
        if self.navigationController?.isMovingFromParent ?? false {
            print("Blue:  navigationController isMovingFromParent")
        }
        
        if isBeingDismissed {
            print("Blue:  isBeingDismissed")
        }
        
        if isMovingFromParent {
            print("Blue: isMovingFromParent")
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

