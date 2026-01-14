//
//  LoadingView.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text("Cargando…")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
