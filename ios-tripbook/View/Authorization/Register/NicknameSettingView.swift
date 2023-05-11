//
//  NicknameSettingView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/25.
//
//  회원가입 진행2 (닉네임 설정)

import SwiftUI

struct NicknameSettingView: View {
    @State var inputNickname: String = ""
    var body: some View {
        VStack{
            TextField("", text: $inputNickname)
            Divider()
                .background(Color.black)
            Text("한글, 영어, 숫자를 입력해주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding()
    }
}

struct NicknameSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NicknameSettingView()
    }
}
