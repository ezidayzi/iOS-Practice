//
//  RouterType.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/13.
//

import Foundation

public typealias Headers = [String: String]

public protocol RouterType {
    var method: Method { get }
    var baseURL: URL { get }
    var path: String? { get }
    var work: Work { get }
    var headers: Headers? { get }
}

extension RouterType {
    var url: URL {
        guard let path = path else {
            return baseURL
        }
        return URL(string: path, relativeTo: baseURL)!
    }
}
