//
//  APIError.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/13.
//

import Foundation

enum APIError: Error {
    case serverError
    case decodedError
    case encodedError
}
