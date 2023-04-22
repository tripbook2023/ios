//
//  ProfileModel.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/21.
//

import Foundation

struct Profile {
    let id: String
    let name: String
    let email: String
    let emailVerified: String
    let picture: String
    let updatedAt: String
}

extension Profile {
    
    static var empty: Self {
        return Profile(
            id: "",
            name: "",
            email: "",
            emailVerified: "",
            picture: "",
            updatedAt: ""
        )
    }
}


// 추후 삭제 예정
// The Callback / Logout URL Format
// {BUNDLE_IDENTIFIER}://{YOUR_DOMAIN}/ios/{BUNDLE_IDENTIFIER}/callback

// com.tripbookteam07.tripbook://dev-z2b4bazfo6o536tj.us.auth0.com/ios/com.tripbookteam07.tripbook/callback
