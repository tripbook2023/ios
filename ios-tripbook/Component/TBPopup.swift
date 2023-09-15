//
//  TBPopup.swift
//  ios-tripbook
//
//  Created by DDang on 7/16/23.
//

import SwiftUI

struct TBPopup: View {
    let title: String
    let content: String?
    let confirmButtonText: String
    let dismissButtonText: String?
    let didTapConfirmButton: () -> Void
    let didTapDismissButton: (() -> Void)?
    
    init(title: String, content: String? = nil, confirmButtonText: String, dismissButtonText: String? = nil, didTapConfirmButton: @escaping () -> Void, didTapDismissButton: (() -> Void)? = nil) {
        self.title = title
        self.content = content
        self.confirmButtonText = confirmButtonText
        self.dismissButtonText = dismissButtonText
        self.didTapConfirmButton = didTapConfirmButton
        self.didTapDismissButton = didTapDismissButton
    }
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text(self.title)
                    .font(TBFont.title_3)
                    .foregroundColor(TBColor.grayscale._90)
                
                if let content = self.content {
                    Text(content)
                        .font(TBFont.body_4)
                        .foregroundColor(TBColor.grayscale._70)
                }
            }
            
            HStack(spacing: 8) {
                if let dismissButtonText = self.dismissButtonText {
                    TBButton(type: .outline, size: .regular, title: dismissButtonText, maxWidth: .infinity, titleTextColor: TBColor.grayscale._60, backgroundColor: TBColor.grayscale._10, isEnabled: .constant(true)) {
                        self.didTapDismissButton?()
                    }
                }
                
                TBButton(type: .filled, size: .regular, title: self.confirmButtonText, maxWidth: .infinity, isEnabled: .constant(true)) {
                    self.didTapConfirmButton()
                }
            }
        }
        .frame(maxWidth: 300)
        .padding(.top, 32)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .background()
        .cornerRadius(12)
        .shadow(TBShadow._1)
    }
}

struct TBPopup_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                TBPopup(title: "제목입니다", confirmButtonText: "버튼", didTapConfirmButton: {})
                TBPopup(title: "제목입니다", confirmButtonText: "버튼", dismissButtonText: "버튼", didTapConfirmButton: {})
            }
            
            VStack {
                TBPopup(title: "제목입니다", content: "내용입니다\n내용입니다", confirmButtonText: "버튼", didTapConfirmButton: {})
                TBPopup(title: "제목입니다", content: "내용입니다\n내용입니다", confirmButtonText: "버튼", dismissButtonText: "버튼", didTapConfirmButton: {})
            }
        }
    }
}
