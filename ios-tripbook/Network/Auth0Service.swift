//
//  Auth0Service.swift
//  ios-tripbook
//
//  Created by DDang on 6/24/23.
//

import Auth0
import AuthenticationServices
import SimpleKeychain
import JWTDecode

class Auth0Service: NSObject {
    enum AuthenticationSocialType: String {
        case Apple = "apple"
        case Kakao = "Kakao-Login"
    }
    
    /**
     struct: webAuthLogin Return Value
     Auth0 Login API를 통해 반환되는 Struct 값
     - Variables
     - isSuccessed (Boolean): Auth0 Login API 호출 및 응답이 정상적이었는지
     - accessToken (String)(Optional): 정상적인 Auth0 Login API 응답값으로 credentials에서 accessToken을 추출
     */
    struct Auth0LoginModel {
        let isSuccessed: Bool
        let accessToken: String?
        
        init(isSuccessed: Bool, accessToken: String? = nil) {
            self.isSuccessed = isSuccessed
            self.accessToken = accessToken
        }
    }
    
    static func appleAuthLogin(_ credential: ASAuthorizationCredential) async -> Auth0LoginModel {
        do {
            if let appleIDCredential = credential as? ASAuthorizationAppleIDCredential {
                // Convert Data -> String
                guard let authorizationCode = appleIDCredential.authorizationCode,
                      let authCode = String(data: authorizationCode, encoding: .utf8) else {
                    print("Problem with the authorizationCode")
                    return Auth0LoginModel(isSuccessed: false)
                }
                
                let result = try await Auth0
                    .authentication()
                    .login(appleAuthorizationCode: authCode, fullName: appleIDCredential.fullName).start()
                
                return Auth0LoginModel(isSuccessed: true, accessToken: result.accessToken)
            } else {
                return Auth0LoginModel(isSuccessed: false)
            }
        } catch {
            print("Exchange Failed")
            return Auth0LoginModel(isSuccessed: false)
        }
    }
    
    /**
     function: Auth0 Login API 호출
     - Parameters
     - type (LoginViewModel.loginType): Auth0 Social Login Type
     - Returns
     - WebAuthLoginModel
     */
    static func kakaoAuthLogin() async -> Auth0LoginModel {
        do {
            let credentials = try await Auth0.webAuth().connection("Kakao-Login").start()
            
            print("로그인 성공: \(String(describing: credentials))")
            print("ID Token: \(String(describing: credentials.idToken))")
            print("Access Token: \(String(describing: credentials.accessToken))")
            
            return Auth0LoginModel(isSuccessed: true, accessToken: credentials.accessToken)
        } catch {
            print("로그인 실패: \(error)")
            
            return Auth0LoginModel(isSuccessed: false)
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
