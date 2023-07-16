//
//  NotificationView.swift
//  ios-tripbook
//
//  Created by DDang on 7/16/23.
//

import SwiftUI

protocol NotificationViewDelegate {
    func didTapNotificationItemView()
}

protocol NotificationHeaderViewDelegate {
    func didTapEditButton()
}

protocol NotificationItemViewDelegate {
    func didTapConfirmButton()
    func didTapDismissButton()
}

struct NotificationView: View {
    @ObservedObject var viewModel = NotificationViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                NotificationHeaderView {
                    self.viewModel.didTapEditButton()
                }
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<3, id: \.self) { _ in
                            NotificationItemView(isEdit: self.$viewModel.isEdit, didPressView: self.viewModel.didTapNotificationItemView)
                        }
                    }.padding(.vertical, 16)
                }
            }
            
            ZStack {
                Color.black.opacity(0.6)
                
                TBPopup(
                    title: "삭제하시겠습니까?",
                    confirmButtonText: "삭제하기",
                    dismissButtonText: "닫기",
                    didTapConfirmButton: self.viewModel.didTapConfirmButton,
                    didTapDismissButton: self.viewModel.didTapDismissButton
                )
            }
            .ignoresSafeArea()
            .opacity(self.viewModel.isShowEditModal ? 1 : 0)
        }
        .navigationBarHidden(true)
    }
}

struct NotificationItemView: View {
    @Binding var isEdit: Bool
    let didPressView: () -> Void
    
    var body: some View {
        Button(action: {
            if self.isEdit {
                self.didPressView()
            }
        }) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 8) {
                    Text("에디터 게시글 신청현황")
                        .font(TBFont.title_3)
                        .foregroundColor(TBColor.grayscale._90)
                    
                    TBTag(.approved)
                }
                
                HStack {
                    Text("ㅇㅇ님이 올리신 게시글이 반려사유로 반려되었습니다.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(TBFont.body_4)
                        .foregroundColor(TBColor.grayscale._60)
                    
                    if self.isEdit {
                        TBIcon.delete.iconSize(size: .small)
                            .padding(.leading, 27)
                            .foregroundColor(TBColor.grayscale._50)
                    } else {
                        TBIcon.next.iconSize(size: .small)
                            .padding(.leading, 27)
                            .foregroundColor(TBColor.grayscale._50)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
                
                Text("23.01.24")
                    .font(TBFont.caption_2)
                    .foregroundColor(TBColor.grayscale._20)
                    .padding(.top, 4)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
        }.buttonStyle(NotificationItemViewStyle())
    }
}

struct NotificationItemViewStyle: PrimitiveButtonStyle {
    @State var isPressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        let gesture = DragGesture(minimumDistance: 0)
            .onChanged { _ in self.isPressed = true }
            .onEnded { _ in
                self.isPressed = false
                configuration.trigger()
            }
        
        return configuration.label
            .background(self.isPressed ? TBColor.primary._1 : .clear)
            .gesture(gesture)
    }
}

struct NotificationHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    let didTapEditButton: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    TBIcon.before.iconSize(size: .medium)
                        .foregroundColor(TBColor.grayscale._90)
                }
                Spacer()
            }
            
            HStack(spacing: 0) {
                Spacer()
                Text("알림")
                    .font(TBFont.body_3)
                    .foregroundColor(TBColor.grayscale._80)
                Spacer()
            }
            
            HStack {
                Spacer()
                TBButton(type: .filled, size: .small, title: "편집", titleTextColor: TBColor.grayscale._5, backgroundColor: TBColor.grayscale._60, isEnabled: .constant(true)) {
                    self.didTapEditButton()
                }
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 20)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
