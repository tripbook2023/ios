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
    let gender: String?
    let birth: String?
    
    var parameter: [String : Any] {
        var parameter: [String : Any] = [
            "name": name,
            "email": email,
            "termsOfService": termsOfService,
            "termsOfPrivacy": termsOfPrivacy,
            "termsOfLocation": termsOfLocation,
            "marketingConsent": marketingConsent
        ]
        if gender != nil { parameter["gender"] = gender }
        if birth != nil { parameter["birth"] = birth }
        return parameter
    }
}
