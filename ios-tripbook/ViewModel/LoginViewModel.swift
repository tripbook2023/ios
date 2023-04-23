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
    
    let auth0Service = Auth0Service()
    
    @Published var profile = Profile.empty
    @Published var accessToken: String = ""
    @Published var isLoggedIn: Bool = false
    
    /**
     로그아웃 구현
     > Auth0 API를 활용한 로그아웃 구현
     - Parameter : 로그인 타입 (Apple, Kakao)
     */
    func login(type: loginType) async {
        let webAuthLoginModel = await auth0Service.webAuthLogin(type: type)
        
        // Auth0Service Login이 성공했을 때
        if webAuthLoginModel.isSuccessed {
            self.isLoggedIn = webAuthLoginModel.isSuccessed
            self.accessToken = webAuthLoginModel.accessToken!
        }
        // Auth0Service Login이 실패했을 때
        else {
            self.isLoggedIn = webAuthLoginModel.isSuccessed
        }
    }
    
    /**
     로그아웃 구현
     > Auth0 API를 활용한 로그아웃 구현
     */
    func logout() async {
        let isSuccessedLogout = await auth0Service.webAuthLogout()
            
        // Auth0Service Logout이 성공했을 때
        if isSuccessedLogout {
            self.isLoggedIn = false
        }
        // Auth0Service Logout이 실패했을 때
        else {
            
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
