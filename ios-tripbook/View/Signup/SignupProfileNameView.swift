//
//  SignupNicknameView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/14.
//

import SwiftUI

protocol SignupProfileNameViewDelegate {
    func onChangedNicknameTextField()
    func onSubmittedNicknameTextField()
    func didTapDoneButton()
}

struct SignupProfileNameView: View {
    @ObservedObject var signupViewModel: SignupViewModel
    @ObservedObject var viewModel = SignupProfileNameViewModel()
    
    @FocusState var isFocused: Bool
    @Environment(\.presentationMode) var presentationMode
    
    init(_ signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TBAppBar() {
                self.presentationMode.wrappedValue.dismiss()
            }.padding(.bottom, 40)
            
            Text("멋진 여행 기록을 위해\n닉네임을 입력해주세요")
                .font(TBFont.heading_1)
                .padding(.bottom, 42)
            
            TBTextField(
                title: "10자 이내 한글, 영문, 숫자 입력",
                text: self.$viewModel.nicknameText,
                isValid: Binding(get: {
                    return self.viewModel.nicknameTextState == .None
                }, set: {_ in}),
                warningMessage: Binding(get: {
                    return self.viewModel.nicknameTextState.getWarningMessage()
                }, set: {_ in})
            ) {
                self.viewModel.onSubmittedNicknameTextField()
            }
            .submitLabel(.done)
            .focused(self.$isFocused)
            .onChange(of: self.viewModel.nicknameText) { _ in
                self.viewModel.onChangedNicknameTextField()
            }
            
            Spacer()
            
            TBPrimaryButton(
                title: "닉네임 만들었어요",
                isEnabled: Binding(get: {
                    return !self.viewModel.nicknameText.isEmpty && self.viewModel.nicknameTextState == .None
                }, set: {_ in})
            ) {
                self.signupViewModel.registerUserName(self.viewModel.nicknameText)
                self.viewModel.didTapDoneButton()
            }.padding(.bottom, 12)
        }
        .navigationDestination(isPresented: $viewModel.navigationTrigger, destination: {
            SignupProfileImageView(self.signupViewModel)
        })
        .padding(.horizontal, 20)
        .navigationBarHidden(true)
        .background(
            Color.white.onTapGesture {
                self.isFocused = false
            }
        )
    }
}

struct SignupNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        SignupProfileNameView(SignupViewModel())
    }
}
