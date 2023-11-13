//
//  MypageView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/24.
//

import SwiftUI

/**
 View: 내 정보(프로필) 화면
 
 View 구성 요소
 -
 */
struct MypageView: View {
    var deviceWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    var body: some View {
        VStack(spacing: 0) {
            TBAppBar(
                title: "마이페이지",
                rightItem:  {
                    Button {
                        
                    } label: {
                        TBIcon.bell.iconSize(size: .medium)
                    }
                    .foregroundColor(.black)
                }
            )
            .padding(.horizontal, 20)
            HStack {
                Image("DefaultProfileImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(TBColor.grayscale._10, lineWidth: 0.57)
                    )
                
                VStack(alignment: .leading) {
                    Text("홍길동")
                        .foregroundColor(.white)
                        .font(TBFont.title_2)
                    Text("sss@ssss.com")
                        .tint(.white)
                        .font(TBFont.caption_1)
                }
                Spacer()
                NavigationLink {
                    EditProfileView()
                } label: {
                    TBIcon.setting.iconSize(size: .medium)
                        .foregroundColor(.white)
                }

            }
            .padding(.horizontal, 20)
            .frame(width: deviceWidth, height: 128)
            .background(TBColor.primary._50)
            
            Button {
                //1:1 문의 로직
            } label: {
                HStack {
                    Text("1:1 문의")
                        .foregroundColor(TBColor.grayscale._90)
                    Spacer()
                    TBIcon.next.iconSize(size: .medium)
                        .foregroundColor(TBColor.grayscale._50)
                }
                .padding(.vertical, 16)
                .frame(width: deviceWidth - 40)
            }
            Divider()
                .background(TBColor.grayscale._5)
            VStack {
                Button {
                    //로그아웃 로직
                    
                } label: {
                    RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(TBColor.grayscale._50, lineWidth: 1)
                        .foregroundColor(.white)
                        .overlay(
                            Text("로그아웃")
                                .font(TBFont.body_4)
                        )
                        
                        
                }
                .frame(width: 335, height: 32)
                .padding(.top, 24)
                .padding(.bottom, 12)

                Text("버전정보 v1.0.0")
                    .font(TBFont.caption_1)
                    .foregroundColor(TBColor.grayscale._40)
                Spacer()
            }
            .frame(width: deviceWidth)
            .background(TBColor.grayscale._1)
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView()
    }
}
