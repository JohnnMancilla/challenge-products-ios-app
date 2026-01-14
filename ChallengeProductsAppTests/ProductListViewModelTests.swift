//
//  ProductListViewModelTests.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import XCTest
@testable import ChallengeProductsApp

@MainActor
final class ProductListViewModelTests: XCTestCase {

    final class MockRepository: ProductRepository {

        var products: [Product] = []
        var shouldFail = false

        func fetchProducts() async throws -> [Product] {
            if shouldFail { throw URLError(.badServerResponse) }
            return products
        }

        func fetchProduct(by id: Int) async throws -> Product? {
            products.first { $0.id == id }
        }

        func toggleFavorite(productId: Int) async {}
        func fetchFavorites() async -> [Product] { [] }
    }

    func testLoadSuccess() async {
        let repo = MockRepository()
        repo.products = [
            Product(
                id: 1,
                title: "Test",
                price: 10,
                description: "Desc",
                category: "Cat",
                imageURL: URL(string: "https://test.com")!,
                rating: 4.5,
                ratingCount: 10,
                isFavorite: false
            )
        ]

        let vm = ProductListViewModel(repository: repo)
        await vm.load()

        if case .loaded(let products) = vm.state {
            XCTAssertEqual(products.count, 1)
        } else {
            XCTFail("Expected loaded state")
        }
    }
}

