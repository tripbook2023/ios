//
//  SignupSocialViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/15.
//

import Foundation
import AuthenticationServices
import Alamofire

protocol SignupSocialViewModelDelegate {
    func completionAuthentication(email: String)
}

class SignupSocialViewModel: ObservableObject {
    @Published var goToRootNavigationTrigger: Bool = false
    @Published var continueNavigationTrigger: Bool = false
    
    var delegate: SignupSocialViewModelDelegate?
    
    func succeededAuthentication(_ result: AuthenticationResult) {
        switch result.status {
        case .normal:
            self.goToRootNavigationTrigger = true
            break
        case .requiredAuth:
            self.delegate?.completionAuthentication(email: result.email)
            self.continueNavigationTrigger = true
        }
    }
}

extension SignupSocialViewModel: SignupSocialViewDelegate {
    func didTapAppleLoginButton(_ credential: ASAuthorizationCredential) async {
        let loginResult = await Auth0Service.appleAuthLogin(credential)
        
        if loginResult.isSuccessed {
            TBAuthAPI.authentication(.init(accessToken: loginResult.accessToken!), completion: { authResult in
                self.succeededAuthentication(authResult)
            })
        }
    }
    
    func didTapKakaoLoginButton() async -> String {
        let loginResult = await Auth0Service.kakaoAuthLogin()
        
        // Auth0Service Login이 성공했을 때
        if loginResult.isSuccessed {
            TBAuthAPI.authentication(.init(accessToken: loginResult.accessToken!), completion: { authResult in
                self.succeededAuthentication(authResult)
            })
        }
        return ""
    }
}
