//
//  LoginCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

import RxCocoa
import RxSwift

enum LoginFlow {
    case main
    case yellow
}

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
    
    deinit {
        print(childCoordinators)
    }
}

extension LoginCoordinator: LoginViewControllable {
    func performTransition(_ loginViewModel: LoginViewModel, to transition: LoginFlow) {
        switch transition {
        case .main:
            dependencies?.makeMainTabBarViewController(self)
        case .yellow:
            let yellow = YellowCoordinator(navigationController: navigationController)
            yellow.start()
            yellow.dependencies = self
            addChildCoordinator(yellow)
        }
    }
}

extension LoginCoordinator: YellowCoordinatorDependencies {
    func performTransition(_ yellowCoordinator: YellowCoordinator, to transition: YellowFlow) {
        switch transition {
        case .main:
            dependencies?.makeMainTabBarViewController(self)
        case .yellow:
            removeChildCoordinator(yellowCoordinator)
            navigationController.popViewController(animated: true)
        case .red:
            let red = RedCoordinator(navigationController: navigationController)
            red.dependencies = self
            red.start()
            addChildCoordinator(red)
        }
    }
}

extension LoginCoordinator: RedCoordinatorDependencies {
    func performTransition(_ yellowCoordinator: RedCoordinator, to transition: RedFlow) {
        switch transition {
        case .dismiss:
            navigationController.dismiss(animated: true, completion: nil)
            removeChildCoordinator(yellowCoordinator)
        }
    }
}
