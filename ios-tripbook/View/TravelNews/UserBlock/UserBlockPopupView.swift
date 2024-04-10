//
//  UserBlockPopupView.swift
//  ios-tripbook
//
//  Created by 이시원 on 4/8/24.
//

import SwiftUI

struct UserBlockPopupView: View {
    @ObservedObject private var viewModel: UserBlockViewModel
    @State private var isSuccessedBlock = false
    @Binding private var isPresented: Bool {
        didSet {
            if isSuccessedBlock {
                viewModel.finishBlocking()
            }
        }
    }
    
    init(
        user: Author?,
        isPresented: Binding<Bool>,
        onBlock: @escaping () -> Void = {}
    ) {
        self._isPresented = isPresented
        self.viewModel = UserBlockViewModel(
            user: user,
            onBlock: onBlock
        )
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Spacer()
                Button(action: {
                    isPresented = false
                }, label: {
                    TBIcon.cancel.iconSize(size: .small)
                        .foregroundStyle(TBColor.grayscale._20)
                })
            }
            .frame(width: 260)
            
            TBAvatar(
                type: .basic,
                size: 34,
                profileImageURL: viewModel.user?.profileUrl
            )
            
            Text(viewModel.user?.name ?? "")
                .multilineTextAlignment(.center)
                .foregroundStyle(TBColor.grayscale._90)
                .font(TBFont.title_4)
            
            Text(isSuccessedBlock ? "해당 사용자가\n차단되었습니다." : "해당 사용자를\n차단하시겠습니까?")
                .multilineTextAlignment(.center)
                .foregroundStyle(TBColor.grayscale._90)
                .font(TBFont.title_3)
            
            if !isSuccessedBlock {
                Text("차단을 진행하면\n아래 활동이 제한됩니다.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(TBColor.grayscale._90)
                    .font(TBFont.caption_2)
                
                HStack(spacing: 2) {
                    TBIcon.check.iconSize(size: .small)
                        .foregroundStyle(TBColor.grayscale._50)
                        .padding(.leading, 8)
                    Text("차단한 사용자가 작성한 전체 게시글")
                        .foregroundStyle(TBColor.grayscale._50)
                        .font(TBFont.title_4)
                        .padding(.vertical, 6)
                        .padding(.trailing, 8)
                }
                .background(TBColor.grayscale._1)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                
                (
                    Text("* 사용자 차단 목록에서 해당 사용자를")
                        .foregroundColor(TBColor.grayscale._40) +
                    Text(" 차단 해제")
                        .foregroundColor(TBColor.primary._50) +
                    Text("하면\n사용자가 작성한 모든 게시글을 확인할 수 있습니다.")
                        .foregroundColor(TBColor.grayscale._40)
                )
                .multilineTextAlignment(.center)
                .font(TBFont.caption_2)
            } else {
                (
                    Text("내 정보 > 사용자 차단 목록")
                        .foregroundColor(TBColor.primary._50) +
                    Text("에서 확인 할 수 있습니다.")
                        .foregroundColor(TBColor.grayscale._90)
                )
                .multilineTextAlignment(.center)
                .font(TBFont.caption_2)
            }
            
            if !isSuccessedBlock {
                HStack {
                    TBButton(
                        type: .customOutline(
                            strokeColor: TBColor.grayscale._50,
                            pressedBackgroundColor:  TBColor.grayscale._5
                        ),
                        size: .small,
                        title: "취소",
                        maxWidth: 126,
                        titleTextColor: TBColor.grayscale._50,
                        isEnabled: .constant(true)
                    ) {
                        isPresented = false
                    }
                    
                    TBButton(
                        type: .filled,
                        size: .small,
                        title: "사용자 차단",
                        maxWidth: 126,
                        isEnabled: .constant(true)
                    ) {
                        Task {
                            do {
                                try await viewModel.requestBlock()
                                await MainActor.run {
                                    isSuccessedBlock = true
                                }
                            } catch {
                                
                            }
                        }
                    }
                }
                .frame(width: 200)
            } else {
                TBButton(
                    type: .customOutline(
                        strokeColor: TBColor.grayscale._50,
                        pressedBackgroundColor:  TBColor.grayscale._5
                    ),
                    size: .small,
                    title: "확인",
                    maxWidth: 126,
                    titleTextColor: TBColor.grayscale._50,
                    isEnabled: .constant(true)
                ) {
                    isPresented = false
                }
                .frame(width: 100)
            }
            
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#if DEBUG
#Preview {
    ZStack {
        Color.black
        UserBlockPopupView(
            user: TravelNewsModel.dummy.author,
            isPresented: .constant(true)
        )
    }
}
#endif
