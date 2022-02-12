//
//  RouterProvider.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/13.
//

import Foundation

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
        
        switch router.work {
        case .plain:
            break
        case let .withParameters(parameters, encoding):
            urlRequest = try encoding.encode(urlRequest, with: parameters)
        }
        
        dump(urlRequest)
        return urlRequest
    }
}
