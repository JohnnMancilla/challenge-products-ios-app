//
//  ProductRepositoryImplTests.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//
import XCTest
import CoreData
@testable import ChallengeProductsApp

@MainActor
final class ProductRepositoryImplTests: XCTestCase {

    var persistence: PersistenceController!
    var local: ProductLocalDataSource!
    var repository: ProductRepositoryImpl!

    // MARK: - Mock Remote
    final class MockRemoteDataSource: ProductRemoteDataSourceProtocol {

        var dtos: [ProductDTO] = []

        func fetchProducts() async throws -> [ProductDTO] {
            dtos
        }
    }

    override func setUp() {
        super.setUp()

        persistence = PersistenceController(inMemory: true)
        local = ProductLocalDataSource(context: persistence.container.viewContext)

        let remote = MockRemoteDataSource()
        repository = ProductRepositoryImpl(
            remote: remote,
            local: local
        )
    }

    func testFetchProductsReturnsCachedData() async throws {
        let cached = Product(
            id: 1,
            title: "Cached",
            price: 10,
            description: "Desc",
            category: "Cat",
            imageURL: URL(string: "https://test.com")!,
            rating: 4.0,
            ratingCount: 2,
            isFavorite: false
        )

        try local.save(products: [cached])

        let result = try await repository.fetchProducts()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.title, "Cached")
    }
}
