//
//  LoginViewModel.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import RxSwift
import RxCocoa

protocol LoginViewControllable: AnyObject {
    func showMainViewController()
}

final class LoginViewModel {
    let disposeBag = DisposeBag()
    
    weak var controllable: LoginViewControllable?
    
    struct Input {
        let buttonDidTapped: Observable<Void>
    }
    
    struct Output {
        
    }
    
    init(loginControllable: LoginViewControllable) {
        self.controllable = loginControllable
    }
    
    func transform(input: Input) -> Output {
        input.buttonDidTapped
            .bind{
                self.controllable?.showMainViewController()
            }
            .disposed(by: disposeBag)
            
        
        return Output()
    }
}
