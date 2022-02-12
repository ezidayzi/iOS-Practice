//
//  ProductRepository.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/12.
//

import Foundation

protocol ProductRepository {
    func getProducts() async throws -> Product?
}

final class DefaultProductRepository: ProductRepository {
    private let router = RouterProvider<ProductRouter>()
    
    func getProducts() async throws -> Product? {
        let result = try await router.request(.getProducts)
        let decodedData = try await router.decoded(with: result) as Product?
        return decodedData
    }
}
