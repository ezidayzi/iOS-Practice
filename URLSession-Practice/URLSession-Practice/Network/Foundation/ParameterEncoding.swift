//
//  ParameterEncoding.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/13.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol PrameterEncoding {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
}

public enum URLEncoding: PrameterEncoding {
    case queryString
    
    public func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        switch self {
        case .queryString:
            var urlRequest = urlRequest
            guard let url = urlRequest.url else {
                throw APIError.encodedError
            }
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.percentEncodedQueryItems = parameters?.map ({ key, value -> URLQueryItem in
                URLQueryItem(name: key, value: value as? String)
            })
            
            urlRequest.url = components?.url
            return urlRequest
        }
    }
    
}
