//
//  ProductDTO.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

struct ProductDTO: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String?
    let category: String?
    let image: String?
    let rating: RatingDTO?

    struct RatingDTO: Decodable {
        let rate: Double?
        let count: Int?
    }
}
