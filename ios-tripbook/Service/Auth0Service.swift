//
//  Auth0Service.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/24.
//

import Auth0

class Auth0Service {
    
    /**
     struct: webAuthLogin Return Value
     Auth0 Login API를 통해 반환되는 Struct 값
     - Variables
        - isSuccessed (Boolean): Auth0 Login API 호출 및 응답이 정상적이었는지
        - accessToken (String)(Optional): 정상적인 Auth0 Login API 응답값으로 credentials에서 accessToken을 추출
     */
    struct WebAuthLoginModel {
        let isSuccessed: Bool
        let accessToken: String?
        
        init(isSuccessed: Bool, accessToken: String? = nil) {
            self.isSuccessed = isSuccessed
            self.accessToken = accessToken
        }
    }
    
    /**
     function: Auth0 Login API 호출
     - Parameters
        - type (LoginViewModel.loginType): Auth0 Social Login Type
     - Returns
        - WebAuthLoginModel
     */
    func webAuthLogin(type: LoginViewModel.loginType) async -> WebAuthLoginModel {
        do {
            var loginType: String = ""
            
            if type == .apple {
                loginType = "apple"
            } else if type == .kakao {
                loginType = "Kakao-Login"
            }
            
            let credentials = try await Auth0.webAuth().connection(loginType).useEphemeralSession().start()
            
            print("로그인 성공: \(credentials)")
            print("ID Token: \(credentials.idToken)")
            print("Access Token: \(credentials.accessToken)")
            
            return WebAuthLoginModel(isSuccessed: true, accessToken: credentials.accessToken)
        } catch {
            print("로그인 실패: \(error)")
            
            return WebAuthLoginModel(isSuccessed: false)
        }
    }
    
    /**
     function: Auth0 Logout API 호출
     - Returns
        - Boolean: Auth0 Logout API 호출 및 응답이 정상적으로 이루어졌는지
     */
    func webAuthLogout() async -> Bool {
        do {
            try await Auth0.webAuth().clearSession()
            
            print("로그아웃 성공")
            
            return true
        } catch {
            print("로그아웃 실패: \(error)")
            
            return false
        }
    }
}
