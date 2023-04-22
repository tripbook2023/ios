//
//  LoginView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/21.
//

import SwiftUI
import Auth0

struct LoginView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    var body: some View {
        if loginViewModel.isLoggedIn {
            VStack {
                Text("로그인 상태 : O")
                Text("AccessToken: \(loginViewModel.accessToken)")
                Button("로그아웃", action: {
                    loginViewModel.logout()
                })
            }
        } else {
            VStack {
                Text("로그인 상태 : X")
                Button("로그인", action: {
                    loginViewModel.login(type: .apple)
                })
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
