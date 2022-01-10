//
//  LoginCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

protocol LoginCoordinatorDependencies: AnyObject {
    func makeMainTabBarViewController(_ loginCoordinator: LoginCoordinator)
}

final class LoginCoordinator: BaseCoordinator {
    weak var dependencies: LoginCoordinatorDependencies?
    
    init(navigationController: UINavigationController, dependencies: LoginCoordinatorDependencies) {
        super.init(navigationController: navigationController)
        self.dependencies = dependencies
    }
    
    override func start() {
        let login = LoginViewController()
        login.title = "로그인"
        login.coordinator = self
        self.navigationController.pushViewController(login, animated: true)
    }
}

extension LoginCoordinator{
    func switchMainFlow() {
        dependencies?.makeMainTabBarViewController(self)
    }
}
