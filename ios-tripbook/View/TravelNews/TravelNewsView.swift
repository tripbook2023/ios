//
//  TravelNewsView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/24.
//

import SwiftUI
import Combine

/// 여행 소식 화면
/// - Author: 김민규
/// - Date: 2023/05/20
struct TravelNewsView: View {
    @StateObject private var viewModel = TravelNewsViewModel()
    @State private var anyCancellable = Set<AnyCancellable>()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    TravelNewsHeaderView()
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            NavigationLink(destination: EmptyView()) {
                                EventBannerView(text: "여행소식 에디터 신청하고 포폴 만들자!").padding(.horizontal)
                            }
                            .frame(height: 110)
                            if !viewModel.myTravelNewsList.isEmpty {
                                TravelNewsEditorListView(viewModel: viewModel)
                                    .padding(.top, 48)
                            }
                            TravelNewsListView(viewModel: viewModel)
                                .padding(.top, 56)
                        }.padding(.bottom)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchMyTravelNewsList()
            viewModel.fetchTravelNewsList()
            bind()
        }
    }
}

extension TravelNewsView {
    private func bind() {
        viewModel.$currentSort.sink { _ in
            viewModel.fetchTravelNewsList()
        }.store(in: &anyCancellable)
    }
}

struct TravelNewsView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsView()
    }
}
