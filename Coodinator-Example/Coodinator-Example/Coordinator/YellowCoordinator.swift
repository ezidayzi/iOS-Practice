//
//  YellowCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import Foundation

enum YellowFlow {
    case main
    case red
    case yellow
}

protocol YellowCoordinatorDependencies: AnyObject {
    func performTransition(_ yellowCoordinator: YellowCoordinator, to transition: YellowFlow)
}

final class YellowCoordinator: BaseCoordinator {
    weak var dependencies: YellowCoordinatorDependencies?
    
    override func start() {
        let viewModel = YellowViewModel(yellowControllable: self)
        let yellow = YellowViewController(yellowViewModel: viewModel)
        yellow.title = "노랑"
        navigationController.pushViewController(yellow, animated: true)
    }
    
    deinit {
        print(childCoordinators)
    }
    
}

extension YellowCoordinator: YellowViewControllable {
    func performTransition(_ yellowViewModel: YellowViewModel, to transition: YellowFlow) {
        dependencies?.performTransition(self, to: transition)
    }
}
