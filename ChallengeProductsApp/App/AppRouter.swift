//
//  AppRouter.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import SwiftUI
import Combine

@MainActor
final class AppRouter: ObservableObject {
    @Published var path: [AppRoute] = []
}
