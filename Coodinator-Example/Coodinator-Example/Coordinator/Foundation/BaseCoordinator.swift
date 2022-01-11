//
//  BaseCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
   

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    init(
        navigationController: UINavigationController,
        coordinator: Coordinator
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = coordinator
    }

    func start() {
        fatalError("Start method must be implemented")
    }
}
