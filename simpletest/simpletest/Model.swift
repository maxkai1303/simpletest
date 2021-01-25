//
//  Model.swift
//  simpletest
//
//  Created by Max Kai on 2021/1/21.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let shopCategoryList: ShopCategoryList?
    let shopCategory: ShopCategory?
}

// MARK: - ShopCategoryList
struct ShopCategoryList: Codable {
    let count: Int
    let categoryList: [CategoryList]
}

// MARK: - CategoryList
struct CategoryList: Codable {
    let id: Int
    let name: String
}

// MARK: - ShopCategory
struct ShopCategory: Codable {
    let salePageList: ShopCategorySalePageList
}

// MARK: - ShopCategorySalePageList
struct ShopCategorySalePageList: Codable {
    let salePageList: [SalePageListElement]
}

// MARK: - SalePageListElement
struct SalePageListElement: Codable {
    let salePageID, sellingQty: Int?
    let title: String?
    let price, suggestPrice: Int?
    let isSoldOut, isComingSoon: Bool?
    let sellingStartDateTime: Int?

    enum CodingKeys: String, CodingKey {
        case salePageID = "salePageId"
        case title, price, suggestPrice
        case sellingQty, isSoldOut, isComingSoon, sellingStartDateTime
    }
}
