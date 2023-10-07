//
//  AuthenticationResult.swift
//  ios-tripbook
//
//  Created by DDang on 7/1/23.
//

import Foundation

struct AuthenticationResult {
    enum AuthStatus: String {
        case normal = "STATUS_NORMAL"
        case requiredAuth = "STATUS_REQUIRED_AUTH"
    }
    
    let email: String
    let accessToken: String?
    let refreshToken: String?
    let status: AuthStatus
}
