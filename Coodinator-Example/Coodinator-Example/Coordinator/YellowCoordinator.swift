//
//  YellowCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import Foundation

protocol YellowCoordinatorDependencies: AnyObject {
    func makeMainTabBarViewController(_ yellowCoordinator: YellowCoordinator)
}

final class YellowCoordinator: BaseCoordinator {
    weak var dependencies: YellowCoordinatorDependencies?
    
    override func start() {
        let viewModel = YellowViewModel(yellowControllable: self)
        let yellow = YellowViewController(yellowViewModel: viewModel)
        yellow.title = "노랑"
        navigationController.pushViewController(yellow, animated: true)
    }
}

extension YellowCoordinator: YellowViewControllable {
    func showRedViewController() {
        
    }
    
    func showMainViewController() {
        dependencies?.makeMainTabBarViewController(self)
    }
}
