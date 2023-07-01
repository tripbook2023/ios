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
    
    func registerUserProfileImage(_ image: UIImage) {
        self.userData.profileImage = image
    }
    
    func registerUserGender(_ gender: RegisterationUser.Gender) {
        self.userData.gender = gender
    }
    
    func registerUserBirth(_ birth: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.userData.birth = dateFormatter.string(from: birth)
    }
    
    func registerUser(completion: @escaping () -> Void) {
        print("User: ", self.userData)
        
        TBMemberAPI.signup(
            .init(
                name: self.userData.name,
                email: self.userData.email,
                imageFile: self.userData.profileImage,
                termsOfService: self.userData.terms[RegisterationUser.Term.Service.rawValue]!,
                termsOfPrivacy: self.userData.terms[RegisterationUser.Term.PersonalInfo.rawValue]!,
                termsOfLocation: self.userData.terms[RegisterationUser.Term.Location.rawValue]!,
                marketingConsent: self.userData.terms[RegisterationUser.Term.Marketing.rawValue]!,
                gender: self.userData.gender!.rawValue,
                birth: self.userData.birth
            )
        ) {
            completion()
        }
    }
}

extension SignupViewModel: SignupSocialViewModelDelegate {
    func completionAuthentication(email: String) {
        self.registerUserEmail(email)
        
        print("Current User Data: ", self.userData)
    }
}
