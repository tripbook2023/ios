//
//  UserModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/18.
//

import Foundation
import UIKit

enum Term: String {
    case Service        = "termsOfService"
    case PersonalInfo   = "termsOfPrivacy"
    case Location       = "termsOfLocation"
    case Marketing      = "marketingConsent"
}
enum Gender: String {
    case Male           = "MALE"
    case Female         = "FEMALE"
}

/// 사용자 Data Model
/// - Author: 김민규
/// - Date: 2023/05/20
class User: Codable {
    /// 이름(닉네임)
    var name: String
    
    /// 이메일
    let email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

/// 사용자 권한
enum Role: String {
    /// 일반
    case usual = "ROLE_MEMBER"
    
    /// 에디터
    case editor
    
    /// 관리자
    case manager
}

class MyProfile {
    /// 사용자 권한
    var role: Role
    
    let gender: Gender
    
    let birth: Date
    
    var profileImageURL: String?
    
    var terms: [Term:Bool]
    
    var point: Int
    
    var status: String
    
    var info: User?
    
    init(role: Role, gender: Gender, birth: Date, profileImageURL: String? = nil, terms: [Term:Bool], point: Int, status: String, info: User? = nil) {
        self.role = role
        self.gender = gender
        self.birth = birth
        self.profileImageURL = profileImageURL
        self.terms = terms
        self.point = point
        self.status = status
        self.info = info
    }
}
