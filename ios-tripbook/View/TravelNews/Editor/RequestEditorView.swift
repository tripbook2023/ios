//
//  RequestEditorView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/19.
//

import SwiftUI

/// 에디터 신청하기 화면
/// - Author: 김민규
/// - Date: 2023/05/21
struct RequestEditorView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = RequestEditorViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                /// Header
                ZStack {
                    HStack {
                        Text("에디터 신청")
                            .font(TBFont.body_3)
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image("Before")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }.foregroundColor(.primary)
                        Spacer()
                    }
                }.padding([.top, .bottom])
                
                RequestEditorBannerView()
                    .padding()
                
                
//                self.loadGuideViews()
//
//                self.loadFooterView()
            }.padding(.horizontal)
        }
        .navigationBarHidden(true)
        .background(TBColor.grayscale.levels[10].ignoresSafeArea(edges: .top))
    }
    
    /// Load 에디터 가이드 Views
//    @ViewBuilder
//    func loadGuideViews() -> some View {
//        LazyVStack(spacing: 0) {
//            VStack(spacing: 0) {
//                Text("여행 기록을 좋아하신다면\n여행 에디터를\n신청해보세요!")
//                    .font(.suit(.bold, size: 19))
//                    .multilineTextAlignment(.center)
//
//                Rectangle()
//                    .frame(height: 76)
//                    .foregroundColor(.init(red: 255 / 255, green: 248 / 255, blue: 183 / 255))
//                    .overlay(
//                        Text("에디터 신청만 해도\n5,000P 지급")
//                            .font(.suit(.bold, size: 19))
//                            .multilineTextAlignment(.center)
//                    )
//                    .padding(.top, 36)
//            }.padding(.top, 75)
//
//            VStack(spacing: 0) {
//                Text("에디터는 어떻게 되나요?")
//                    .font(.suit(.bold, size: 19))
//
//                HStack(spacing: 11) {
//                    Rectangle()
//                        .frame(height: 141)
//                        .foregroundColor(.init(red: 217 / 255, green: 217 / 255, blue: 217 / 255))
//                        .overlay(
//                            VStack {
//                                Text("STEP 1")
//                                    .font(.suit(.bold, size: 19))
//                                Spacer()
//                                Text("신청")
//                                    .font(.suit(.bold, size: 25))
//                            }.padding(EdgeInsets(top: 23, leading: 21, bottom: 23, trailing: 21))
//                        )
//
//                    Rectangle()
//                        .frame(height: 141)
//                        .foregroundColor(.init(red: 217 / 255, green: 217 / 255, blue: 217 / 255))
//                        .overlay(
//                            VStack {
//                                Text("STEP 2")
//                                    .font(.suit(.bold, size: 19))
//                                Spacer()
//                                Text("심사")
//                                    .font(.suit(.bold, size: 25))
//                            }.padding(EdgeInsets(top: 23, leading: 21, bottom: 23, trailing: 21))
//                        )
//
//                    Rectangle()
//                        .frame(height: 141)
//                        .foregroundColor(.init(red: 217 / 255, green: 217 / 255, blue: 217 / 255))
//                        .overlay(
//                            VStack {
//                                Text("STEP 3")
//                                    .font(.suit(.bold, size: 19))
//                                Spacer()
//                                Text("합격")
//                                    .font(.suit(.bold, size: 25))
//                            }.padding(EdgeInsets(top: 23, leading: 21, bottom: 23, trailing: 21))
//                        )
//                }.padding(.top, 32)
//            }.padding(.top, 38)
//
//            VStack(spacing: 0) {
//                Text("여행 에디터가 되면 뭐가 좋나요?")
//                    .font(.suit(.bold, size: 19))
//
//                VStack(spacing: 20) {
//                    Rectangle()
//                        .frame(height: 228)
//                        .foregroundColor(.init(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
//                        .overlay(
//                            VStack(spacing: 0) {
//                                Rectangle()
//                                    .frame(width: 128, height: 128)
//                                Text("많은 사람들이 내 콘텐츠를\n볼 수 있어요!")
//                                    .font(.suit(.bold, size: 19))
//                                    .multilineTextAlignment(.center)
//                            }
//                        )
//
//                    Rectangle()
//                        .frame(height: 228)
//                        .foregroundColor(.init(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
//                        .overlay(
//                            VStack(spacing: 0) {
//                                Rectangle()
//                                    .frame(width: 128, height: 128)
//                                Text("나만의 여행기록 콘텐츠를\n쌓아갈 수 있어요!")
//                                    .font(.suit(.bold, size: 19))
//                                    .multilineTextAlignment(.center)
//                            }
//                        )
//
//                    Rectangle()
//                        .frame(height: 228)
//                        .foregroundColor(.init(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
//                        .overlay(
//                            VStack(spacing: 0) {
//                                Rectangle()
//                                    .frame(width: 128, height: 128)
//                                Text("임명장/수료증 발급해드려요.")
//                                    .font(.suit(.bold, size: 19))
//                                    .multilineTextAlignment(.center)
//                            }
//                        )
//                }.padding(.top, 31)
//            }.padding(.top, 76)
//        }
//    }
    
    /// Load 에디터 신청/진행 상태 View
