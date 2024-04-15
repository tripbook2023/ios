//
//  TBPopup.swift
//  ios-tripbook
//
//  Created by DDang on 7/16/23.
//

import SwiftUI

struct GuidePopup: View {
    let title: String
    let subTitle: String?
    let confirmButtonText: String
    let dismissButtonText: String?
    let didTapConfirmButton: () -> Void
    let didTapDismissButton: () -> Void
    
    init(
        title: String,
        subTitle: String? = nil,
        confirmButtonText: String,
        dismissButtonText: String? = nil,
        didTapConfirmButton: @escaping () -> Void,
        didTapDismissButton: @escaping () -> Void = {}
    ) {
        self.title = title
        self.subTitle = subTitle
        self.confirmButtonText = confirmButtonText
        self.dismissButtonText = dismissButtonText
        self.didTapConfirmButton = didTapConfirmButton
        self.didTapDismissButton = didTapDismissButton
    }
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text(title)
                    .font(TBFont.title_3)
                    .foregroundColor(TBColor.grayscale._90)
                
                if let subTitle = subTitle {
                    Text(subTitle)
                        .font(TBFont.body_4)
                        .foregroundColor(TBColor.grayscale._70)
                        .multilineTextAlignment(.center)
                }
            }
            
            HStack(spacing: 8) {
                if let dismissButtonText = dismissButtonText {
                    TBButton(
                        type: .outline,
                        size: .regular,
                        title: dismissButtonText,
                        maxWidth: .infinity,
                        titleTextColor: TBColor.grayscale._60,
                        backgroundColor: TBColor.grayscale._10,
                        isEnabled: .constant(true)
                    ) {
                        didTapDismissButton()
                    }
                }
                
                TBButton(
                    type: .filled,
                    size: .regular,
                    title: confirmButtonText,
                    maxWidth: .infinity,
                    isEnabled: .constant(true)
                ) {
                    didTapConfirmButton()
                }
            }
        }
        .frame(maxWidth: 300)
        .padding(.top, 32)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .background()
        .cornerRadius(12)
    }
}

struct GuidePopup_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                GuidePopup(
                    title: "제목입니다",
                    confirmButtonText: "버튼",
                    didTapConfirmButton: {}
                )
                GuidePopup(
                    title: "제목입니다",
                    confirmButtonText: "버튼",
                    dismissButtonText: "버튼",
                    didTapConfirmButton: {}
                )
            }
            
            VStack {
                GuidePopup(
                    title: "제목입니다",
                    subTitle: "내용입니다\n내용입니다",
                    confirmButtonText: "버튼",
                    didTapConfirmButton: {}
                )
                GuidePopup(
                    title: "제목입니다",
                    subTitle: "내용입니다\n내용입니다",
                    confirmButtonText: "버튼",
                    dismissButtonText: "버튼",
                    didTapConfirmButton: {}
                )
            }
        }
    }
}
