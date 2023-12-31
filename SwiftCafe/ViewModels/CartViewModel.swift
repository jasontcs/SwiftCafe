//
//  CartViewModel.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import Combine
import Foundation

@MainActor final class CartViewModel: ObservableObject {
    
    @Published var cartItems: [CartItem] = []
    
    var cancellables = Set<AnyCancellable>()
    let repository: CafeRepositoryProtocol
    
    init(repository: CafeRepositoryProtocol = CafeRepository.shared) {
        self.repository = repository
        
        repository.cartItemsPublisher
            .combineLatest(repository.productsPublisher)
            .receive(on:DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("ERROR: \(error)")
                    break
                }
            } receiveValue: { cartItems, products in
                self.cartItems = cartItems.compactMap { cartItem in
                    guard let product = products?.products.first(where: {
                        $0.id == Int(cartItem.productId) }
                    ) else {
                        return nil
                    }
                    return CartItem(product: product, amount: Int(cartItem.amount))
                }
            }.store(in: &cancellables)
    }
    
    func removeOnTap(_ item: CartItem) {
        repository.removeProductFromCart(item.product)
    }
}
