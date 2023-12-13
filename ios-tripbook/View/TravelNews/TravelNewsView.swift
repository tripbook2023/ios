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
    @State private var isAppear = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    TravelNewsHeaderView(
                        isSearching: $viewModel.isSearching,
                        isSearched: $viewModel.isSearched,
                        searchText: $viewModel.searchKeyword
                    ) {
                        viewModel.addSearchKeyword()
                        viewModel.searchResult = []
                        viewModel.searchTravelNewsList(type: .first)
                        viewModel.isSearched = true
                    }
                    ZStack {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 0) {
                                NavigationLink(destination: EmptyView()) {
                                    EventBannerView(text: "여행소식 에디터 신청하고 포폴 만들자!").padding(.horizontal)
                                }
                                .frame(height: 110)
                                if !viewModel.myTravelNewsList.isEmpty {
                                    MyTravelNewsView(viewModel: viewModel)
                                        .padding(.top, 48)
                                }
                                TravelNewsListView(viewModel: viewModel)
                                    .padding(.top, 56)
                            }
                            .padding(.bottom)
                        }
                        .opacity(viewModel.isSearching ? 0 : 1)
                        
                        TravelNewsSearchKeywordListView(viewModel: viewModel)
                        .opacity(
                            viewModel.isSearching
                            && !viewModel.isSearched ? 1 : 0
                        )
                        
                        VStack {
                            Divider()
                            TravelNewsMiniListView(items: $viewModel.searchResult) { index in
                                if index > viewModel.searchResult.count - 6 {
                                    viewModel.searchTravelNewsList(type: .next)
                                }
                            }
                            .overlay {
                                if viewModel.isSearchResultEmpty {
                                    Text("원하시는 검색 결과를 찾을 수 없습니다")
                                        .font(TBFont.body_4)
                                        .foregroundStyle(TBColor.grayscale._90)
                                }
                                
                            }
                        }
                        .opacity(viewModel.isSearched ? 1 : 0)
                    }
                }
            }
            .onAppear {
                guard !isAppear else { return }
                isAppear = true
                bind()
            }
        }
    }
}

extension TravelNewsView {
    private func bind() {
        if viewModel.keywordList.isEmpty {
            viewModel.readSearchKeywords()
        }
        viewModel.fetchMyTravelNewsList(count: 5, type: .first)
        viewModel.$currentSort
            .removeDuplicates()
            .sink { _ in
                viewModel.fetchTravelNewsList(type: .first)
            }
            .store(in: &anyCancellable)
        viewModel.$isSearching
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
