//
//  BaseViewModel.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/30.
//

import RxCocoa
import RxSwift
import UIKit

public class BaseViewModel: BaseViewBindable {
    public let viewDidLoad = PublishRelay<Void>()
    public let viewWillAppear = PublishRelay<Void>()
    public let viewDidAppear = PublishRelay<Void>()
    public let viewDidDisappear = PublishRelay<Void>()
    public let viewWillDisappear = PublishRelay<Void>()
    public let finish = PublishRelay<Void>()
    public var disposeBag = DisposeBag()
}
