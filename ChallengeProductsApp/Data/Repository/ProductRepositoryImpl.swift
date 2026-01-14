//
//  ProductRepositoryImpl.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import Foundation

final class ProductRepositoryImpl: ProductRepository {

    private let remote: ProductRemoteDataSourceProtocol
    private let local: ProductLocalDataSource

    init(
        remote: ProductRemoteDataSourceProtocol,
        local: ProductLocalDataSource
    ) {
        self.remote = remote
        self.local = local
    }

    func fetchProducts() async throws -> [Product] {
        let cached = try local.fetchProducts()

        Task {
            do {
                let dtos = try await remote.fetchProducts()
                let products = dtos.map { dto in
                    Product(
                        id: dto.id,
                        title: dto.title,
                        price: dto.price,
                        description: dto.description ?? "",
                        category: dto.category ?? "",
                        imageURL: URL(string: dto.image ?? "")!,
                        rating: dto.rating?.rate ?? 0.0,
                        ratingCount: dto.rating?.count ?? 0,
                        isFavorite: cached.first(where: { $0.id == dto.id })?.isFavorite ?? false
                    )
                }
                try local.save(products: products)
            } catch { }
        }

        return cached
    }
    
    func fetchProduct(by id: Int) async throws -> Product? {
        try? local.fetchProduct(by: id)
    }

    func toggleFavorite(productId: Int) async {
        try? local.toggleFavorite(productId: productId)
    }

    func fetchFavorites() async -> [Product] {
        (try? local.fetchFavorites()) ?? []
    }
}

