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
                    TravelNewsHeaderView(
                        isSearch: $viewModel.isSearch,
                        searchText: $viewModel.searchKeyword
                    ) {
                        viewModel.addSearchKeyword()
                        withAnimation(Animation.spring().speed(2)) {
                            viewModel.isSearch = false
                        }
                    }
                    ZStack {
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
                        .opacity(viewModel.isSearch ? 0 : 1)
                        
                        TravelNewsSearchKeywordListView(viewModel: viewModel)
                        .opacity(viewModel.isSearch ? 1 : 0)
                    }
                }
            }
        }
        .onAppear {
            bind()
        }
    }
}

extension TravelNewsView {
    private func bind() {
        if viewModel.keywordList.isEmpty {
            viewModel.readSearchKeywords()
        }
        viewModel.fetchMyTravelNewsList()
        viewModel.$currentSort
            .removeDuplicates()
            .sink { _ in
                viewModel.fetchTravelNewsList()
            }
            .store(in: &anyCancellable)
        viewModel.$isSearch
            .filter { !$0 }
            .sink { _ in
                viewModel.searchKeyword = ""
            }
            .store(in: &anyCancellable)
    }
}

struct TravelNewsView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsView()
    }
}
