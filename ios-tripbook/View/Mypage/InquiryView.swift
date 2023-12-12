//
//  InquiryView.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/20/23.
//

import SwiftUI

struct InquiryView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    TBIcon.cancel.iconSize(size: .medium)
                })
                .foregroundStyle(TBColor.grayscale._90)
                Spacer()
            }
            .padding(.horizontal ,20)
            Spacer()
            VStack(spacing: 10) {
                Text("서비스에 대한 궁금한 점이나 의견이 있으신가요?")
                    .font(TBFont.body_4)
                    .foregroundStyle(TBColor.grayscale._90)
                Text("문의사항에 대한 답변은 2-3일 정도 소요될 수 있습니다.")
                    .font(TBFont.caption_1)
                    .foregroundStyle(TBColor.grayscale._50)
            }
            TBPrimaryButton(title: "의견 보내기", isEnabled: .constant(true)) {
                UIApplication.shared.open(.init(string: "https://docs.google.com/forms/d/12EdphtlVAt3doOG7ns3DElvDmW3XQA9tkBTQ2tBITyI/viewform?edit_requested=true")!)
                dismiss()
            }.frame(width: 89)
            Spacer()
        }
    }
}

//#Preview {
//    InquiryView()
//}
