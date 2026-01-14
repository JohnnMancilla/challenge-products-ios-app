//
//  ProductDetailView.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import SwiftUI
import Combine

struct ProductDetailView: View {

    @ObservedObject var viewModel: ProductDetailViewModel

    var body: some View {
        ScrollView {
            
            ZStack {
                GeometryReader { geo in
                    AsyncImage(url: viewModel.product.imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    Button {
                        Task { await viewModel.toggleFavorite() }
                    } label: {
                        Image(systemName: viewModel.product.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.product.isFavorite ? .red : .white)
                            .font(.title2)
                            .padding(12)
                            .background(.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .position(
                        x: geo.size.width - 32,
                        y: 32
                    )
                }
            }
            .frame(height: 360)
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text(viewModel.product.title)
                    .font(.largeTitle)
                    .bold()
                
                Text(viewModel.product.category.capitalized)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.secondary.opacity(0.1))
                    )
                
                Text("$\(viewModel.product.price, specifier: "%.2f")")
                    .font(.title2)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(viewModel.product.rating, specifier: "%.1f")")
                    Text("(\(viewModel.product.ratingCount))")
                        .foregroundColor(.secondary)
                }
                
                Text(viewModel.product.description)
                    .lineSpacing(6)
            }
            .padding()
        }.onAppear {
            Task {
                await viewModel.reload()
            }
        }
    }
}
