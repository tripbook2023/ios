//
//  TravelNewsViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/17.
//

import Foundation

/// 여행소식 화면 View Model
class TravelNewsViewModel: ObservableObject {
    enum FetchType {
        case first
        case next
    }

    private let apiManager: APIManagerable
    private let tokenStorage: TokenStorage
    private let searchKeywordStorage: Storageable
    
    init(
        apiManager: APIManagerable = TBAPIManager(),
        tokenStorage: TokenStorage = .shared,
        searchKeywordStorage: Storageable = SearchKeywordStorage()
    ) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
        self.searchKeywordStorage = searchKeywordStorage
    }
    
    /// 에디터/관리자 본인 여행소식 게시물 List
    @Published var myTravelNewsList: [TravelNewsModel] = []
    /// 여행소식 게시물 LIst
    @Published var travelNewsList: [TravelNewsModel] = []
    @Published var currentSort: Sort = .createdDesc
    @Published var isSortPopup = false
    @Published var isLastPage = false
    
    @Published var isSearching = false
    @Published var isSearched = false
    @Published var searchKeyword = ""
    @Published var keywordList: [String] = []
    @Published var searchResult: [TravelNewsModel] = []

    private var currentPage = 0
    private var isLoding = false
    
    func fetchMyTravelNewsList() {
        // TODO: API Service 연동
        myTravelNewsList = [
            TravelNewsModel.dummy,
            TravelNewsModel.dummy,
            TravelNewsModel.dummy,
            TravelNewsModel.dummy
        ]
    }
    
    /// Load 여행소식 게시물 List
    func fetchTravelNewsList(type: FetchType) {
        guard !isLoding else { return }
        isLoding = true
        Task {
            do {
                currentPage = type == .first ? 0 : currentPage + 1
                let api = TBTravelNewsAPI.search(
                    word: "",
                    page: currentPage,
                    size: 10,
                    sort: currentSort
                )
                let items = try await apiManager.request(
                    api,
                    type: SearchResponse.self
                ).toDomain
                await MainActor.run {
                    isLastPage = items.isEmpty
                    travelNewsList = type == .first ? items : travelNewsList + items
                }
            } catch {
                /// 에러 핸들링
                print(error)
            }
            isLoding = false
        }
    }
    
    func searchTravelNewsList() {
        Task {
            do {
                let api = TBTravelNewsAPI.search(
                    word: searchKeyword,
                    page: 0,
                    size: 10,
                    sort: currentSort
                )
                let items = try await apiManager.request(
                    api,
                    type: SearchResponse.self
                ).toDomain
                await MainActor.run {
                    searchResult = items
                }
            } catch {
                /// 에러 핸들링
                print(error)
            }
        }
    }
    
    func readSearchKeywords() {
        keywordList = searchKeywordStorage.read().reversed()
    }
    
    func addSearchKeyword() {
        guard !searchKeyword.isEmpty else { return }
        if let index = self.searchKeywordStorage
            .read()
            .firstIndex(where: { $0 == searchKeyword })
        {
            try? self.searchKeywordStorage.delete(index: index)
        }
        try? self.searchKeywordStorage.save(searchKeyword)
        keywordList = searchKeywordStorage.read().reversed()
    }
    
    func deleteSearchKeyword(index: Int) {
        let count = keywordList.count
        try? searchKeywordStorage.delete(index: count - index - 1)
        keywordList = searchKeywordStorage.read().reversed()
    }
    
    func deleteAllSearchKeyword() {
        try? searchKeywordStorage.deleteAll()
        keywordList = []
    }
}
