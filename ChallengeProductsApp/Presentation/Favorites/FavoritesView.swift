//
//  FavoritesView.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import SwiftUI
import Combine

struct FavoritesView: View {

    @ObservedObject var viewModel: FavoritesViewModel

    var body: some View {
        VStack {

            Text("Favoritos")
                .font(.largeTitle)
                .bold()
                .padding()

            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.products.isEmpty {
                Text("No hay favoritos todavia")
                    .foregroundColor(.secondary)
                    .padding(.top, 40)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.products) { product in
                            ProductListRowView(
                                product: product,
                                onToggleFavorite: {
                                    Task {
                                        await viewModel.toggleFavorite(productId: product.id)
                                    }
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

