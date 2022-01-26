//
//  YellowViewController.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

import RxCocoa
import RxSwift

final class YellowViewController: UIViewController {
    
    private let viewModel: YellowViewModel
    
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
    
    required init(yellowViewModel: YellowViewModel) {
        self.viewModel = yellowViewModel
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setUpButton()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("dismiss")
    }
    
    private func bind() {
        let input = YellowViewModel.Input(
            buttonDidTapped: button.rx.tap.asSignal(),
            button2DidTapped: button2.rx.tap.asSignal(),
            button3DidTapped: button3.rx.tap.asSignal()
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
        
        view.addSubview(button3)
        button3.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 30).isActive = true
        button3.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        button3.widthAnchor.constraint(equalToConstant: 117).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
