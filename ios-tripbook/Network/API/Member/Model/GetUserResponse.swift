//
//  GetUserResponse.swift
//  ios-tripbook
//
//  Created by DDang on 7/4/23.
//

import Foundation

struct GetUserResponse: Decodable {
    let email: String
    let name: String
    let gender: String?
    let role: String
    let birth: String
    let profile: String?
    let termsOfService: Bool
    let termsOfPrivacy: Bool
    let termsOfLocation: Bool
    let marketingConsent: Bool
    let point: Int?
    let status: String
}

extension GetUserResponse {
    var toDomain: MyProfile {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return .init(
            role: Role(rawValue: self.role) ?? .usual,
            gender: Gender(rawValue: self.gender ?? "MALE") ?? .Male,
            birth: dateFormatter.date(from: self.birth) ?? .init(),
            profileImageURL: self.profile,
            terms: [
                .Service: self.termsOfService,
                .PersonalInfo: self.termsOfPrivacy,
                .Location: self.termsOfLocation,
                .Marketing: self.marketingConsent
            ],
            point: self.point ?? 0,
            status: self.status,
            info: .init(name: self.name, email: self.email)
        )
    }
}