//    @ViewBuilder
//    func loadFooterView() -> some View {
//        if self.viewModel.dataStorage.user?.role == .usual {
//            if self.viewModel.status == .before {
//                VStack(spacing: 20) {
//                    Text("여행 에디터 지금 바로 신청하기")
//                        .font(.suit(.bold, size: 19))
//
//                    HStack {
//                        Text("이메일")
//                            .font(.suit(.bold, size: 17))
//                        TextField("", text: self.$viewModel.emailTextField)
//                    }
//                    .padding(.horizontal)
//                    .frame(height: 58)
//                    .background(Color.init(red: 234 / 255, green: 234 / 255, blue: 234 / 255))
//
//                    HStack {
//                        Text("이전 글 불러오기")
//                            .font(.suit(.bold, size: 17))
//                        Spacer()
//                    }
//                    .padding(.horizontal)
//                    .frame(height: 58)
//                    .background(Color.init(red: 234 / 255, green: 234 / 255, blue: 234 / 255))
//
//                    Button(action: {}) {
//                        Text("여행소식 에디터 신청하기")
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 94)
//                            .font(.suit(.bold, size: 19))
//                            .foregroundColor(.black)
//                            .background(
//                                RoundedRectangle(cornerRadius: 50)
//                                    .foregroundColor(Color.init(red: 255 / 255, green: 248 / 255, blue: 183 / 255))
//                            )
//                    }.padding(.top, 6)
//                }.padding(.top, 67)
//            } else if self.viewModel.status == .inProgress {
//                VStack(spacing: 57) {
//                    Text("지금은 심사중입니다")
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 72)
//                        .font(.suit(.bold, size: 22))
//                        .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.init(red: 255 / 255, green: 248 / 255, blue: 183 / 255)))
//
//                    Text("에디터 신청이\n완료되었습니다!\n\n3-5일 내에\n결과가 발표됩니다.")
//                        .font(.suit(.bold, size: 19))
//                        .multilineTextAlignment(.center)
//                }.padding(.top, 67)
//            } else if self.viewModel.status == .complete {
//                VStack(spacing: 57) {
//                    NavigationLink(destination: RequestEditorResultView()) {
//                        Text("심사 결과 확인하기")
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 72)
//                            .font(.suit(.bold, size: 22))
//                            .foregroundColor(.black)
//                            .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.init(red: 255 / 255, green: 248 / 255, blue: 183 / 255)))
//                    }
//
//                    Text("에디터 심사 결과가 나왔습니다.\n어서 확인해보세요.")
//                        .font(.suit(.bold, size: 19))
//                        .multilineTextAlignment(.center)
//                }.padding(.top, 67)
//            }
//        }
//    }
}

struct RequestEditorView_Previews: PreviewProvider {
    static var previews: some View {
        RequestEditorView()
    }
}
