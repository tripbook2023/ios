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
    
    struct PageValue {
        var isLastPage = false
        var currentPage = 0
        var isLoding = false
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
    
    @Published var isSearching = false
    @Published var isSearched = false
    @Published var searchKeyword = ""
    @Published var keywordList: [String] = []
    @Published var searchResult: [TravelNewsModel] = []
    @Published var isSearchResultEmpty = false
    
    @Published var myTravelNewsCount = 0
    
    private var mainPage: PageValue = .init()
    private var searchPage: PageValue = .init()
    private var myPage: PageValue = .init()

    func fetchMyTravelNewsList(count: Int, type: FetchType) {
        if myPage.isLastPage && type == .next { return }
        guard !myPage.isLoding else { return }
        myPage.isLoding = true
        Task {
            do {
                myPage.currentPage = type == .first ? 0 : myPage.currentPage + 1
                let api = TBMemberAPI.selectMyArticles(
                    page: myPage.currentPage,
                    size: count
                )
                let response = try await apiManager.request(
                    api,
                    type: SelectMyArticlesResponse.self
                )
                let items = response.toDomain
                await MainActor.run {
                    myPage.isLastPage = items.isEmpty
                    myTravelNewsCount = response.totalElements
                    myTravelNewsList = type == .first ? items : myTravelNewsList + items
                }
            } catch {
                /// 에러 핸들링
                print(error)
            }
            myPage.isLoding = false
        }
    }
    
    /// Load 여행소식 게시물 List
    func fetchTravelNewsList(type: FetchType) {
        if mainPage.isLastPage && type == .next { return }
        guard !mainPage.isLoding else { return }
        mainPage.isLoding = true
        Task {
            do {
                mainPage.currentPage = type == .first ? 0 : mainPage.currentPage + 1
                let api = TBTravelNewsAPI.search(
                    word: "",
                    page: mainPage.currentPage,
                    size: 10,
                    sort: currentSort
                )
                let items = try await apiManager.request(
                    api,
                    type: SearchResponse.self
                ).toDomain
                await MainActor.run {
                    mainPage.isLastPage = items.isEmpty
                    travelNewsList = type == .first ? items : travelNewsList + items
                }
            } catch {
                /// 에러 핸들링
                print(error)
            }
            mainPage.isLoding = false
        }
    }
    
    func searchTravelNewsList(type: FetchType) {
        if searchPage.isLastPage && type == .next { return }
        guard !searchPage.isLoding else { return }
        searchPage.isLoding = true
        isSearchResultEmpty = false
        Task {
            do {
                searchPage.currentPage = type == .first ? 0 : searchPage.currentPage + 1
                let api = TBTravelNewsAPI.search(
                    word: searchKeyword,
                    page: searchPage.currentPage,
                    size: 20,
                    sort: currentSort
                )
                let items = try await apiManager.request(
                    api,
                    type: SearchResponse.self
                ).toDomain
                await MainActor.run {
                    searchPage.isLastPage = items.isEmpty
                    isSearchResultEmpty = items.isEmpty && searchResult.isEmpty
                    searchResult = type == .first ? items : searchResult + items
                }
            } catch {
                /// 에러 핸들링
                print(error)
            }
            searchPage.isLoding = false
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
