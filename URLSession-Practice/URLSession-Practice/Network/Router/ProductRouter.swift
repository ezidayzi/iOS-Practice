//
//  ProductRouter.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/12.
//

import Foundation

enum ProductRouter{
    case getProducts
}

extension ProductRouter: RouterType {
    var baseURL: URL {
        switch self {
        case .getProducts:
            return URL(string: "http://apis.data.go.kr/B553748/CertImgListService/getCertImgListService")!
        }
    }
    
    var path: String? {
        switch self {
        case .getProducts:
            return  nil
        }
    }
    
    var method: Method {
        switch self {
        case .getProducts:
            return .GET
        }
    }
    
    var work: Work {
        switch self {
        case .getProducts:
            return .withParameters(parameters: [
                "serviceKey":"KJeZEeFZbu%2BlQy3OMv3FpnbLWrqM7mj8orXbKZQVAz%2FQe0ELaEIQnM%2BxY3NQY6k8%2BMi52M8Si%2B3Ys4bYV84o4w%3D%3D",
                "returnType": "json",
                "numOfRows": "10"
            ], encoding: URLEncoding.queryString)
        }
    }

    var headers: Headers? {
        return nil
    }
    
}
