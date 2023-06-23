//
//  DataService.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import Foundation
import CoreData

actor DataService {
    static let instance = DataService()
    
    let container = NSPersistentContainer(name: "ShoppingCart")
    
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data: \(error)")
            }
        }
        Task {
            await loadCartItems()
        }
    }
    
    @Published var user: User?
    @Published var products: Products?
    @Published var cartItems: [CartItemEntity] = []
    
    
    func postLoginRequest(username: String, password: String) async {
        let json: [String: Any] = ["username": username,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: "https://dummyjson.com/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            user = try? JSONDecoder().decode(User.self, from: data)
        } catch {
            print("Error \(error)")
        }
    }
    
    func fetchProducts() async throws {
        let url = URL(string: "https://dummyjson.com/auth/products")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(user?.token ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, _) = try await URLSession.shared.data(for: request)

//        MOCK
        
//        guard let url = Bundle.main.url(forResource: "products", withExtension: "json")
//            else {
//                throw URLError(.badURL)
//            }
//        let data = try Data(contentsOf: url)
        
        let products = try JSONDecoder().decode(Products.self, from: data)
        self.products = products
    }
    
    func addProductToCart(_ product: Product) {
        if let existingItem = cartItems.first(where: { $0.productId == product.id }) {
            existingItem.amount += 1
        } else {
            let cartItem = CartItemEntity(context: container.viewContext)
            cartItem.productId = Int16(product.id)
            cartItem.amount = 1
        }
        saveCoreData()
    }
    
    func removeProductFromCart(_ product: Product) {
        guard let existingItem = cartItems.first(where: { $0.productId == product.id }) else {
            return
        }
        if existingItem.amount > 1 {
            existingItem.amount -= 1
        } else {
            container.viewContext.delete(existingItem)
        }
        saveCoreData()
    }
    
    private func saveCoreData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving: \(error)")
        }
        loadCartItems()
    }
    
    private func loadCartItems() {
        let request = NSFetchRequest<CartItemEntity>(entityName: "CartItemEntity")
        
        do {
            cartItems = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    private func dataToString(_ data: Data) -> String? {
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
