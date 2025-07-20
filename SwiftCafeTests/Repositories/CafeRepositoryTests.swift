//
//  CafeRepositoryTests.swift
//  SwiftCafeTests
//
//  Created by Jason Tse on 10/7/2025.
//

import XCTest
@testable import SwiftCafe
import Combine

final class CafeRepositoryTests: XCTestCase {
    
    var sut: CafeRepositoryProtocol!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = CafeRepository(networkService: mockNetworkService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }

    func testPostLoginRequest_WhenSuccessful_ShouldEmitUserViaPublisher() async throws {
        // Arrange
        let username = "testuser"
        let password = "testpass"
                
        guard let url = Bundle.main.url(forResource: "login", withExtension: "json")
            else {
                throw URLError(.badURL)
            }
        let data = try Data(contentsOf: url)
        mockNetworkService.mockResponse = data
        
        var receivedUser: User?
        let expectation = XCTestExpectation(description: "UserPublisher should emit user after successful login")
        
        sut.userPublisher
            .compactMap { $0 }
            .sink { user in
                receivedUser = user
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Act
        await sut.postLoginRequest(username: username, password: password)
        
        // Assert
        await fulfillment(of: [expectation], timeout: 5.0)
        XCTAssertNotNil(receivedUser)
    }
    
    
    func testFetchProducts_WhenSuccessful_ShouldFetchProductsSuccessfully() async throws {
        // Arrange
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json")
            else {
                throw URLError(.badURL)
            }
        let data = try Data(contentsOf: url)
        mockNetworkService.mockResponse = data
        
        var receivedProducts: Products?
        let expectation = XCTestExpectation(description: "ProductsPublisher should emit products after successful fetch")
        
        sut.productsPublisher
            .compactMap { $0 }
            .sink { products in
                receivedProducts = products
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Act
        try await sut.fetchProducts()
        
        // Assert
        await fulfillment(of: [expectation], timeout: 5.0)
        XCTAssertNotNil(receivedProducts)
    }
}
