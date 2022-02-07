//
//  Product.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/07.
//

struct Product: Decodable {
    let totalCount, pageNo, resultCode: String
    let list: [List]
    let resultMessage, numOfRows: String
}

// MARK: - List
struct List: Decodable {
    let prdkindstate, manufacture, rnum, prdkind: String
    let rawmtrl, prdlstNm: String
    let imgurl2, imgurl1: String
    let productGB: String
    let prdlstReportNo, allergy: String
    let nutrient: String?
    let seller: String?
    let barcode: String?

    enum CodingKeys: String, CodingKey {
        case prdkindstate, manufacture, rnum, prdkind, rawmtrl, prdlstNm, imgurl2, imgurl1
        case productGB = "productGb"
        case prdlstReportNo, allergy, nutrient, seller, barcode
    }
}
