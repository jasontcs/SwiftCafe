//
//  MainViewModel.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import Combine
import Foundation

@MainActor final class MainViewModel: ObservableObject {
    @Published var user: User?
    
    var cancellables = Set<AnyCancellable>()
    let repository: CafeRepositoryProtocol
    
    init(repository: CafeRepositoryProtocol = CafeRepository.shared) {
        self.repository = repository
        
        repository.userPublisher
            .receive(on:DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("ERROR: \(error)")
                    break
                }
            } receiveValue: { user in
                self.user = user
            }.store(in: &cancellables)
    }
}
