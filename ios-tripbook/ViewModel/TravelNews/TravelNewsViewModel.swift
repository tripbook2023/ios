//
//  TravelNewsViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/17.
//

import Foundation

/// 여행소식 화면 View Model
class TravelNewsViewModel: ObservableObject {
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
    @Published var selectTravelNewsItem: TravelNewsModel?
    @Published var isSearch = false
    @Published var searchKeyword = ""
    @Published var keywordList: [String] = []
    @Published var isShowEditorView: Bool = false
    @Published var currentSort: Sort = .createdDesc    
    @Published var isSortPopup = false
    
    /// 현재 여행소식 게시물 List Page Number
    var currentPage = 0
    
    /// Load 에디터/관리자 본인 여행소식 게시물 LIst
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
    func fetchTravelNewsList() {
        // TODO: API Service 연동
        Task {
            do {
                let api = TBTravelNewsAPI.search(
                    word: "",
                    page: 0,
                    size: 10,
                    sort: currentSort
                )
                let items = try await apiManager.request(
                    api,
                    type: SearchResponse.self
                ).toDomain
                await MainActor.run {
                    travelNewsList = items
                }
            } catch {
                
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
