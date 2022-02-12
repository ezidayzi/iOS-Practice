//
//  NetworkType.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/09.
//

import Foundation
import RxSwift

public typealias Parameters = [String: Any]
public typealias Headers = [String: String]

struct Results {
    let data: Data
    let response: URLResponse
    init(_ result: (Data, URLResponse)) {
        self.data = result.0
        self.response = result.1
    }
}

public protocol RouterType {
    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String? { get }
    var task: Task { get }
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

public enum Task {
    case plain
    case withParameters(parameters: Parameters, encoding: PrameterEncoding)
}


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
            components?.queryItems = parameters?.map ({ key, value -> URLQueryItem in
                URLQueryItem(name: key, value: value as? String)
            })
            
            urlRequest.url = components?.url
            return urlRequest
        }
    }
    
}

enum APIError: Error {
    case serverError
    case decodedError
    case encodedError
}

protocol RouterProviderType: AnyObject {
    associatedtype Router: RouterType
   
    func request(_ router: Router) async throws -> Results
}

open class RouterProvider<Router: RouterType>: RouterProviderType {
    func request(_ router: Router) async throws -> Results {
        let urlRequest = try await makeURLRequest(with: router)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse,
              (200..<500) ~= response.statusCode else {
                  throw APIError.serverError
              }
        
        return Results((data, response))
    }
    
    func decoded<T: Decodable>(with results: Results) async throws -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: results.data)
            return decodedData
        } catch {
            throw APIError.decodedError
        }
    }
}

private extension RouterProvider {
    private func makeURLRequest(with router: Router) async throws -> URLRequest {
        var urlRequest = URLRequest(url: router.url)
        urlRequest.httpMethod = router.method.rawValue
        urlRequest.allHTTPHeaderFields = router.headers ?? nil
        
        switch router.task {
        case .plain:
            break
        case let .withParameters(parameters, encoding):
            urlRequest = try encoding.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
