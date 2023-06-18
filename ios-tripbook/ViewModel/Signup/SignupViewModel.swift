//
//  SignupViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/14.
//

import Foundation
import SwiftUI

class SignupViewModel: ObservableObject {
    enum SocialLoginMethod {
        case KAKAO
        case APPLE
    }
    
    var userData = RegisterationUser()
    
    func registerUserEmail(_ email: String) {
        self.userData.email = email
    }
    
    func registerUserTerms(_ terms: [String:Bool]) {
        self.userData.terms = terms
    }
    
    func registerUserName(_ name: String) {
        self.userData.name = name
    }
    
    func registerUserProfileImage(_ image: Image) {
        self.userData.profileImage = image
    }
    
    func registerUserGender(_ gender: RegisterationUser.Gender) {
        self.userData.gender = gender
    }
    
    func registerUserAge(_ age: Int) {
        let birth = Calendar.current.date(byAdding: .year, value: -age, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.userData.birth = dateFormatter.string(from: birth!)
    }
    
    func registerUser() {
        print("User:", self.userData)
    }
}
