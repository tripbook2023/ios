//
//  TravelNewsView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/24.
//

import SwiftUI
import Combine
import CoreData

struct TravelNewsView: View {
    @StateObject private var viewModel = TravelNewsViewModel()
    @State private var anyCancellable = Set<AnyCancellable>()
    @State private var isAppear = false
    @State private var isPopupReportView = false
    @State private var isPopupUserBlockView = false
    
    var body: some View {
        NavigationStack {
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
                            LazyVStack(spacing: 0) {
                                MainBannerView()
                                    .padding(.vertical, 20)
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
                        .refreshable {
                            viewModel.fetchTravelNewsList(type: .first)
                            viewModel.fetchMyTravelNewsList(count: 5, type: .first)
                        }
                        
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
                            .refreshable {
                                viewModel.searchTravelNewsList(type: .first)
                            }
                        }
                        .opacity(viewModel.isSearched ? 1 : 0)
                    }
                }
            }
            .overlay(content: {
                Color.black
                    .ignoresSafeArea()
                    .opacity(isPopupReportView || isPopupUserBlockView ? 0.6 : 0)
                ReportPopupView(
                    postId: viewModel.selectedItem?.id,
                    isPresented: $isPopupReportView
                )
                .opacity(isPopupReportView ? 1 : 0)
                UserBlockPopupView(
                    user: viewModel.selectedItem?.author,
                    isPresented: $isPopupUserBlockView
                )
                .opacity(isPopupUserBlockView ? 1 : 0)
            })
            .onAppear {
                if !isAppear {
                    bind()
                    isAppear = true
                }
            }
            .confirmationDialog("", isPresented: $viewModel.isPresentedMoreSheet) {
                Button("사용자 차단", role: .destructive) {
                    isPopupUserBlockView = true
                }
                
                Button("게시글 신고", role: .destructive) {
                    isPopupReportView = true
                }
                
                Button("취소", role: .cancel) {
                    viewModel.selectedItem = nil
                }
            }
        }
    }
}

extension TravelNewsView {
    private func bind() {
        if viewModel.keywordList.isEmpty {
            viewModel.setSearchKeywords()
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
        NotificationCenter.default
            .publisher(for: .refreshMain)
            .sink { _ in
                viewModel.fetchTravelNewsList(type: .first)
                viewModel.fetchMyTravelNewsList(count: 5, type: .first)
            }
            .store(in: &anyCancellable)
        
        NotificationCenter.default
            .publisher(for: .selectedListItem)
            .sink {
                viewModel.selectedItem = $0.object as? TravelNewsModel
            }
            .store(in: &anyCancellable)
    }
}

struct TravelNewsView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsView()
    }
}
