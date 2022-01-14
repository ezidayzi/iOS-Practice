//
//  RedViewController.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

import RxCocoa

final class RedViewController: UIViewController {
    
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
//        button.rx.tap
//            .subscribe { _ in
//                <#code#>
//            }

    }

    private func setUpButton() {
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 117).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}

