//
//  YellowViewModel.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/11.
//

import RxSwift
import RxCocoa

protocol YellowViewControllable: AnyObject {
    func performTransition(_ yellowViewModel: YellowViewModel, to transition: YellowFlow)
    
    func finish()
}

final class YellowViewModel: BaseViewModel {
    
    weak var controllable: YellowViewControllable?
    
    let buttonDidTapped: PublishRelay<Void> = PublishRelay<Void>()
    let button2DidTapped: PublishRelay<Void> = PublishRelay<Void>()
    let button3DidTapped: PublishRelay<Void> = PublishRelay<Void>()
 
    init(yellowControllable: YellowViewControllable) {
        super.init()
        self.controllable = yellowControllable
        
        finish
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.controllable?.finish()
            }
            .disposed(by: disposeBag)
        
        buttonDidTapped
            .subscribe{[weak self] _ in
                guard let owner = self else { return }
                owner.controllable?.performTransition(owner, to: .main)
            }
            .disposed(by: disposeBag)
        
        button2DidTapped
            .withUnretained(self)
            .subscribe{ owner, _ in
                owner.controllable?.performTransition(owner, to: .red)
            }
            .disposed(by: disposeBag)
        
        button3DidTapped
            .withUnretained(self)
            .subscribe{ owner, _ in
                owner.controllable?.performTransition(owner, to: .yellow)
            }
            .disposed(by: disposeBag)
    }
}
