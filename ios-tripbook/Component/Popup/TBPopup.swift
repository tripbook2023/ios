//
//  TBPopup.swift
//  ios-tripbook
//
//  Created by 이시원 on 4/15/24.
//

import SwiftUI

struct TBPopup: View {
    enum ViewType {
        case ruide(
            title: String,
            subTitle: String? = nil,
            confirmButtonText: String,
            dismissButtonText: String? = nil,
            didTapConfirmButton: () -> Void,
            didTapDismissButton: () -> Void = {}
        )
        case report(
            postId: Int?,
            onReport: () -> Void = {}
        )
        case memberDelete(
            viewModel: MypageViewModel,
            logoutAction: (() -> Void)?
        )
        case userBlock(
            user: Author?,
            onBlock: () -> Void = {}
        )
    }
    
    @ViewBuilder
    private var popup: some View {
        switch type {
        case .ruide(
            let title,
            let subTitle,
            let confirmButtonText,
            let dismissButtonText,
            let didTapConfirmButton,
            let didTapDismissButton
        ): GuidePopup(
            title: title,
            subTitle: subTitle,
            confirmButtonText: confirmButtonText,
            dismissButtonText: dismissButtonText,
            didTapConfirmButton: {
                didTapConfirmButton()
                type = nil
            },
            didTapDismissButton: {
                didTapDismissButton()
                type = nil
            }
        )
        case .report(let postId, let onReport):
            ReportPopup(
                postId: postId,
                isPresented:
                    Binding(
                        get: { type != nil },
                        set: { if !$0 { type = nil }}
                    ),
                onReport: onReport
            )
        case .memberDelete(let viewModel, let logoutAction):
            MemberDeletePopup(
                viewModel: viewModel,
                isPresented:
                    Binding(
                        get: { type != nil },
                        set: { if !$0 { type = nil }}
                    ),
                logoutAction: logoutAction
            )
        case .userBlock(let user, let onBlock):
            UserBlockPopup(
                user: user,
                isPresented: 
                    Binding(
                        get: { type != nil },
                        set: { if !$0 { type = nil }}
                    ),
                onBlock: onBlock
            )
        case .none: EmptyView()
        }
      
    }
    
    @Binding private var type: ViewType?
    
    init(type: Binding<ViewType?>) {
        self._type = type
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
            popup.shadow(TBShadow._1)
        }
    }
}

struct TBPopup_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                TBPopup(type: .constant(TBPopup.ViewType.ruide(
                    title: "제목",
                    subTitle: "본문",
                    confirmButtonText: "확인",
                    dismissButtonText: "취소",
                    didTapConfirmButton: {},
                    didTapDismissButton: {}
                )))
                TBPopup(type: .constant(TBPopup.ViewType.ruide(
                    title: "제목",
                    confirmButtonText: "확인",
                    didTapConfirmButton: {},
                    didTapDismissButton: {}
                )))
            }
            TBPopup(type: .constant(TBPopup.ViewType.memberDelete(
                viewModel: .init(),
                logoutAction: nil
            )))
            
            TBPopup(type: .constant(TBPopup.ViewType.report(
                postId: nil,
                onReport: {}
            )))
            
            TBPopup(type: .constant(TBPopup.ViewType.userBlock(
                user: nil,
                onBlock: {}
            )))
        }
    }
}
    

