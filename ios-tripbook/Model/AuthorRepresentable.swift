//
//  AuthorRepresentable.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/28.
//

import Foundation

struct AuthorRepresentable {
    var id: Int
    var name: String
    var profileURL: String
    var role: String
    
    init(id: Int, name: String, profileURL: String, role: String) {
        self.id = id
        self.name = name
        self.profileURL = profileURL
        self.role = role
    }
}
