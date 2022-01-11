//
//  YellowCoordinator.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import Foundation

final class YellowCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = YellowViewModel()
        viewModel.controllable = parentCoordinator as? LoginViewControllable
        let yellow = YellowViewController(yellowViewModel: viewModel)
        yellow.title = "노랑"
        navigationController.pushViewController(yellow, animated: true)
    }
}
