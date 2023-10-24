//
//  TokenReissueResponse.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/24.
//

import Foundation

struct TokenReissueResponse: Decodable {
    let grantType: String
    let accessToken: String
    let refreshToken: String
}
