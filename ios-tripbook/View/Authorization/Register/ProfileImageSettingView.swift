//
//  ProfileImageSettingView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/25.
//
//  회원가입 진행3 (프로필 이미지 설정)

import SwiftUI

struct ProfileImageSettingView: View {
    @State var inputNickname: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: "app.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .border(.black, width: 3)
                .clipShape(Circle())
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                .onTapGesture {
                    selectProfileImage()
                }
            
            TextField("닉네임", text: $inputNickname)
                .multilineTextAlignment(.center)
                .font(.bold(.title)())
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            Divider()
                .background(Color.black)
            
            Spacer()
            
            Button("다음에 등록할게요", action: {})
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
        }.padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
    }
}

extension ProfileImageSettingView {
    /**
     프로필 이미지 선택
     > 프로필 이미지를 선택할 뷰로 이동합니다.
     */
    func selectProfileImage() {
        print("Tapped Profile Image")
    }
}

struct ProfileImageSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageSettingView()
    }
}
