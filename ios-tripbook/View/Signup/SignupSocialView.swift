//
//  SignupSocialView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/14.
//

import SwiftUI
import TBUtil

protocol SignupSocialViewDelegate {
    func didTapSocialLoginButton(_ type: SignupViewModel.SocialLoginMethod, completion: @escaping (String) -> Void)
}

struct SignupSocialView: View {
    @StateObject var signupViewModel = SignupViewModel()
    @ObservedObject var viewModel =  SignupSocialViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                Text("Logo")
                    .frame(width: 134, height: 38)
                    .background(TBColor.grayscale.levels[10])
                    .foregroundColor(TBColor.grayscale.levels[0])
                Text("내 손안에 특별한 여행북")
                    .font(TBFont.body_3)
                    .foregroundColor(TBColor.grayscale.levels[6])
                
                Spacer().frame(height: 226)
                
                VStack(spacing: 8) {
                    Button(action: {
                        self.viewModel.didTapSocialLoginButton(.KAKAO) { email in
                            self.signupViewModel.registerUserEmail(email)
                        }
                    }) {
                        HStack(spacing: 0.89) {
                            Color.black.frame(width: 21.77, height: 20)
                            Text("카카오 로그인")
                                .font(TBFont.body_2)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color(red: 254 / 255, green: 229 / 255, blue: 0 / 255))
                    )
                    .foregroundColor(TBColor.grayscale.levels[10])
                    
                    Button(action: {
                        self.viewModel.didTapSocialLoginButton(.APPLE) { email in
                            self.signupViewModel.registerUserEmail(email)
                        }
                    }) {
                        HStack(spacing: 6.47) {
                            Color.white.frame(width: 13.53, height: 16.62)
                            Text("Apple로 로그인")
                                .font(TBFont.body_2)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(TBColor.grayscale.levels[10])
                    )
                    .foregroundColor(TBColor.grayscale.levels[0])
                }.padding(.horizontal, 20)
                
                NavigationLink(isActive: self.$viewModel.navigationTrigger, destination: {
                    SignupTermsView(self.signupViewModel)
                }, label: {
                    EmptyView()
                })
            }
        }
    }
}

struct SignupSocialView_Previews: PreviewProvider {
    static var previews: some View {
        SignupSocialView().configureFont()
    }
}
