//
//  SelectMyArticlesResponse.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/12/23.
//

import Foundation

class SelectMyArticlesResponse: SearchResponse {
    
    enum CodingKeys: String, CodingKey {
        case totalPages
        case totalElements
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.totalElements = try container.decode(Int.self, forKey: .totalElements)
        try super.init(from: decoder)
    }
    let totalPages: Int
    let totalElements: Int
}
