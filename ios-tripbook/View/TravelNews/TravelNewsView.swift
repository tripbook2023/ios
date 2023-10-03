//
//  TravelNewsView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/24.
//

import SwiftUI

/// 여행 소식 화면
/// - Author: 김민규
/// - Date: 2023/05/20
struct TravelNewsView: View {
    @ObservedObject var viewModel = TravelNewsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    TravelNewsHeaderView()
                    
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            TabView {
                                ForEach(0..<3, id: \.self) { _ in
                                    NavigationLink(destination: RequestEditorView()) {
                                        EventBannerView(text: "여행소식 에디터 신청하고 포폴 만들자!").padding(.horizontal)
                                    }
                                }
                            }
                            .frame(height: 110)
                            .tabViewStyle(.page)
                            
                            TravelNewsEditorListView()
                                .padding(.top, 48)
                            
                            TravelNewsListView()
                                .padding(.top, 56)
                        }.padding(.bottom)
                    }
                }
                
                Button(action: {
                    viewModel.isShowEditorView = true
                }) {
                    Circle().foregroundColor(TBColor.primary._50)
                        .frame(width: 60, height: 60)
                        .shadow(TBShadow._2)
                        .overlay(
                            TBIcon.writing.iconSize(size: .big).foregroundColor(.white)
                        )
                }
                .padding(.trailing, 20)
                .padding(.bottom, 28)
                .sheet(isPresented: $viewModel.isShowEditorView) {
                    TravelNewsPostView()
                }
            }
        }
    }
}

struct TravelNewsView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsView()
    }
}
