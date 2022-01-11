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
    
    weak var controllable: YellowViewControllable?
    
    struct Input {
        let buttonDidTapped: Observable<Void>
        let button2DidTapped: Observable<Void>
    }
    
    struct Output {
        
    }
    
    init(yellowControllable: YellowViewControllable) {
        self.controllable = yellowControllable
    }
    
    func transform(input: Input) -> Output {
        input.buttonDidTapped
            .bind{
                self.controllable?.showMainViewController()
            }
            .disposed(by: disposeBag)
        
        input.button2DidTapped
            .bind{
//                self.controllable?.showYellowViewCotoller()
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
