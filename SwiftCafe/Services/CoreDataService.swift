//
//  CoreDataService.swift
//  SwiftCafe
//
//  Created by Jason Tse on 5/7/2023.
//

import Foundation
import CoreData


protocol CoreDataServiceProtocol {
    
    func addProductToCart(_ productId: Int)
    func removeProductFromCart(_ productId: Int)
    func getCartItems() throws -> [CartItemEntity]
}

final class CoreDataService: CoreDataServiceProtocol {
    
    private var cartItems: [CartItemEntity] = []
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer = NSPersistentContainer(name: "ShoppingCart")) {
        self.container = container
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data: \(error)")
            }
        }
        cartItems = ( try? getCartItems() ) ?? []
    }
    
    func addProductToCart(_ productId: Int) {
        if let existingItem = cartItems.first(where: { $0.productId == productId }) {
            existingItem.amount += 1
        } else {
            let cartItem = CartItemEntity(context: container.viewContext)
            cartItem.productId = Int16(productId)
            cartItem.amount = 1
        }
        saveCoreData()
    }
    
    func removeProductFromCart(_ productId: Int) {
        guard let existingItem = cartItems.first(where: { $0.productId == productId }) else {
            return
        }
        if existingItem.amount > 1 {
            existingItem.amount -= 1
        } else {
            container.viewContext.delete(existingItem)
        }
        saveCoreData()
    }
    
    func getCartItems() throws -> [CartItemEntity] {
        let request = NSFetchRequest<CartItemEntity>(entityName: "CartItemEntity")
        return try container.viewContext.fetch(request)
    }
    
    private func saveCoreData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving: \(error)")
        }
        cartItems = ( try? getCartItems() ) ?? []
    }
}
