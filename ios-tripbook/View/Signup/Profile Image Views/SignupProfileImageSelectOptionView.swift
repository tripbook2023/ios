//
//  SignupProfileImageSelectOptionView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/17.
//

import SwiftUI
import TBUtil

protocol SignupProfileImageSelectOptionViewDelegate {
    func didTapCancelButton()
    func didTapSelectPhotoButton()
    func didTapCameraButton()
    func didTapUseDefaultImageButton()
}

struct SignupProfileImageSelectOptionView: View {
    var delgate: SignupProfileImageSelectOptionViewDelegate
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Spacer()
                
                VStack(spacing: 0) {
                    Button(action: {
                        self.delgate.didTapSelectPhotoButton()
                    }) {
                        ZStack {
                            Rectangle()
                                .frame(height: 56)
                                .foregroundColor(TBColor.grayscale.levels[2])
                            
                            Text("앨범에서 사진 선택")
                                .font(TBFont.body_3)
                                .foregroundColor(TBColor.grayscale.levels[10])
                        }
                    }
                    
                    Divider()
                        .foregroundColor(TBColor.grayscale.levels[3])
                    
                    Button(action: {
                        self.delgate.didTapCameraButton()
                    }) {
                        ZStack {
                            Rectangle()
                                .frame(height: 56)
                                .foregroundColor(TBColor.grayscale.levels[2])
                            
                            Text("지금 사진 촬영")
                                .font(TBFont.body_3)
                                .foregroundColor(TBColor.grayscale.levels[10])
                        }
                    }
                    
                    Divider()
                        .foregroundColor(TBColor.grayscale.levels[3])
                    
                    Button(action: {
                        self.delgate.didTapUseDefaultImageButton()
                    }) {
                        ZStack {
                            Rectangle()
                                .frame(height: 56)
                                .foregroundColor(TBColor.grayscale.levels[2])
                            
                            Text("기본 이미지 사용")
                                .font(TBFont.body_3)
                                .foregroundColor(TBColor.grayscale.levels[10])
                        }
                    }
                }.clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button(action: {
                    self.delgate.didTapCancelButton()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 19)
                            .frame(height: 38)
                            .foregroundColor(TBColor.grayscale.levels[10])
                        
                        Text("취소")
                            .font(TBFont.caption_1)
                            .foregroundColor(TBColor.grayscale.levels[0])
                    }
                }
            }.padding(.horizontal, 20)
        }
    }
}

struct SignupProfileImageSelectOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SignupProfileImageSelectOptionView(delgate: SignupProfileImageViewModel())
    }
}
