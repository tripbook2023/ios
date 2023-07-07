//
//  RequestEditorResultView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/21.
//

import SwiftUI

/// 여행소식 에디터 신청결과화면
/// - Author: 김민규
/// - Date: 2023/05/21
struct RequestEditorResultView: View {
    @Environment(\.presentationMode) var presentationMode
    
    /// 승인 여부
    var isApproved: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            //            /// Header
            //            ZStack {
            //                HStack {
            //                    Text("여행소식 에디터 신청하기")
            //                        .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 15))
            //                }
            //                
            //                HStack {
            //                    Button(action: {
            //                        self.presentationMode.wrappedValue.dismiss()
            //                    }) {
            //                        TBIcon.before
            //                            .resizable()
            //                            .scaledToFit()
            //                            .frame(width: 24, height: 24)
            //                    }.foregroundColor(.primary)
            //                    Spacer()
            //                }
            //            }
            //            
            //            Text(
            //                self.isApproved ?
            //                "\(self.dataObject.user!.name)님\n축하드립니다!\n에디터로 선정되셨습니다." :
            //                    "\(self.dataObject.user!.name)님\n아쉽지만\n이번에는 함께하지 못하게 됐어요.\n다음에 함께해요!"
            //            )
            //            .font(.custom(TBFont.Suit.bold.rawValue, size: 23))
            //            .multilineTextAlignment(.center)
            //            .padding(.top, 57)
            //            
            //            Spacer()
            //            
            //            Text(self.isApproved ?
            //                 "신청 결과를 확인하신 \(self.dataObject.user!.name)님께\n2,000P를 지급해드렸습니다.\n에디터 활동에 대한 자세한 내용은\n이메일로 안내드렸습니다.\n이메일을 확인해주세요!" :
            //                    "신청 결과를 확인하신 모든 분께\n2,000P를 지급해드렸습니다.\n알림을 확인해주세요!"
            //            )
            //            .frame(minWidth: 115)
            //            .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 16))
            //            .multilineTextAlignment(.center)
            //            
            //            if !self.isApproved {
            //                Button(action: {
            //                    self.presentationMode.wrappedValue.dismiss()
            //                }) {
            //                    Text("에디터 다시 신청할게요!")
            //                        .frame(maxWidth: .infinity)
            //                        .frame(height: 72)
            //                        .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 22))
            //                        .foregroundColor(.black)
            //                        .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.init(red: 255 / 255, green: 249 / 255, blue: 183 / 255)))
            //                }.padding(.top)
            //            }
            //        }
            //        .padding(.horizontal)
            //        .padding(.bottom)
            //        .navigationBarHidden(true)
        }
    }
}

struct RequestEditorResultView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RequestEditorResultView(isApproved: true)
            RequestEditorResultView(isApproved: false)
        }
    }
}
