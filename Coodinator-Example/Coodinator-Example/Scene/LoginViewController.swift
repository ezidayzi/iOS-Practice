//
//  LoginViewController.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

import RxCocoa
import RxSwift


final class LoginViewController: UIViewController {
   
    private let viewModel: LoginViewModel
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("메인으로 이동", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    required init(loginViewModel: LoginViewModel) {
        self.viewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
    }
    
    private func bind() {
        let input = LoginViewModel.Input(
            buttonDidTapped: button.rx.controlEvent(.touchUpInside).asObservable()
        )
        
        _ = viewModel.transform(input: input)
    }
    
    private func setUpButton() {
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 117).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
