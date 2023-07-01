//
//  NicknameValidationResponse.swift
//  ios-tripbook
//
//  Created by DDang on 6/25/23.
//

import Foundation

struct NicknameValidationResponse: Decodable {
    let status: String?
    let message: [String]?
}

extension NicknameValidationResponse {
    var toDomain: Bool {
        return self.status != nil && self.message != nil
    }
}
