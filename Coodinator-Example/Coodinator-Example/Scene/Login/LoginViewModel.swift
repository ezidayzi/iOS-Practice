//
//  LoginViewModel.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import RxSwift
import RxCocoa

protocol LoginViewControllable: AnyObject {
    func performTransition(_ loginViewModel: LoginViewModel, to transition: LoginFlow)
}

final class LoginViewModel: BaseViewModel {
    
    weak var controllable: LoginViewControllable?
    
    struct Input {
        let buttonDidTapped: Signal<Void>
        let button2DidTapped: Signal<Void>
    }
    
    struct Output {
        
    }
    
    init(loginControllable: LoginViewControllable) {
        self.controllable = loginControllable
    }
    
    func transform(input: Input) -> Output {
        input.buttonDidTapped
            .debug("asdaasdf")
            .withUnretained(self)
            .emit{ owner, _ in
                owner.controllable?.performTransition(owner, to: .main)
            }
            .disposed(by: disposeBag)
        
        input.button2DidTapped
            .withUnretained(self)
            .emit{ owner, _ in
                owner.controllable?.performTransition(owner, to: .yellow)
            }
            .disposed(by: disposeBag)
            
        
        return Output()
    }
}
