//
//  MemberDeletePopup.swift
//  ios-tripbook
//
//  Created by 이시원 on 3/8/24.
//

import SwiftUI
import Combine

struct MemberDeletePopup: View {
    @ObservedObject private var viewModel: MypageViewModel
    @State private var anyCancellable = Set<AnyCancellable>()
    @FocusState var isFocused: Bool
    @Binding private var isPresented: Bool
    @State private var isAppear: Bool = false
    @State private var isDeleteSuccess = false
    private let logoutAction: (() -> Void)?
    
    init(
        viewModel: MypageViewModel,
        isPresented: Binding<Bool>,
        logoutAction: (() -> Void)?
    ) {
        self.viewModel = viewModel
        self._isPresented = isPresented
        self.logoutAction = logoutAction
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Spacer()
                Button(action: {
                    isFocused = false
                    isPresented = false
                    viewModel.deleteName = ""
                }, label: {
                    TBIcon.cancel.iconSize(size: .small)
                        .foregroundStyle(TBColor.grayscale._20)
                })
            }
            .frame(width: 260)
            
            if !isDeleteSuccess {
                VStack {
                    Text("회원 탈퇴를 진행하시면\n기존에 작성된 게시글이 모두 삭제됩니다.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(TBColor.grayscale._90)
                        .font(TBFont.title_3)
                    
                    Text("회원탈퇴를 진행하시려면 닉네임을 임력해주세요.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(TBColor.grayscale._40)
                        .font(TBFont.caption_1)

                }
                
                VStack() {
                    TBTextField(
                        title: "닉네임 입력",
                        text: $viewModel.deleteName,
                        isFocused: _isFocused,
                        isValid: Binding(
                            get: { self.viewModel.warningMessage == nil },
                            set: { _ in }
                        ),
                        warningMessage: $viewModel.warningMessage,
                        onSubmitEvent: {}
                    )
                    Spacer()
                }.frame(width: 260, height: 83)
                
                HStack {
                    TBButton(
                        type: .customOutline(
                            strokeColor: TBColor.grayscale._50,
                            pressedBackgroundColor:  TBColor.grayscale._5
                        ),
                        size: .regular,
                        title: "탈퇴 진행",
                        maxWidth: 126,
                        titleTextColor: TBColor.grayscale._50,
                        isEnabled: Binding(
                            get: { self.viewModel.warningMessage == nil },
                            set: { _ in }
                        )
                    ) {
                        Task {
                            await viewModel.deleteMember {
                                isDeleteSuccess = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    (logoutAction ?? {})()
                                }
                            }
                        }
                    }
                    
                    TBButton(
                        type: .filled,
                        size: .regular,
                        title: "탈퇴 취소",
                        maxWidth: 126,
                        isEnabled: .constant(true)
                    ) {
                        isFocused = false
                        isPresented = false
                        viewModel.deleteName = ""
                    }
                }
                .frame(width: 260)
            } else {
                VStack(spacing: 12) {
                    Text("[\(viewModel.deleteName)] 님의 회원탈퇴가\n정상적으로 처리되었습니다.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(TBColor.grayscale._90)
                        .font(TBFont.title_3)
                    
                    Text("트립북을 이용해주셔서 감사합니다.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(TBColor.grayscale._40)
                        .font(TBFont.caption_1)
                }
                .frame(height: 200)
            }
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onAppear {
            if !isAppear {
                bind()
                isAppear = true
            }
        }
    }
}

extension MemberDeletePopup {
    private func bind() {
        viewModel.$deleteName
            .sink { _ in
                self.viewModel.checkValidationNickname()
            }
            .store(in: &anyCancellable)
    }
}

#Preview {
    ZStack {
        Color.black
        MemberDeletePopup(
            viewModel: .init(),
            isPresented: .constant(true),
            logoutAction: nil
        )
    }
}
