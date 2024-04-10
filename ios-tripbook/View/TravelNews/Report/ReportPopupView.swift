//
//  ReportPopupView.swift
//  ios-tripbook
//
//  Created by 이시원 on 1/30/24.
//

import SwiftUI

struct ReportPopupView: View {
    @StateObject private var viewModel = ReportViewModel()
    @Binding private var isPresented: Bool
    @FocusState private var isFocus: Bool
    private var postId: Int?
    private var onReport: () -> Void
    
    init(
        postId: Int?,
        isPresented: Binding<Bool>,
        onReport: @escaping () -> Void = {}
    ) {
        self.postId = postId
        self._isPresented = isPresented
        self.onReport = onReport
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Spacer()
                Button(action: {
                    viewModel.content = ""
                    isFocus = false
                    isPresented = false
                }, label: {
                    TBIcon.cancel.iconSize(size: .small)
                        .foregroundStyle(TBColor.grayscale._20)
                })
            }
            .frame(width: 260)
            Text("게시글 신고사유를 입력해주세요.")
                .foregroundStyle(TBColor.grayscale._90)
                .font(TBFont.title_3)
            
            TextEditor(text: $viewModel.content)
                .focused($isFocus)
                .font(TBFont.body_4)
                .scrollContentBackground(.hidden)
                .frame(width: 260, height: 132)
                .background(TBColor.grayscale._1)
                .border(TBColor.grayscale._5)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .overlay {
                    VStack {
                        HStack {
                            Text("게시글 신고사유를 입력하세요.")
                                .foregroundStyle(TBColor.grayscale._20)
                                .font(TBFont.body_4)
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(8)
                    .opacity(viewModel.content.isEmpty ? 1 : 0)
                    .allowsHitTesting(false)
                }
            
            HStack {
                TBButton(
                    type: .customOutline(
                        strokeColor: TBColor.grayscale._50,
                        pressedBackgroundColor:  TBColor.grayscale._5
                    ),
                    size: .regular,
                    title: "신고 취소",
                    maxWidth: 126,
                    titleTextColor: TBColor.grayscale._50,
                    isEnabled: .constant(true)
                ) {
                    viewModel.content = ""
                    isFocus = false
                    isPresented = false
                }
                
                TBButton(
                    type: .filled,
                    size: .regular,
                    title: "게시글 신고",
                    maxWidth: 126,
                    isEnabled: Binding(
                        get: { !self.viewModel.content.isEmpty },
                        set: {_ in}
                    )
                ) {
                    Task {
                        guard let id = postId else { return }
                        await viewModel.requestReport(id: id)
                        await MainActor.run { onReport() }
                    }
                    
                }
            }
            .frame(width: 260)
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ZStack {
        Color.black
        ReportPopupView(postId: 0, isPresented: .constant(true))
    }
}
