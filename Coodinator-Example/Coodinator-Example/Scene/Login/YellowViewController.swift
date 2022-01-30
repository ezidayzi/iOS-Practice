//
//  YellowViewController.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

import RxCocoa
import RxSwift

final class YellowViewController: BaseViewController<YellowViewModel> {
    
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
        btn.setTitle("빨강으로 이동", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let button3: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("pop", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setUpButton()
    }

    override func bind(viewModel: YellowViewModel) {
        super.bind(viewModel: viewModel)
        button.rx.tap
            .map { _ in }
            .bind(to: viewModel.buttonDidTapped)
            .disposed(by: disposeBag)
        
        button2.rx.tap
            .map { _ in }
            .bind(to: viewModel.button2DidTapped)
            .disposed(by: disposeBag)
        
        button3.rx.tap
            .map { _ in }
            .bind(to: viewModel.button3DidTapped)
            .disposed(by: disposeBag)
    
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
        
        view.addSubview(button3)
        button3.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 30).isActive = true
        button3.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        button3.widthAnchor.constraint(equalToConstant: 117).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
