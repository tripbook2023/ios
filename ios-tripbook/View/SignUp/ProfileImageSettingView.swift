//
//  ProfileImageSettingView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/05/25.
//

import SwiftUI

struct ProfileImageSettingView: View, BottomButtonDelegate {
    func didTapBottomButton() {
        
    }
    
    var buttonTitle: String? = "이미지 등록했어요"
    
    var buttonHeight: CGFloat?
    
    @ObservedObject var viewModel = SignUpViewModel(viewType: .profileImage)
    @Environment(\.presentationMode) var presentationMode
    
    @State var isVisibleActionSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if isVisibleActionSheet {
                    CustomActionSheet(parentView: self)
                        .zIndex(1)
                        .ignoresSafeArea()
                }
                VStack {
                    viewModel.customNavigationBar(presentationMode: presentationMode)
                    
                    Image(systemName: "photo")
                        .resizable()
                        .renderingMode(.original)
                        .background(Color(.gray))
                        .clipShape(Circle())
                        .frame(width: 140, height: 140)
                        .padding(EdgeInsets(top: 88, leading: 0, bottom: 0, trailing: 0))
                        .onTapGesture {
                            isVisibleActionSheet.toggle()
                        }
                    Text("닉네임 표시")
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                    
                    Button(action: {  }, label: {
                        Text("다음에할게요")
                    })
                    BottomButton(delegate: self, buttonEnabled: false)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
        }
        .navigationBarHidden(true)
    }
}

struct CustomActionSheet: View {
    var parentView: ProfileImageSettingView
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
            
            VStack {
                Spacer()
                
                VStack {
                    Button(action: { }, label: {
                        Text("앨범에서 사진 선택")
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    })
                    
                    Button(action: { }, label: {
                        Text("앨범에서 사진 선택")
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    })
                    Button(action: { }, label: {
                        Text("앨범에서 사진 선택")
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    })
                }
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                
                Button(action: {
                    parentView.isVisibleActionSheet = false
                }, label: {
                    HStack {
                        Text("취소")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 38)
                    .background(RoundedRectangle(cornerRadius: 19)
                        .foregroundColor(.black))
                })
                .foregroundColor(.white)
                .frame(height: 38)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 48, trailing: 20))
            }
        }
    }
}

struct ProfileImageSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageSettingView()
    }
}
