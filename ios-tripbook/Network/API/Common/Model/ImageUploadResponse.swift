//
//  ImageUploadResponse.swift
//  ios-tripbook
//
//  Created by 이시원 on 1/5/24.
//

import Foundation

struct ImageUploadResponse: Decodable {
    let id: Int
    let url: String
    let name: String
    let refID: Int
    let refType: String

    enum CodingKeys: String, CodingKey {
        case id, url, name
        case refID = "refId"
        case refType
    }
}
