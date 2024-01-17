//
//  TravelNewsSearchKeywordListView.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/5/23.
//

import SwiftUI
import CoreData

struct TravelNewsSearchKeywordListView: View {
    @ObservedObject private var viewModel: TravelNewsViewModel
    
    init(viewModel: TravelNewsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack() {
            Divider()
            HStack {
                Text("최근 검색어")
                    .foregroundStyle(TBColor.grayscale._90)
                    .font(TBFont.body_3)
                Spacer()
                Button(action: {
                    viewModel.deleteAllSearchKeyword()
                }, label: {
                    Text("전체삭제")
                        .foregroundStyle(TBColor.grayscale._50)
                        .font(TBFont.body_4)
                })
            }
            .padding(.vertical, 30)
            .padding(.horizontal, 20)
            
            VStack(spacing: 20) {
                ForEach(0..<viewModel.keywordList.count, id: \.self) { i in
                    HStack {
                        Button {
                            viewModel.searchKeyword = viewModel.keywordList[i]
                        } label: {
                            Text(viewModel.keywordList[i])
                                .foregroundStyle(TBColor.grayscale._80)
                            Spacer()
                            Button(action: {
                                viewModel.deleteSearchKeyword(i)
                            }, label: {
                                TBIcon.cancel
                                    .iconSize(size: .tiny)
                                    .foregroundStyle(TBColor.grayscale._90)
                                
                            })
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
}

#Preview {
    TravelNewsSearchKeywordListView(viewModel: .init())
}
