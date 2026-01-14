//
//  ProductRepository.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

protocol ProductRepository {
    func fetchProducts() async throws -> [Product]
    func fetchProduct(by id: Int) async throws -> Product?
    func toggleFavorite(productId: Int) async
    func fetchFavorites() async -> [Product]
}
