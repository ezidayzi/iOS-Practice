//
//  LoginViewController.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

import RxCocoa
import RxSwift


final class LoginViewController: BaseViewController<LoginViewModel> {
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("메인으로 이동", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let button2: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("노랑으로 이동", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
    }
    
    override func bind(viewModel: LoginViewModel) {
        super.bind(viewModel: viewModel)
        let input = LoginViewModel.Input(
            buttonDidTapped: button.rx.controlEvent(.touchUpInside).asSignal(),
            button2DidTapped: button2.rx.controlEvent(.touchUpInside).asSignal()
        )
        
        _ = viewModel.transform(input: input)
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
