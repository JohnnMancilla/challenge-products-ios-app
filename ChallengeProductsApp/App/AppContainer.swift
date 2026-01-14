//
//  AppContainer.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import CoreData

final class AppContainer {

    let apiClient: APIClient
    let productRepository: ProductRepository

    init() {
        self.apiClient = URLSessionAPIClient()

        let persistence = PersistenceController.shared
        let local = ProductLocalDataSource(
            context: persistence.container.viewContext
        )
        let remote = ProductRemoteDataSource(apiClient: apiClient)

        self.productRepository = ProductRepositoryImpl(
            remote: remote,
            local: local
        )
    }
}
