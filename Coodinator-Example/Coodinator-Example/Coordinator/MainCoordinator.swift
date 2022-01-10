//
//  MainCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    override func start() {
        let tabBar = TabBarController()
        tabBar.title = "메인탭바"
        navigationController.pushViewController(tabBar, animated: true)
    }
}
