//
//  NotificationView.swift
//  ios-tripbook
//
//  Created by DDang on 7/16/23.
//

import SwiftUI

struct NotificationView: View {
    @State var isClicked = true
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                NotificationHeaderView()
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<3, id: \.self) { _ in
                            NotificationItemView() {
                                self.isClicked = true
                            }
                        }
                    }.padding(.vertical, 16)
                }
            }
            
            if self.isClicked {
                ZStack {
                    Color.black.opacity(0.6)
                    
                    TBPopup(
                        title: "삭제하시겠습니까?",
                        confirmButtonText: "삭제하기",
                        dismissButtonText: "닫기",
                        didTapConfirmButton: {
                            self.isClicked = false
                        },
                        didTapDismissButton: {
                            self.isClicked = false
                        }
                    )
                }.ignoresSafeArea()
            }
        }
        .navigationBarHidden(true)
    }
}

struct NotificationItemView: View {
    @State var isPressed = false
    let didPressView: () -> Void
    
    var body: some View {
        Button(action: {
            self.didPressView()
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
                    
                    TBIcon.next.iconSize(size: .small)
                        .padding(.leading, 27)
                        .foregroundColor(TBColor.grayscale._50)
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
            .background(self.isPressed ? TBColor.primary._1 : .white)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in self.isPressed = true }
                    .onEnded { _ in self.isPressed = false }
            )
        }
    }
}

struct NotificationHeaderView: View {
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    
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
                TBButton(type: .filled, size: .small, title: "편집", isEnabled: .constant(true)) {
                    
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
