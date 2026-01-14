//
//  AppRootView.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import SwiftUI
import Combine

struct AppRootView: View {

    let container: AppContainer
    @StateObject private var router = AppRouter()

    var body: some View {
        TabView {

            NavigationStack(path: $router.path) {
                ProductListView(
                    viewModel: ProductListViewModel(
                        repository: container.productRepository
                    ),
                    router: router
                )
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .productDetail(let product):
                        ProductDetailView(
                            viewModel: ProductDetailViewModel(
                                product: product,
                                repository: container.productRepository
                            )
                        )
                    case .favorites:
                        FavoritesView(
                            viewModel: FavoritesViewModel(
                                repository: container.productRepository
                            )
                        )
                    }
                }
            }
            .tabItem {
                Label("Productos", systemImage: "bag")
            }

            NavigationStack {
                FavoritesView(
                    viewModel: FavoritesViewModel(
                        repository: container.productRepository
                    )
                )
            }
            .tabItem {
                Label("Favoritos", systemImage: "heart")
            }
        }
    }
}
