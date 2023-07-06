//
//  LoginViewModel.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import Foundation

@MainActor final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    let repository: CafeRepositoryProtocol
    
    init(repository: CafeRepositoryProtocol = CafeRepository.shared) {
        self.repository = repository
    }
    
    func onLoginButtonTapped() async {
        await repository.postLoginRequest(username: username, password: password)
    }
}
