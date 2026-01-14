//
//  ProductRemoteDataSource.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//
protocol ProductRemoteDataSourceProtocol {
    func fetchProducts() async throws -> [ProductDTO]
}

final class ProductRemoteDataSource: ProductRemoteDataSourceProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchProducts() async throws -> [ProductDTO] {
        try await apiClient.get("https://fakestoreapi.com/products")
    }
}
