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
    
    func registerUserProfileImage(_ image: Image) {
        self.userData.profileImage = image
    }
}
