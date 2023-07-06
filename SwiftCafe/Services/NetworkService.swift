//
//  NetworkService.swift
//  SwiftCafe
//
//  Created by Jason Tse on 5/7/2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func post(url: String, body: Data?) async throws -> Data
    func get(url: String, token: String) async throws -> Data
}

final class NetworkService: NetworkServiceProtocol {
    func post(url: String, body: Data?) async throws -> Data {
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    func get(url: String, token: String) async throws -> Data {
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
