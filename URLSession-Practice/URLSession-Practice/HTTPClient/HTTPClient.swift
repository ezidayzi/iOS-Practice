//
//  HTTPClient.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/07.
//

import Foundation

import RxSwift


public enum HTTPMethod: String {
    case GET = "GET"
    case DELETE = "DELETE"
    case POST = "POST"
    case PUT = "PUT"
}

//protocol HTTPClientService {
//    func request(
//        _ url: URL,
//        method: HTTPMethod,
//        parameters: Parameters?,
//        encoding: ParameterEncoding,
//        headers: Headers?
//    ) -> Observable<JSON>
//}
//
//protocol StatusHandler {
//    var statusCase: StatusCase? { get }
//}
//
//enum StatusCase: Int {
//    case okay = 200
//    case created = 201
//    case noContent = 204
//    case resetContent = 205
//    case notModified = 304
//    case badRequest = 400
//    case unAuthorized = 401
//    case forbidden = 403
//    case notFound = 404
//    case internalServerError = 500
//    case serviceUnavailable = 503
//}
//
//typealias JSON = String
//
//final class HTTPClient: HTTPClientService {
//    static let shared = HTTPClient()
//
//    private init() {}
//
//    func request(
//        _ url: URL,
//        method: HTTPMethod,
//        parameters: Parameters?,
//        encoding: ParameterEncoding,
//        headers: Headers?
//    ) -> Observable<JSON> {
//        return Observable.create() { emitter in
//
//            var request: URLRequest = URLRequest(url: url)
//            request.httpMethod = method.rawValue
//
//            if headers != nil {
//                request.addValue("application/json", forHTTPHeaderField: "Accept")
//                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            }
//
//            let task = URLSession.shared.dataTask(with: request) { data, response, err in
//                guard err == nil else {
//                    emitter.onError(err!)
//                    return
//                }
//
//                if let data = data, let json = String(data: data, encoding: .utf8) {
//                    emitter.onNext(json)
//                }
//
//                emitter.onCompleted()
//            }
//            task.resume()
//
//            return Disposables.create() {
//                task.cancel()
//            }
//
//        }
//    }
//}
//
//extension Dictionary {
//    var queryString: String {
//        var output: String = ""
//        forEach({ output += "\($0.key)=\($0.value)&" })
//        output = String(output.dropLast())
//        return output
//    }
//}
