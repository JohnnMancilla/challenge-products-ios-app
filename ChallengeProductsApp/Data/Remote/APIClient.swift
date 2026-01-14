
//
//  APICLiente.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

protocol APIClient {
    func get<T: Decodable>(_ endpoint: String) async throws -> T
}
