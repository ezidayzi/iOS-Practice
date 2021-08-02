//
//  main.swift
//  Optional
//
//  Created by 김윤서 on 2021/08/02.
//

import Foundation


var value :Int! = 1;

switch value {
case .none:
    print("nil!");
case .some:
    print("not nil...");
    print(value + 1)
}

