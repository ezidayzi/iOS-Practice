//
//  RedCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

enum RedFlow {
    case dismiss
}

protocol RedCoordinatorDependencies: AnyObject {
    func performTransition(_ yellowCoordinator: RedCoordinator, to transition: RedFlow)
}

final class RedCoordinator: BaseCoordinator {
    weak var dependencies: RedCoordinatorDependencies?
    
    override func start() {
        let red = RedViewController()
        red.redViewControllable = self
        red.title = "빨강"
        red.modalPresentationStyle = .fullScreen
        navigationController.present(red, animated: true, completion: nil)
    }
    
    deinit {
        print(childCoordinators)
    }
}

extension RedCoordinator: RedViewControllable {
    func performTransition(_ redViewController: RedViewController, to transition: RedFlow) {
        dependencies?.performTransition(self, to: .dismiss)
    }
}
