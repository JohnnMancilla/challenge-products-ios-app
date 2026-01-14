//
//  FavoritesViewModel.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import SwiftUI
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {

    @Published var products: [Product] = []
    @Published var isLoading = false

    private let repository: ProductRepository

    init(repository: ProductRepository) {
        self.repository = repository
    }

    func load() async {
        isLoading = true
        products = await repository.fetchFavorites()
        isLoading = false
    }

    func toggleFavorite(productId: Int) async {
        await repository.toggleFavorite(productId: productId)
        await load() // vuelve a cargar para sacarlo de la lista
    }
}


