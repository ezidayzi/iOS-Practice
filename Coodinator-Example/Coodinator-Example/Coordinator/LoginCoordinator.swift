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
        let viewModel = LoginViewModel(loginControllable: self)
        
        let login = LoginViewController(loginViewModel: viewModel)
        login.title = "로그인"
        
        self.navigationController.pushViewController(login, animated: true)
    }
}

extension LoginCoordinator: LoginViewControllable {
    func showMainViewController() {
        dependencies?.makeMainTabBarViewController(self)
    }
    
    func showYellowViewCotoller() {
        let yellow = YellowCoordinator(navigationController: navigationController)
        yellow.start()
        yellow.dependencies = self
        addChildCoordinator(yellow)
    }
}

extension LoginCoordinator: YellowCoordinatorDependencies {
    func showRedViewController(_ yellowCoordinator: YellowCoordinator) {
        let red = RedCoordinator(navigationController: navigationController)
        red.start()
        addChildCoordinator(red)
    }
    
    func makeMainTabBarViewController(_ yellowCoordinator: YellowCoordinator) {
        dependencies?.makeMainTabBarViewController(self)
    }
}
