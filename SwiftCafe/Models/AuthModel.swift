//
//  AuthModel.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import Foundation

struct User: Codable {
    let id: Int
    let username, email, firstName, lastName: String
    let gender: String
    let image: String
    let accessToken: String
    let refreshToken: String
}
