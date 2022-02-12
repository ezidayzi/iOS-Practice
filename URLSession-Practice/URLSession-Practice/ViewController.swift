//
//  ViewController.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/06.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let repository = DefaultProductRepository()
        Task {
            let response = try await repository.getProducts()
            dump(response)
        }
    }
}
