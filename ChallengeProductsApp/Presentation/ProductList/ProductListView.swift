//
//  ProductListView.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import SwiftUI
import Combine

import SwiftUI

struct ProductListView: View {

    @StateObject var viewModel: ProductListViewModel
    @ObservedObject var router: AppRouter

    var body: some View {
        VStack(spacing: 0) {

            header

            ScrollView {
                LazyVStack(spacing: 20) {
                    content
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
        }
        .navigationBarHidden(true)
        .task {
            await viewModel.load()
        }
    }

    // MARK: - Header
    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {

            HStack(spacing: 6) {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.caption)
                    .foregroundColor(.green)

                Text("SINCRONIZADO")
                    .font(.caption2)
                    .foregroundColor(.green)
            }

            Text("Productos")
                .font(.largeTitle)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
    }

    // MARK: - Content
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
                .padding(.top, 40)

        case .loaded(let products):
            ForEach(products) { product in
                NavigationLink(value: AppRoute.productDetail(product)) {
                    ProductListRowView(
                        product: product,
                        onToggleFavorite: {
                            Task {
                                await viewModel.toggleFavorite(productId: product.id)
                            }
                        }
                    )
                }
                .buttonStyle(.plain)
            }

        case .error(let message):
            Text(message)
                .foregroundColor(.red)
        }
    }
}
