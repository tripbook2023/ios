//
//  KakaoLoginButtonView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/25.
//

import SwiftUI

struct KakaoLoginButtonView: View {
    var body: some View {
        VStack {
            ZStack {
                Color(red: 254 / 255, green: 229 / 255, blue: 0 / 255).ignoresSafeArea()
                HStack {
                    Image("kakaoSymbol")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                    Text("카카오 로그인")
                        .foregroundColor(.black)
                        .opacity(0.85)
                        .font(.system(size: 20))
                }
            }
        }
    }
}

struct KakaoLoginButtonView_Previews: PreviewProvider {
    static var previews: some View {
        KakaoLoginButtonView()
    }
}
