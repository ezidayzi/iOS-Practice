//
//  Results.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/13.
//

import Foundation

struct Results {
    let data: Data
    let response: URLResponse
    init(_ result: (Data, URLResponse)) {
        self.data = result.0
        self.response = result.1
    }
}
