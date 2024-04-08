//
//  Author.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/30/23.
//

import Foundation

struct Author {
    let id: Int
    let name: String
    let profileUrl: URL?
    let role: String
    
    init(id: Int, name: String, profileUrl: String?, role: String) {
        self.id = id
        self.name = name
        if let profileUrl = profileUrl {
            self.profileUrl = URL(string: profileUrl)
        } else {
            self.profileUrl = nil
        }
        self.role = role
    }
}
