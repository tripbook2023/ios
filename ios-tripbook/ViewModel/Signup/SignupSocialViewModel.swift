//
//  SignupSocialViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/15.
//

import Foundation
import AuthenticationServices

class SignupSocialViewModel: ObservableObject {
    @Published var navigationTrigger: Bool = false
}

extension SignupSocialViewModel: SignupSocialViewDelegate {
    func didTapAppleLoginButton(_ credential: ASAuthorizationCredential) async {
        let loginResult = await Auth0Service.appleAuthLogin(credential)
        
        if loginResult.isSuccessed {
            self.navigationTrigger.toggle()
        }
    }
    
    func didTapKakaoLoginButton() async -> String {
        let loginResult = await Auth0Service.kakaoAuthLogin()
        
        // Auth0Service Login이 성공했을 때
        if loginResult.isSuccessed {
            self.navigationTrigger.toggle()
        }
        return ""
    }
}
