//
//  TokenStorage.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/5/23.
//

import Foundation

class TokenStorage {
    static let shared = TokenStorage()
    
    var accessToken: String?
    var refreshToken: String?
    
    init(accessToken: String? = nil, refreshToken: String? = nil) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        
        if let tokens = UserDefaults.standard.dictionary(forKey: "UserTokens") {
            self.accessToken = tokens["accessToken"] as? String
            self.refreshToken = tokens["refreshToken"] as? String
        }
    }
    
    func setTokens(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        
        UserDefaults.standard.set([
            "accessToken": accessToken,
            "refreshToken": refreshToken
        ], forKey: "UserTokens")
    }
    
    func deleteTokens() {
        UserDefaults.standard.removeObject(forKey: "UserTokens")
        accessToken = nil
        refreshToken = nil
    }
}
