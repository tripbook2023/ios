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
    private let apiManager: APIManagerable
    
    init(apiManager: APIManagerable = TBAPIManager()) {
        self.apiManager = apiManager
    }
    
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
            guard let accessToken = loginResult.accessToken else { return }
            guard let authResult = try? await apiManager.request(
                TBAuthAPI.authentication(accessToken: accessToken),
                type: AuthenticationResponse.self
            ).toDomain else { return }
            succeededAuthentication(authResult)
        }
    }
    
    func didTapKakaoLoginButton() async -> String {
        let loginResult = await Auth0Service.kakaoAuthLogin()
        
        // Auth0Service Login이 성공했을 때
        if loginResult.isSuccessed {
            guard let accessToken = loginResult.accessToken else { return "" }
            guard let authResult = try? await apiManager.request(
                TBAuthAPI.authentication(accessToken: accessToken),
                type: AuthenticationResponse.self
            ).toDomain else { return "" }
            succeededAuthentication(authResult)
        }
        return ""
    }
}
