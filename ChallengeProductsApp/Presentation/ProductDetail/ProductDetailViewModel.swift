//
//  ProductDetailViewModel.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import Foundation
import Combine

@MainActor
final class ProductDetailViewModel: ObservableObject {

    @Published private(set) var product: Product

    private let repository: ProductRepository
    private let productId: Int

    init(product: Product, repository: ProductRepository) {
        self.product = product
        self.productId = product.id
        self.repository = repository
    }

    func reload() async {
        if let updated = try? await repository.fetchProduct(by: productId) {
            product = updated
        }
    }

    func toggleFavorite() async {
        await repository.toggleFavorite(productId: product.id)

        // Crear una nueva copia (inmutabilidad)
        product = Product(
            id: product.id,
            title: product.title,
            price: product.price,
            description: product.description,
            category: product.category,
            imageURL: product.imageURL,
            rating: product.rating,
            ratingCount: product.ratingCount,
            isFavorite: !product.isFavorite
        )
    }
}
