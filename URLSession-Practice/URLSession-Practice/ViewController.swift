//
//  ViewController.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/06.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let repository = DefaultProductRepository()
        Task {
            let response = try await repository.getProducts()
            dump(response)
        }
    }

    func loadData() async throws -> Product {
        let url = URL(string: "http://apis.data.go.kr/B553748/CertImgListService/getCertImgListService?serviceKey=KJeZEeFZbu%2BlQy3OMv3FpnbLWrqM7mj8orXbKZQVAz%2FQe0ELaEIQnM%2BxY3NQY6k8%2BMi52M8Si%2B3Ys4bYV84o4w%3D%3D&returnType=json&numOfRows=100")!
        let session = URLSession.shared
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Product.self, from: data)
    }
}
