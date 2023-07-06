//
//  SignupRequest.swift
//  ios-tripbook
//
//  Created by DDang on 7/2/23.
//

import Foundation
import UIKit

struct SignupRequest {
    let name: String
    let email: String
    let imageFile: UIImage?
    let termsOfService: Bool
    let termsOfPrivacy: Bool
    let termsOfLocation: Bool
    let marketingConsent: Bool
    let gender: String
    let birth: String
}
