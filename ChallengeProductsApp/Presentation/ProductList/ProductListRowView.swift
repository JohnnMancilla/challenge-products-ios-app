//
//  ProductListRowView.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import SwiftUI

struct ProductListRowView: View {

    let product: Product
    let onToggleFavorite: (() -> Void)?

    init(product: Product, onToggleFavorite: (() -> Void)? = nil) {
        self.product = product
        self.onToggleFavorite = onToggleFavorite
    }

    var body: some View {
        HStack(spacing: 16) {

            productImage

            VStack(alignment: .leading, spacing: 6) {

                Text(product.category.uppercased())
                    .font(.caption2)
                    .foregroundColor(.secondary)

                Text(product.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                rating

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                    .bold()
            }

            Spacer()

            favoriteIcon
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(
                    color: Color.black.opacity(0.04),
                    radius: 10,
                    y: 4
                )
        )
    }

    // MARK: - Subviews

    private var productImage: some View {
        AsyncImage(url: product.imageURL) { image in
            image
                .resizable()
                .scaledToFit()
                .padding(10)
        } placeholder: {
            Color.gray.opacity(0.15)
        }
        .frame(width: 72, height: 72)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }

    private var rating: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.caption)
                .foregroundColor(.yellow)

            Text("\(product.rating, specifier: "%.1f")")
                .font(.caption)

            Text("(\(product.ratingCount))")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }

    private var favoriteIcon: some View {
        Button(action: { onToggleFavorite?() }) {
            Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                .foregroundColor(product.isFavorite ? .red : .gray)
                .font(.title3)
        }
        .buttonStyle(.plain)
    }
}

