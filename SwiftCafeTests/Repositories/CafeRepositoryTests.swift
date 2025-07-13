//
//  CafeRepositoryTests.swift
//  SwiftCafeTests
//
//  Created by Jason Tse on 10/7/2025.
//

import Testing
@testable import SwiftCafe
import Combine

struct CafeRepositoryTests {

    @Test func testPostLoginRequest() async throws {
        // Arrange
        let repository = CafeRepository.shared
        var cancellables = Set<AnyCancellable>()
        let username = "emilys"
        let password = "emilyspass"
        
        await withCheckedContinuation { continuation in
            repository.userPublisher
                .dropFirst()
                .sink { user in
                    // Assert
                    #expect(user != nil)
                    continuation.resume()
                }
                .store(in: &cancellables)

            Task {
                // Act
                await repository.postLoginRequest(username: username, password: password)
            }
        }
    }

    @Test func testFetchProducts() async throws {
        // Arrange
        let repository = CafeRepository.shared
        var cancellables = Set<AnyCancellable>()
        
        await withCheckedContinuation { continuation in
            repository.productsPublisher
                .dropFirst()
                .sink { products in
                    // Assert
                    #expect(products != nil)
                    #expect(products?.products.isEmpty == false)
                    continuation.resume()
                }
                .store(in: &cancellables)

            Task {
                // Act
                try? await repository.fetchProducts()
            }
        }
    }
}
