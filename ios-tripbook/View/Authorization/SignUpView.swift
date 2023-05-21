//
//  SignUpView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/25.
//
//  회원가입 (공통뷰)

import SwiftUI



struct SignUpView: View {
    @ObservedObject var viewModel: SignInViewModel
    @State var pageCount: Int = 1
    @State var completeButtonActive: Bool = false
    
    @State var termsLinkIsActive: Bool = false
    @State var nicknameLinkIsActive: Bool = false
    @State var profileImageLinkIsActive: Bool = false
    
    var viewType: SignInViewModel.SignUpViewProperty
    
    var pageTitle: [String] = [
        "서비스 이용 동의해주세요",
        "닉네임을 입력해주세요",
        "프로필 이미지를 등록해주세요"]
    var buttonText: [String] = [
        "확인",
        "닉네임 입력했어요",
        "프로필 이미지 등록했어요"]
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                /// 네비게이션바
                viewModel.loadNavigationBar()
                VStack {
                    switch viewType {
                    case .terms:
                        viewModel.loadTermsView()
                    case .nickname:
                        viewModel.loadNicknameView()
                    case .profileImage:
                        viewModel.loadProfileImageView()
                    }
                }
                .frame(minHeight: 50, maxHeight: .infinity)
                VStack {
                    ZStack {
                        Color(red: 112 / 255, green: 112 / 255, blue: 112 / 255)
                        Text(buttonText[pageCount - 1])
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 75)
                .onTapGesture {
                    print("didTapCompleteButton")
                    nicknameLinkIsActive = viewType == .terms
                    profileImageLinkIsActive = viewType == .nickname
                    print(nicknameLinkIsActive)
                    print(profileImageLinkIsActive)
                }
                //.disabled(completeButtonActive ? false : true)
                
            }
            
//            NavigationLink(destination: Text(""), isActive: $nicknameLinkIsActive) {
//                SignUpView(viewModel: SignInViewModel(), viewType: .nickname)
//            }
//            NavigationLink(destination: Text(""), isActive: $profileImageLinkIsActive) {
//                SignUpView(viewModel: SignInViewModel(), viewType: .profileImage)
//            }
        }
        .onAppear() {
            
        }
        
    }
}

extension SignUpView {
    /**
     메뉴 이동
     > Parameter : 다음 여부(Bool)
     */
    func movePage(next: Bool = true) {
        if next {
            /// 페이지의 끝일경우 리턴
            if pageCount >= 3 {
                return
            }
            pageCount += 1
        } else {
            /// 페이지의 처음일경우 리턴
            if pageCount <= 1 {
                return
            }
            pageCount -= 1
        }
        
        /// 버튼의 상태를 Disable
        // completeButtonActive = false
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignInViewModel(), viewType: .terms)
    }
}
