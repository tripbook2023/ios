//
//  EditProfileView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/11/03.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocus: Bool
    var body: some View {
        VStack(spacing: 40) {
            TBAppBar(title: "프로필 수정") {
                dismiss()
            }
            
            
            ZStack(alignment: .bottom) {
                Image("DefaultProfileImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(TBColor.grayscale._10, lineWidth: 0.57)
                    )
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        TBIcon.cameraFull.iconSize(size: .small)
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                            .background(.white)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(TBColor.grayscale._10, lineWidth: 0.5)
                                    
                            )
                    }
                }
                .frame(width: 80)
            }
            .padding(.top, 18)
            TBTextField(
                title: "10자 이내 한글, 영문, 숫자 입력",
                text: .constant("safari"),
                isValid: .constant(false),
                warningMessage: .constant("xxx"),
                onSubmitEvent: {
                    
                }
            )
            .focused($isFocus)
            
            
            Spacer()
            TBPrimaryButton(title: "확인", isEnabled: .constant(true))
                .padding(.vertical, 18)
        }
        .padding(.horizontal, 20)
        .navigationBarHidden(true)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
