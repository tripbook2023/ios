//
//  TravelNewsSortPopupView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/05.
//

import SwiftUI

struct TravelNewsSortPopupView: View {
    @ObservedObject var viewModel: TravelNewsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                viewModel.currentSort = .createdDesc
            } label: {
                let text = Text("최신순")
                    .font(TBFont.body_4)
                
                if viewModel.currentSort == .createdDesc {
                    text.foregroundColor(TBColor.grayscale._90)
                } else {
                    text.foregroundColor(TBColor.grayscale._30)
                }
            }

            Button {
                viewModel.currentSort = .popularity
            } label: {
                let text = Text("인기순")
                    .font(TBFont.body_4)
                
                if viewModel.currentSort == .popularity {
                    text.foregroundColor(TBColor.grayscale._90)
                } else {
                    text.foregroundColor(TBColor.grayscale._30)
                }

            }

            Button {
                viewModel.currentSort = .createdAsc
            } label: {
                let text = Text("오래된순")
                    .font(TBFont.body_4)
                
                if viewModel.currentSort == .createdAsc {
                    text.foregroundColor(TBColor.grayscale._90)
                } else {
                    text.foregroundColor(TBColor.grayscale._30)
                }
            }

        }
        .frame(width: 100, height: 124)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(TBShadow._2)
        
    }
}
//
//struct TravelNewsSortPopupView_Previews: PreviewProvider {
//    static var previews: some View {
//        TravelNewsSortPopupView(viewModel: .init(apiManager: 메ㅑ, tokenStorage: <#TokenStorage#>))
//    }
//}ㅑ
