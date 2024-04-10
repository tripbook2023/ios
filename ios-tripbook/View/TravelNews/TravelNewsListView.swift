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
                    Text("여행기록")
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
                    LazyVStack(spacing: 20) {
                        ForEach(0..<viewModel.travelNewsList.count, id: \.self) { i in
                            let item = viewModel.travelNewsList[i]
                            TravelNewsListItemView(
                                Binding(
                                    get: { item },
                                    set: {_ in }
                                ),
                                isPresentedMoreSheet: $viewModel.isPresentedMoreSheet,
                                isOwner: viewModel.isOwner(index: i)
                            ) {
                                viewModel.likeButtonDidTap(index: i)
                            }
                            .onAppear {
                                if i > viewModel.travelNewsList.count - 3 {
                                    viewModel.fetchTravelNewsList(type: .next)
                                }
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
