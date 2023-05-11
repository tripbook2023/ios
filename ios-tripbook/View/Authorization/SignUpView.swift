//
//  SignUpView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/25.
//
//  회원가입 (공통뷰)

import SwiftUI

struct SignUpView: View {
    @State var pageCount: Int = 1
    @State var completeButtonActive: Bool = false
    var pageTitle: [String] = [
        "서비스 이용 동의해주세요",
        "닉네임을 입력해주세요",
        "프로필 이미지를 등록해주세요"]
    var buttonText: [String] = [
        "확인",
        "닉네임 입력했어요",
        "프로필 이미지 등록했어요"]
    
    
    
    var body: some View {
        VStack {
            /// 네비게이션바
            VStack(alignment: .leading) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .aspectRatio(0.7, contentMode: .fill)
                    .clipped()
                    .foregroundColor(.black)
                    .frame(width: 15, height: 15)
                    .onTapGesture {
                        movePage(next: false)
                    }
                
                Spacer()
                
                Text(pageTitle[pageCount - 1])
                    .font(.system(size: 25, weight: .bold))
            }
            .padding()
            .frame(minWidth: 50, maxWidth: .infinity, minHeight: 120, maxHeight: 120, alignment: .leading)
            
            VStack {
                switch pageCount {
                case 1:
                    TermsView()
                case 2:
                    NicknameSettingView()
                case 3:
                    ProfileImageSettingView()
                default:
                    TermsView()
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
                movePage()
            }
            //.disabled(completeButtonActive ? false : true)
            
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
        SignUpView()
    }
}
