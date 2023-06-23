//
//  ProductModel.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import Foundation

struct Products: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category, thumbnail: String
    let images: [String]
}

struct CartItem: Codable, Identifiable {
    let product: Product
    let amount: Int
    var id: Int { product.id }
}
