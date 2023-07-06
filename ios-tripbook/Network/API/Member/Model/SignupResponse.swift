//
//  SignupResponse.swift
//  ios-tripbook
//
//  Created by DDang on 7/2/23.
//

import Foundation

struct SignupResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let message: String
}
