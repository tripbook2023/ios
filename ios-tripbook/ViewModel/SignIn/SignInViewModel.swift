//
//  SignInViewModel.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/05/13.
//

import SwiftUI


class SignInViewModel: ObservableObject {
    
    /**
     뷰타입 명시
     coder : 박상현
     */
    enum SignUpViewProperty {
        /// 약관동의
        case terms
        
        /// 닉네임설정
        case nickname
        
        /// 프로필 이미지 설정
        case profileImage
    }
    
    
}

/**
 SignInViewModel Extension: Layout
 > 레이아웃 생성을 관리하는 Extension
 */
extension SignInViewModel {

    /**
     뷰타입에 따른 뷰 설정
     > 네비게이션 타이틀 설정 및 반환되는 뷰 설정
     - Returns: View
     */
    @ViewBuilder
    func loadView(type: SignUpViewProperty) -> some View {
        switch type {
        case .terms:
            //navigationTitle = "서비스 약관 동의"
            loadTermsView()
        case .nickname:
            loadNicknameView()
        case .profileImage:
            loadProfileImageView()
        }
    }
    
    /**
     네비게이션바
     > 뷰타입에 따른 네비게이션바 설정
     - Returns: View(CustomNavigationBar)
     */
    func loadNavigationBar() -> some View {
        return VStack(alignment: .leading) {
            Image(systemName: "chevron.backward")
                .resizable()
                .aspectRatio(0.7, contentMode: .fill)
                .clipped()
                .foregroundColor(.black)
                .frame(width: 15, height: 15)
                .onTapGesture {
                    
                }
            
            Spacer()
            
            Text("Label")
                .font(.system(size: 25, weight: .bold))
        }
        .padding()
        .frame(minWidth: 50, maxWidth: .infinity, minHeight: 120, maxHeight: 120, alignment: .leading)
    }
    
    /**
     약관 동의 뷰 반환
     - Returns: View
     */
    func loadTermsView() -> some View {
        return VStack(alignment: .leading) {
            Label {
                Text("전체동의")
                    .font(.system(size: 17))
            } icon: {
                Image(systemName: "checkmark.square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
            }
            
            TermListView(termType: 1)

            TermListView(termType: 2)

            TermListView(termType: 3)
            
            Spacer()
        }
        .padding()
    }
    
    
    /**
     닉네임 설정 뷰 반환
     - Returns: Views
     */
    func loadNicknameView() -> some View {
        return NicknameSettingView()
    }
    
    /**
     프로필 이미지 설정 뷰 반환
     - Returns:Views
     */
    func loadProfileImageView() -> some View {
        return ProfileImageSettingView()
    }
}
