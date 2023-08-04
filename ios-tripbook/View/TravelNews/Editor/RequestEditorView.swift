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
                        .padding(.top ,40)
                        .padding(.bottom, 24)
                    
                    
                    RequestEditorGuideView()
                        .frame(width: geometry.size.width, height: 260)
                        .background(TBColor.grayscale.levels[2])
                    
                }.padding(.horizontal)
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .navigationBarHidden(true)
            .background(TBColor.grayscale.levels[10].ignoresSafeArea(edges: .top))
        }
        
    }
}

struct RequestEditorView_Previews: PreviewProvider {
    static var previews: some View {
        RequestEditorView()
    }
}
