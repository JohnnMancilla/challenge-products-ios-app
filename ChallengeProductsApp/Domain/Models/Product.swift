//
//  Product.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import Foundation

struct Product: Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let imageURL: URL
    let rating: Double
    let ratingCount: Int
    let isFavorite: Bool
}
