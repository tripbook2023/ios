//
//  TravelNewsListView.swift
//  ios-tripbook
//
//  Created by DDang on 7/15/23.
//

import SwiftUI

struct TravelNewsListView: View {
    @ObservedObject var viewModel: TravelNewsViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 0) {
                HStack {
                    Text("여행소식")
                        .font(.suit(.bold, size: 20))
                        .foregroundColor(TBColor.grayscale._80)
                    Spacer()
                    Button(action: {
                        viewModel.isSortPopup.toggle()
                    }) {
                        TBIcon.filter.iconSize(size: .medium)
                            .foregroundColor(TBColor.grayscale._70)
                    }
                }
                ZStack(alignment: .top) {
                    VStack(spacing: 20) {
                        ForEach(0..<viewModel.travelNewsList.count, id: \.self) { i in
                            TravelNewsListItemView(item: viewModel.travelNewsList[i]) {
                                viewModel.selectTravelNewsItem = viewModel.travelNewsList[i]
                            }
                        }
                    }.padding(.top, 24)
                    HStack {
                        Spacer()
                        TravelNewsSortPopupView(viewModel: viewModel)
                            .opacity(viewModel.isSortPopup ? 1 : 0)
                    }
                }
            }
        }.padding(.horizontal, 20)
    }
}

struct TravelNewsListView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsListView(viewModel: .init())
    }
}
