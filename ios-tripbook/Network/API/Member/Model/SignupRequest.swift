//
//  SignupRequest.swift
//  ios-tripbook
//
//  Created by DDang on 7/2/23.
//

import Foundation

struct SignupRequest: Requestable {
    let name: String
    let email: String
    let termsOfService: Bool
    let termsOfPrivacy: Bool
    let termsOfLocation: Bool
    let marketingConsent: Bool
    let gender: String
    let birth: String
    
    var parameter: [String : Any] {
        return [
            "name": name,
            "email": email,
            "termsOfService": termsOfService,
            "termsOfPrivacy": termsOfPrivacy,
            "termsOfLocation": termsOfLocation,
            "marketingConsent": marketingConsent,
            "gender": gender,
            "birth": birth
        ]
    }
}
