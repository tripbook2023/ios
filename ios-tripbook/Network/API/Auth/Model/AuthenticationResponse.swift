//
//  AuthenticationResponse.swift
//  ios-tripbook
//
//  Created by DDang on 7/1/23.
//

import Foundation

struct AuthenticationResponse: Decodable {
    let nickname: String?
    let accessToken: String?
    let refreshToken: String?
    let status: String?
    let email: String?
}

extension AuthenticationResponse {
    var toDomain: AuthenticationResult {
        return .init(
            email: self.email ?? "",
            status: AuthenticationResult.AuthStatus(rawValue: self.status ?? "") ?? .requiredAuth
        )
    }
}
