//
//  YellowViewModel.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import RxSwift
import RxCocoa

protocol YellowViewControllable: AnyObject {
    func showMainViewController()
    func showRedViewController()
}

final class YellowViewModel {
    private let disposeBag = DisposeBag()
    
    weak var controllable: LoginViewControllable?
    
    struct Input {
        let buttonDidTapped: Observable<Void>
        let button2DidTapped: Observable<Void>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        input.buttonDidTapped
            .bind{
                self.controllable?.showMainViewController()
            }
            .disposed(by: disposeBag)
        
        input.button2DidTapped
            .bind{
                self.controllable?.showRedViewController()
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
