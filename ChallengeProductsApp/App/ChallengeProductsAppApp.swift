//
//  ChallengeProductsAppApp.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import SwiftUI

@main
struct ChallengeProductsApp: App {

    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            AppRootView(container: container)
        }
    }
}
