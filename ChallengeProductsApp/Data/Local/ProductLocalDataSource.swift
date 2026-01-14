//
//  ProductLocalDataSource.swift
//  ChallengeProductsApp
//
//  Created by Johnn Mancilla on 14-01-26.
//

import CoreData

final class ProductLocalDataSource {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchProducts() throws -> [Product] {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        return try context.fetch(request).map { $0.toDomain() }
    }

    func fetchProduct(by id: Int) throws -> Product? {
        return try fetchProducts().first { $0.id == id }
    }
    
    func save(products: [Product]) throws {
        products.forEach { product in
            let entity = fetchEntity(id: product.id) ?? ProductEntity(context: context)
            entity.update(from: product)
        }
        try context.save()
    }

    func toggleFavorite(productId: Int) throws {
        guard let entity = fetchEntity(id: productId) else { return }
        entity.isFavorite.toggle()
        try context.save()
    }

    func fetchFavorites() throws -> [Product] {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES")
        return try context.fetch(request).map { $0.toDomain() }
    }

    private func fetchEntity(id: Int) -> ProductEntity? {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        return try? context.fetch(request).first
    }
}
