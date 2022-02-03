//
//  RedCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import UIKit

enum RedFlow {
    case dismiss
    case push
}

protocol RedCoordinatorDependencies: AnyObject {
    func performTransition(_ yellowCoordinator: RedCoordinator, to transition: RedFlow)
}

final class RedCoordinator: BaseCoordinator {
    weak var dependencies: RedCoordinatorDependencies?
    
    let nav = UINavigationController()
    
    override func start() {
        let red = RedViewController()
        red.redViewControllable = self
        red.title = "빨강"
        nav.setViewControllers([red], animated: true)
        nav.modalPresentationStyle = .fullScreen
        navigationController.present(nav, animated: true, completion: nil)
    }
    
    deinit {
        print(childCoordinators)
    }
}

extension RedCoordinator: RedViewControllable {
    func performTransition(_ redViewController: RedViewController, to transition: RedFlow) {
        switch transition {
        case .dismiss:
            dependencies?.performTransition(self, to: .dismiss)
        case .push:
            let blue = BlueViewController()
            blue.controllable = self
            nav.pushViewController(blue, animated: true)
        }
       
    }
}

extension RedCoordinator: BlueViewControllable {
    func performTransition(_ redViewController: BlueViewController, to transition: RedFlow) {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
