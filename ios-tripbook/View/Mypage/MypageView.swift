//
//  MypageView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/24.
//

import SwiftUI

import Kingfisher

/**
 View: 내 정보(프로필) 화면
 
 View 구성 요소
 -
 */
struct MypageView: View {
    private var deviceWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    @StateObject private var viewModel = MypageViewModel()
    private let logoutAction: (() -> Void)?
    
    init(logoutAction: (() -> Void)? = nil) {
        self.logoutAction = logoutAction
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    TBAppBar(
                        title: "마이페이지"
                    )
                    .padding(.horizontal, 20)
                    HStack {
                        KFImage(viewModel.userInfo?.profileImageURL)
                            .placeholder {
                                Image("DefaultProfileImage")
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(TBColor.grayscale._10, lineWidth: 0.57)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.userInfo?.info?.name ?? "")
                                .foregroundColor(.white)
                                .font(TBFont.title_2)
                            Text(viewModel.userInfo?.info?.email ?? "")
                                .foregroundColor(.white)
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
                        viewModel.isPresentInquiryView = true
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
                            viewModel.isShowLogOutPopup.toggle()
                        } label: {
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(TBColor.grayscale._50, lineWidth: 1)
                                .foregroundColor(.white)
                                .overlay(
                                    Text("로그아웃")
                                        .font(TBFont.body_4)
                                        .foregroundColor(TBColor.grayscale._50)
                                )
                            
                            
                        }
                        .frame(width: 335, height: 32)
                        .padding(.top, 24)
                        .padding(.bottom, 12)
                        
                        HStack {
                            Text("회원탈퇴")
                                .font(TBFont.caption_1)
                                .foregroundColor(TBColor.grayscale._40)
                                .underline()
                                .onTapGesture {
                                    viewModel.isShowMemberDeletePopup = true
                                }
                            Spacer()
                            Text("버전정보 v1.0.0")
                                .font(TBFont.caption_1)
                                .foregroundColor(TBColor.grayscale._40)
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer()
                    }
                    .frame(width: deviceWidth)
                    .background(TBColor.grayscale._1)
                }
                VStack {
                    Spacer()
                    ZStack {
                        TBPopup(
                            title: "로그아웃하시겠습니까?",
                            confirmButtonText: "로그아웃",
                            dismissButtonText: "취소",
                            didTapConfirmButton: {
                                Task {
                                    await Auth0Service.webAuthLogout {
                                        self.viewModel.deleteToken()
                                        (self.logoutAction ?? {})()
                                    }
                                }
                            },
                            didTapDismissButton: {
                                viewModel.isShowLogOutPopup.toggle()
                            }
                        )
                        .opacity(viewModel.isShowLogOutPopup ? 1 : 0)
                        
                        MemberDeletePopup(
                            viewModel: viewModel,
                            isPresented: $viewModel.isShowMemberDeletePopup,
                            logoutAction: logoutAction
                        )
                        .opacity(viewModel.isShowMemberDeletePopup ? 1 : 0)
                    }
                    Spacer()
                }
                .frame(width: deviceWidth)
                .background(.black.opacity(0.6))
                .opacity(viewModel.isShowLogOutPopup || viewModel.isShowMemberDeletePopup ? 1 : 0)
            }
            .fullScreenCover(isPresented: $viewModel.isPresentInquiryView, content: {
                InquiryView()
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView()
    }
}
