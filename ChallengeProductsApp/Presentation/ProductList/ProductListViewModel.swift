//
//  ProductListViewModel.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import SwiftUI
import Combine

@MainActor
final class ProductListViewModel: ObservableObject {

    enum State {
        case loading
        case loaded([Product])
        case error(String)
    }

    @Published var state: State = .loading

    private let repository: ProductRepository
    private var hasLoaded = false

    init(repository: ProductRepository) {
        self.repository = repository
    }

    func load() async {
        do {
            let products = try await repository.fetchProducts()
            state = .loaded(products)
        } catch {
            state = .error("Fallo al cargar los productos")
        }
    }

    func toggleFavorite(productId: Int) async {
        await repository.toggleFavorite(productId: productId)
        await load()
    }
}
