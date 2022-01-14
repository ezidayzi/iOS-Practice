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
}

final class YellowViewModel {
    private let disposeBag = DisposeBag()
    
    weak var controllable: YellowViewControllable?
    
    struct Input {
        let buttonDidTapped: Signal<Void>
        let button2DidTapped: Signal<Void>
        let button3DidTapped: Signal<Void>
    }
    
    struct Output {
        
    }
    
    init(yellowControllable: YellowViewControllable) {
        self.controllable = yellowControllable
    }
    
    func transform(input: Input) -> Output {
        input.buttonDidTapped
            .withUnretained(self)
            .emit{ owner, _ in
                owner.controllable?.performTransition(owner, to: .main)
            }
            .disposed(by: disposeBag)
        
        input.button2DidTapped
            .withUnretained(self)
            .emit{ owner, _ in
                owner.controllable?.performTransition(owner, to: .red)
            }
            .disposed(by: disposeBag)
        
        input.button3DidTapped
            .withUnretained(self)
            .emit{ owner, _ in
                owner.controllable?.performTransition(owner, to: .yellow)
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
