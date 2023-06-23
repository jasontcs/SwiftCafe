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
    
    let dataService = DataService.instance
    
    func onLoginButtonTapped() async {
        await dataService.postLoginRequest(username: username, password: password)
    }
}
