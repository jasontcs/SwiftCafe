//
//  DataService.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import Foundation
import Combine

protocol CafeRepositoryProtocol {
    var userPublisher: Published<User?>.Publisher { get }
    var productsPublisher: Published<Products?>.Publisher { get }
    var cartItemsPublisher: Published<[CartItemEntity]>.Publisher { get }
    
    func postLoginRequest(username: String, password: String) async
    
    func fetchProducts() async throws
    
    func addProductToCart(_ product: Product)
    
    func removeProductFromCart(_ product: Product)
}

final class CafeRepository : CafeRepositoryProtocol {
    let networkService: NetworkServiceProtocol
    let coreDataService: CoreDataServiceProtocol
    
    private init(
        networkService: NetworkServiceProtocol = NetworkService(),
        coreDataService: CoreDataServiceProtocol = CoreDataService()
    ) {
        self.networkService = networkService
        self.coreDataService = coreDataService
        
        loadCartItems()
    }
    
    @Published var user: User?
    @Published var products: Products?
    @Published var cartItems: [CartItemEntity] = []
    var userPublisher: Published<User?>.Publisher { $user }
    var productsPublisher: Published<Products?>.Publisher { $products }
    var cartItemsPublisher: Published<[CartItemEntity]>.Publisher { $cartItems }
    
    static let shared: CafeRepositoryProtocol = CafeRepository()
    
    func postLoginRequest(username: String, password: String) async {
        let json: [String: Any] = ["username": username,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        do {
            let data = try await networkService.post(url: "https://dummyjson.com/auth/login", body: jsonData)
            
            user = try? JSONDecoder().decode(User.self, from: data)
            print("Login Success \(user?.email ?? "")")
        } catch {
            print("Error \(error)")
        }
    }
    
    func fetchProducts() async throws {
        let data = try await networkService.get(url: "https://dummyjson.com/products", token: user?.accessToken ?? "")

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
        coreDataService.addProductToCart(product.id)
        loadCartItems()
    }
    
    func removeProductFromCart(_ product: Product) {
        coreDataService.removeProductFromCart(product.id)
        loadCartItems()
    }
    
    private func loadCartItems() {
        do {
            cartItems = try coreDataService.getCartItems()
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
}
