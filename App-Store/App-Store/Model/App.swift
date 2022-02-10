//
//  App.swift
//  App-Store
//
//  Created by 김윤서 on 2022/02/10.
//

struct App: Decodable, Hashable {
    let id: Int
    let tagline: String
    let name: String
    let subheading: String
    let image: String
    let iap: Bool
}
