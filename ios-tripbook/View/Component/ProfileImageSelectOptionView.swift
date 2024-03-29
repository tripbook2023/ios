//
//  ProfileImageSelectOptionView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/17.
//

import SwiftUI

protocol SignupProfileImageSelectOptionViewDelegate: AnyObject {
    func didTapCancelButton()
    func didTapSelectPhotoButton()
    func didTapCameraButton()
    func didTapUseDefaultImageButton()
}

struct ProfileImageSelectOptionView: View {
    weak var delgate: SignupProfileImageSelectOptionViewDelegate?
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Spacer()
                
                VStack(spacing: 0) {
                    Button(action: {
                        self.delgate?.didTapSelectPhotoButton()
                    }) {
                        ZStack {
                            Rectangle()
                                .frame(height: 56)
                                .foregroundColor(TBColor.grayscale._10)
                            
                            Text("앨범에서 사진 선택")
                                .font(TBFont.body_4)
                                .foregroundColor(TBColor.grayscale._90)
                        }
                    }
                    
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(TBColor.grayscale._20)
                    
                    Button(action: {
                        self.delgate?.didTapCameraButton()
                    }) {
                        ZStack {
                            Rectangle()
                                .frame(height: 56)
                                .foregroundColor(TBColor.grayscale._10)
                            
                            Text("지금 사진 촬영")
                                .font(TBFont.body_4)
                                .foregroundColor(TBColor.grayscale._90)
                        }
                    }
                    
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(TBColor.grayscale._20)
                    
                    Button(action: {
                        self.delgate?.didTapUseDefaultImageButton()
                    }) {
                        ZStack {
                            Rectangle()
                                .frame(height: 56)
                                .foregroundColor(TBColor.grayscale._10)
                            
                            Text("기본 이미지 사용")
                                .font(TBFont.body_4)
                                .foregroundColor(TBColor.grayscale._90)
                        }
                    }
                }.clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button(action: {
                    self.delgate?.didTapCancelButton()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 19)
                            .frame(height: 38)
                            .foregroundColor(TBColor.grayscale._90)
                        
                        Text("취소")
                            .font(TBFont.caption_1)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
    }
}

struct ProfileImageSelectOptionView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageSelectOptionView(delgate: nil)
    }
}
