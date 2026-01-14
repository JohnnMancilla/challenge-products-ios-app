//
//  ProductEntity+Mapping.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import Foundation

extension ProductEntity {

    func toDomain() -> Product {
        Product(
            id: Int(id),
            title: title ?? "",
            price: price,
            description: productDescription ?? "",
            category: category ?? "",
            imageURL: URL(string: imageURL ?? "")!,
            rating: rating,
            ratingCount: Int(ratingCount),
            isFavorite: isFavorite
        )
    }

    func update(from product: Product) {
        id = Int64(product.id)
        title = product.title
        price = product.price
        productDescription = product.description
        category = product.category
        imageURL = product.imageURL.absoluteString
        rating = product.rating
        ratingCount = Int64(product.ratingCount)
        isFavorite = product.isFavorite
    }
}
