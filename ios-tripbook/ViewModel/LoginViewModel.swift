//
//  LoginViewModel.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/22.
//
//
//  예상 프로세스
//  Auth0 인증 -> 엑세스토큰 수집 -> 엑세스토큰 백엔드 전달 -> 엑세스토큰 기반으로 회원 정보 유무 판단 -> 결과 전송?

import Foundation
import Auth0

class LoginViewModel: ObservableObject {
    @Published var profile = Profile.empty
    @Published var accessToken: String = ""
    @Published var isLoggedIn: Bool = false
    
    /**
     로그아웃 구현
     > Auth0 API를 활용한 로그아웃 구현
     - Parameter : 로그인 타입 (Apple, Kakao)
     */
    func login(type: loginType) {
        var loginType: String = ""
        
        if type == .apple {
            loginType = "apple"
        } else if type == .kakao {
            loginType = "Kakao-Login"
        }
        
        Auth0
            .webAuth()
            .connection(loginType)
            .useEphemeralSession()
            .start { result in
                switch result {
                case .failure(let error):
                    print("로그인 실패: \(error)")
                    self.isLoggedIn = false
                case .success(let credentials):
                    self.isLoggedIn = true
                    self.accessToken = credentials.accessToken
                    print("로그인 성공: \(credentials)")
                    print("ID Token: \(credentials.idToken)")
                    print("Access Token: \(credentials.accessToken)")
                } // switch
            }
    }
    
    /**
     로그아웃 구현
     > Auth0 API를 활용한 로그아웃 구현
     */
    func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case.failure(let error):
                    print("로그아웃 실패: \(error)")
                case.success:
                    self.isLoggedIn = false
                    print("로그아웃 성공")
                }
            }
    }
}

extension LoginViewModel {
    /// 로그인 유형 Enum 설정
    enum loginType {
        case kakao
        case apple
    }
}
