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
    func showYellowViewCotoller()
}

final class LoginViewModel {
    private let disposeBag = DisposeBag()
    
    weak var controllable: LoginViewControllable?
    
    struct Input {
        let buttonDidTapped: Observable<Void>
        let button2DidTapped: Observable<Void>
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
        
        input.button2DidTapped
            .bind{
                self.controllable?.showYellowViewCotoller()
            }
            .disposed(by: disposeBag)
            
        
        return Output()
    }
}
