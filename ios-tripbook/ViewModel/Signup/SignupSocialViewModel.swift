//
//  SignupSocialViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/15.
//

import Foundation

class SignupSocialViewModel: ObservableObject {
    @Published var navigationTrigger: Bool = false
}

extension SignupSocialViewModel: SignupSocialViewDelegate {
    func didTapSocialLoginButton(_ type: SignupViewModel.SocialLoginMethod) {
        switch type {
        case .KAKAO: break
        case .APPLE: break
        }
        
        self.navigationTrigger.toggle()
    }
}
