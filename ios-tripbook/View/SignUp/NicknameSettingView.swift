//
//  NicknameSettingView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/05/25.
//

import SwiftUI

struct NicknameSettingView: View, BottomButtonDelegate {
    func didTapBottomButton() {
        viewModel.nicknameLocalVerify(text: fieldNickname)
        if viewModel.stringVerifyNickname == "" {
            isNavigationLink = true
        }
    }
    
    var buttonTitle: String? = "닉네임 만들었어요"
    
    var buttonHeight: CGFloat?
    
    @ObservedObject var viewModel = SignUpViewModel(viewType: .nickname)
    @Environment(\.presentationMode) var presentationMode
    @State var isNavigationLink: Bool = false
    @State var fieldNickname: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                viewModel.customNavigationBar(presentationMode: presentationMode)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 56, trailing: 0))
                
                HStack {
                    TextField("10자 이내 한글 혹은 영문", text: $fieldNickname)
                    if fieldNickname.count > 0 {
                        Button(action: { fieldNickname = "" }) {
                            Image(systemName: "xmark")
                        }
                    }
                }.frame(height: 20)
                
                Rectangle()
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(viewModel.stringVerifyNickname == "" ? .gray : .red)
                    .frame(height: 1)
                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 0, trailing: 0))
                
                if viewModel.stringVerifyNickname.count > 0 {
                    HStack {
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundColor(.red)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 12)
                        Text(viewModel.stringVerifyNickname)
                            .foregroundColor(.red)
                        Spacer()
                    }
                        .frame(maxWidth: .infinity)
                        .frame(height: 12)
                        .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                }
                
                
                Spacer()
                
                /// 바텀버튼
                NavigationLink(destination: ProfileImageSettingView(), isActive: $isNavigationLink) {}
                BottomButton(delegate: self, buttonEnabled: fieldNickname.count > 0)
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
        .navigationBarHidden(true)
    }
}

struct NicknameSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NicknameSettingView()
    }
}
