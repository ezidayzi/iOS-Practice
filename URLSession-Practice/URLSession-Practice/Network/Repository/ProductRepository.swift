//
//  ProductRepository.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/13.
//

import Foundation

protocol ProductRepository {
    func getProducts() async throws -> Product?
}
