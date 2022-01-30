//
//  AppCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

public enum AppFlow {
    case login
    case main
}

final class AppCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    let window: UIWindow
    let flow: AppFlow

    init(window: UIWindow) {
        navigationController = UINavigationController()
        self.window = window
        self.window.backgroundColor = .white
        self.window.rootViewController = navigationController
        childCoordinators = []
        flow = .login
    }
    
    func start() {
        switch flow {
        case .login:
            let loginCoordinator = LoginCoordinator(navigationController: self.navigationController, dependencies: self)
            loginCoordinator.start()
            loginCoordinator.finishDelegate = self
            addChildCoordinator(loginCoordinator)
        case .main:
            let mainCoordinator = MainCoordinator(navigationController: self.navigationController)
            mainCoordinator.start()
            mainCoordinator.finishDelegate = self
            addChildCoordinator(mainCoordinator)
        }
        window.makeKeyAndVisible()
    }
    
    deinit {
        print(childCoordinators)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        print(childCoordinators)
        removeChildCoordinator(childCoordinator)
        print(childCoordinators)
    }
}

extension AppCoordinator: LoginCoordinatorDependencies {
    func makeMainTabBarViewController(_ loginCoordinator: LoginCoordinator) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        removeChildCoordinator(loginCoordinator)
        let mainCoordinator = MainCoordinator(navigationController: self.navigationController)
        mainCoordinator.start()
        addChildCoordinator(mainCoordinator)
        window.makeKeyAndVisible()
    }
}
