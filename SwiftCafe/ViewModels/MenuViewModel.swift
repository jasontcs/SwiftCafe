//
//  MenuViewModel.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import Combine
import Foundation

@MainActor final class MenuViewModel: ObservableObject {
    @Published var products: [Product]?
    @Published var cartCount: Int?
    
    var cancellables = Set<AnyCancellable>()
    let repository: CafeRepositoryProtocol
    
    init(repository: CafeRepositoryProtocol = CafeRepository.shared) {
        self.repository = repository
        
        repository.productsPublisher
            .combineLatest(repository.cartItemsPublisher)
            .receive(on:DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("ERROR: \(error)")
                    break
                }
            } receiveValue: { products, cartItems in
                self.products = products?.products
                self.cartCount = cartItems.reduce(0, { current, next in
                    current + Int(next.amount)
                })
            }.store(in: &cancellables)
    }
    func fetchProducts() async {
        do {
            try await repository.fetchProducts()
        } catch {
            print("Error \(error)")
        }
    }
    
    func addToCart(_ product:Product) {
        repository.addProductToCart(product)
    }
}
