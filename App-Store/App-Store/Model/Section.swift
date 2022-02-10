//
//  Section.swift
//  App-Store
//
//  Created by 김윤서 on 2022/02/10.
//

struct Section: Decodable, Hashable {
    let id: Int
    let type: String
    let title: String
    let subtitle: String
    let items: [App]
}
