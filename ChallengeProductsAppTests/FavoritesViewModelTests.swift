//
//  FavoritesViewModelTests.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import XCTest
@testable import ChallengeProductsApp

final class FavoritesViewModelTests: XCTestCase {

    final class MockRepository: ProductRepository {
        
        

        var favorites: [Product] = []

        func fetchProducts() async throws -> [Product] { [] }
        func fetchProduct(by id: Int) async throws -> Product? {
            return favorites.first { $0.id == id }
        }
        func toggleFavorite(productId: Int) async {}
        func fetchFavorites() async -> [Product] {
            favorites
        }
    }

    @MainActor func testFavoritesAreLoaded() async {
        let repo = MockRepository()
        repo.favorites = [
            Product(
                id: 1,
                title: "Fav",
                price: 20,
                description: "Desc",
                category: "Cat",
                imageURL: URL(string: "https://test.com")!,
                rating: 5.0,
                ratingCount: 10,
                isFavorite: true
            )
        ]

        let vm = FavoritesViewModel(repository: repo)
        await vm.load()

        XCTAssertEqual(vm.products.count, 1)
        XCTAssertTrue(vm.products.first?.isFavorite == true)
    }
}

