//
//  URLSessionAPIClient.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import Foundation

final class URLSessionAPIClient: APIClient {

    func get<T: Decodable>(_ endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
