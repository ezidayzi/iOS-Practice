//
//  RedCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

final class RedCoordinator: BaseCoordinator {
    override func start() {
        let red = RedViewController()
        red.title = "빨강이"
        navigationController.present(red, animated: true, completion: nil)
    }
}