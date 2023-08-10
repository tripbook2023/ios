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
    
    @State private var text: String = ""
    @State private var isHidden: Bool = true
    @State private var isTimer: Bool = false
    @State private var time = 60 * 10
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
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
                                TBIcon.before.iconSize(size: .medium)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                    }.padding(.vertical, 12)
                    
                    RequestEditorBannerView()
                        .padding(.top ,40)
                        .padding(.bottom, 24)
                    
                    
                    RequestEditorGuideView()
                        .frame(width: geometry.size.width, height: 260)
                        .background(TBColor.grayscale.levels[2])
                    
                    EditorBenefitsView()
                        .frame(width: geometry.size.width, height: 752)
                        .background(TBColor.primary.levels[5])
                    VStack {
                        Text("에디터 신청")
                            .font(TBFont.heading_2)
                            .padding(.top, 48)
                        Spacer().frame(height: 24)
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .frame(height: 48)
                            .foregroundColor(TBColor.grayscale.levels[2])
                            .overlay {
                                HStack {
                                    TextField("이메일@.com", text: $viewModel.emailTextField)
                                        .padding(.leading, 10)
                                    
                                    Button {
                                        isHidden = false
                                        if isValidEmail(testStr: viewModel.emailTextField) {
                                            isTimer = true
                                            time = 60 * 10
                                            text = "방금 메일이 발송되었습니다\n10분 이내로 이메일 인증해주세요."
                                        } else {
                                            isTimer = false
                                            text = "tripbook@tripbook.com 형태로 입력해주세요"
                                        }
                                    } label: {
                                        Text("인증 메일 발송")
                                            .font(TBFont.body_4)
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 12)
                                            .foregroundColor(TBColor.grayscale.levels[4])
                                            .background(TBColor.grayscale.levels[2])
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }.padding(.trailing, 10)

                                }
                            }
                        if !isHidden {
                            showEmailCertificationGuide()
                        }
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .foregroundColor(TBColor.primary.levels[4])
                                .frame(height: 48)
                                .overlay {
                                    Text("내 여행기록 불러오기")
                                        .foregroundColor(TBColor.primary.levels[4])
                                }
                            
                        }
                        Spacer().frame(height: 60)
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(TBColor.grayscale.levels[2])
                                .frame(height: 52)
                                .overlay {
                                    Text("에디터 신청하기")
                                        .foregroundColor(TBColor.grayscale.levels[7])
                                }
                            
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .frame(width: geometry.size.width, height: 372)
                    .background(.white)
                }.padding(.horizontal)
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .onDisappear {
                UIScrollView.appearance().bounces = true
            }
            .navigationBarHidden(true)
            .background(TBColor.grayscale.levels[10].ignoresSafeArea(edges: .top))
        }
        
    }
    @ViewBuilder
    private func showEmailCertificationGuide() -> some View {
        HStack(alignment: .top) {
            TBIcon.TBStateIcons().error
                .padding(.top, 2)
            Text(text)
                .font(TBFont.caption_1)
                .foregroundColor(TBColor.state.warning)
            Spacer()
            if isTimer {
                HStack(alignment: .center) {
                    TBIcon.timer
                    
                    let h = time / 60 < 10 ? "0\(time / 60)" : String(time / 60)
                    let m = time % 60 < 10 ? "0\(time % 60)" : String(time % 60)
                    
                    Text("\(h):\(m)")
                        .onReceive(timer) { _ in
                            if self.time > 0 {
                                self.time -= 1
                            }
                        }.frame(width: 34)
                        .font(TBFont.caption_1)
                }
            }
            
        }.frame(width: 335)
        
    }
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}

struct RequestEditorView_Previews: PreviewProvider {
    static var previews: some View {
        RequestEditorView()
    }
}
