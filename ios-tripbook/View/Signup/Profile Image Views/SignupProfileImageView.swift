//
//  SignupProfileImageView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/14.
//

import SwiftUI
import TBComponent
import TBUtil

protocol SignupProfileImageViewDelegate {
    func didTapImageButton()
    func didTapSkipButton()
    func didTapDoneButton()
}

struct SignupProfileImageView: View {
    @ObservedObject var signupViewModel: SignupViewModel
    @ObservedObject var viewModel = SignupProfileImageViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    init(_ signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TBAppBar() {
                    self.presentationMode.wrappedValue.dismiss()
                }.padding(.bottom, 40)
                
                Text("멋진 여행 기록을 위해\n프로필 이미지를 등록해주세요")
                    .font(TBFont.heading_1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 56)
                
                Button(action: {
                    self.viewModel.didTapImageButton()
                }) {
                    if let profileImage = self.viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 140)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(TBColor.grayscale.levels[2], lineWidth: 1)
                            )
                    } else {
                        TBIcon.picture.iconSize(size: .big)
                            .frame(width: 140, height: 140)
                            .background(TBColor.grayscale.levels[1])
                            .foregroundColor(TBColor.grayscale.levels[9])
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(TBColor.grayscale.levels[2], lineWidth: 1)
                            )
                    }
                }
                
                Text(self.signupViewModel.userData.name)
                    .font(TBFont.body_1)
                    .padding(.top, 16)
                
                Spacer()
                
                Button(action: {
                    self.viewModel.didTapSkipButton()
                }) {
                    Text("다음에 할게요")
                        .font(TBFont.caption_1)
                }
                .foregroundColor(TBColor.grayscale.levels[6])
                .padding(.bottom, 10)
                
                TBPrimaryButton(
                    title: "이미지 등록했어요",
                    isEnabled: Binding(get: {
                        return self.viewModel.profileImage != nil
                    }, set: {_ in})
                ) {
                    self.signupViewModel.registerUserProfileImage(self.viewModel.profileImage!)
                    self.viewModel.didTapDoneButton()
                }.padding(.bottom, 16)
                
                NavigationLink(
                    isActive: self.$viewModel.navigationTrigger,
                    destination: {
                        SignupProfileInfoView(self.signupViewModel)
                    },
                    label: {
                        EmptyView()
                    }
                )
            }.padding(.horizontal, 20)
            
            SignupProfileImageSelectOptionView(delgate: self.viewModel)
                .opacity(self.viewModel.isShowOptionView ? 1 : 0)
        }
        .sheet(isPresented: self.$viewModel.isNavigateImagePickerView) {
            SignupProfileImagePickerView(image: self.$viewModel.profileImage, isPresented: self.$viewModel.isNavigateImagePickerView)
                .navigationBarHidden(true)
        }
        .sheet(isPresented: self.$viewModel.isNavigateCameraView) {
            SignupProfileImagePickerView(sourceType: .camera, image: self.$viewModel.profileImage, isPresented: self.$viewModel.isNavigateCameraView)
                .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct SignupProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        SignupProfileImageView(SignupViewModel())
            .configureFont()
    }
}
