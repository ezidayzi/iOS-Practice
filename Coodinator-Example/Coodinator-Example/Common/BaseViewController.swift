//
//  BaseViewController.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/30.
//

import RxCocoa
import RxSwift
import UIKit

public class BaseViewController<VM: BaseViewBindable>: UIViewController {

    var disposeBag = DisposeBag()
    var viewModel: VM?

    public init(viewModel: VM) {
        super.init(nibName: nil, bundle: nil)
        bind(viewModel: viewModel)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(viewModel: VM) {
        self.viewModel = viewModel

        rx.viewDidLoad
            .map { _ in () }
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)

        rx.viewWillAppear
            .map { _ in () }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)

        rx.viewDidAppear
            .map { _ in () }
            .bind(to: viewModel.viewDidAppear)
            .disposed(by: disposeBag)

        rx.viewWillDisappear
            .map { _ in () }
            .bind(to: viewModel.viewWillDisappear)
            .disposed(by: disposeBag)

        rx.viewDidDisappear
            .map { _ in () }
            .bind(to: viewModel.viewDidDisappear)
            .disposed(by: disposeBag)
        
        rx.didFinish
            .map { _ in (print("dkdkdk")) }
            .bind(to: viewModel.finish)
            .disposed(by: disposeBag)
    }
}
