//
//  BaseViewBindable.swift
//  Coodinator-Example
//
//  Created by 김윤서 on 2022/01/30.
//

import RxCocoa
import RxSwift
import UIKit

public protocol BaseViewBindable {
    var viewDidLoad: PublishRelay<Void> { get }
    var viewWillAppear: PublishRelay<Void> { get }
    var viewDidAppear: PublishRelay<Void> { get }
    var viewWillDisappear: PublishRelay<Void> { get }
    var viewDidDisappear: PublishRelay<Void> { get }
    var disposeBag: DisposeBag { get }
    var finish: PublishRelay<Void> {get}
}

