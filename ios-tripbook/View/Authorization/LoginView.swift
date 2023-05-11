//
//  LoginView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/25.
//
//  로그인 기본화면

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    var body: some View {
        VStack {
            /// 타이틀
            VStack {
                Text("내 손안의")
                Text("특별한 여행북")
            }
            .foregroundColor(.orange)
            .font(.headline)
            
            /// 로고 이미지
            Image(uiImage: .add)
                .resizable()
                .frame(width: 68, height: 76)
            
            /// 소셜 로그인 버튼
            VStack {
                /// Sign In With Apple
                SignInWithAppleButton(
                    .signIn,
                    onRequest: siwaOnRequest,
                    onCompletion: siwaOnCompletion
                )
                .frame(height: 57)
                
                /// 카카오 로그인 버튼
                KakaoLoginButtonView()
                    .onTapGesture {
                        print("tapped Kakao Login Button")
                    }
                    .frame(height: 57)
                    .cornerRadius(7)
            }
            .padding(EdgeInsets(top: 50, leading: 38, bottom: 10, trailing: 38))
            
        }
    }
}

extension LoginView {
    /// 애플 로그인 onRequest
    func siwaOnRequest(_ request: ASAuthorizationAppleIDRequest) {
        
    }
    
    /// 애플 로그인 onCompletion
    func siwaOnCompletion(_ authResult: Result<ASAuthorization, Error>) {
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
