//
//  NetworkType.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/09.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias Headers = [String: Any]

public enum ParameterEncoding {
    case URLEncoding
    case JSONEncoding
    
    func encode(_ urlRequest: URLRequest, with: Parameters) -> URLRequest {
        switch self {
        case .URLEncoding:
            return URLRequest(url:"")
        case .JSONEncoding:
            return URLRequest(url: "")
        }
    }
}

public protocol NetworkType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: Headers { get }
}

public enum Task {
    case requestPlain
    case requestParameters(parameters: Parameters, encoding: ParameterEncoding)
}


internal extension URLRequest {
    mutating func encoded(encodable: Encodable, encoder: JSONEncoder = JSONEncoder()) throws -> URLRequest {
        do {
            let encodable = AnyEncodable(encodable)
            httpBody = try encoder.encode(encodable)

            let contentTypeHeaderName = "Content-Type"
            if value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }

            return self
        } catch {
            throw dump(error)
        }
    }

    func encoded(parameters: [String: Any], parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw dump(error)
        }
    }
}
