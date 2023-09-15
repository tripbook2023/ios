//
//  SignupSocialView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/14.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

protocol SignupSocialViewDelegate {
    func didTapKakaoLoginButton() async -> String 
    func didTapAppleLoginButton(_ credential: ASAuthorizationCredential) async
}

struct SignupSocialView: View {
    @StateObject var signupViewModel = SignupViewModel()
    @ObservedObject var viewModel =  SignupSocialViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                Image("TitleLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 134, height: 38)
                Text("내 손안에 특별한 여행북")
                    .font(TBFont.body_4)
                    .foregroundColor(TBColor.grayscale._50)
                
                Spacer().frame(height: 226)
                
                VStack(spacing: 8) {
                    Button(action: {
                        Task {
                            let resultEmail = await self.viewModel.didTapKakaoLoginButton()
                            
                            self.signupViewModel.registerUserEmail(resultEmail)
                        }
                    }) {
                        HStack {
                            Image("Social/KakaoLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            Text("카카오 로그인")
                                .font(TBFont.body_3)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.init(rgb: .init(red: 254, green: 229, blue: 0)))
                        )
                        .foregroundColor(.black)
                    }
                    
                    ZStack {
                        HStack(spacing: 6.47) {
                            Image("Social/AppleLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 13.53191, height: 16.62397)
                            Text("Apple로 로그인")
                                .font(TBFont.body_3)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(.black)
                        .cornerRadius(12)
                        
                        SignInWithAppleButton(
                            onRequest: { request in
                                request.requestedScopes = [.email, .fullName]
                            }, onCompletion: { result in
                                switch result {
                                case .success(let authResults):
                                    print("Apple Login Successful")
                                    Task {
                                        await self.viewModel.didTapAppleLoginButton(authResults.credential)
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .opacity(0.011)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                }.padding(.horizontal, 20)
                
                NavigationLink(isActive: self.$viewModel.goToRootNavigationTrigger, destination: {
                    RootView()
                }, label: {
                    EmptyView()
                })
                NavigationLink(isActive: self.$viewModel.continueNavigationTrigger, destination: {
                    SignupTermsView(self.signupViewModel)
                }, label: {
                    EmptyView()
                })
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            self.viewModel.delegate = self.signupViewModel
        }
    }
}

struct SignupSocialView_Previews: PreviewProvider {
    static var previews: some View {
        SignupSocialView()
    }
}
