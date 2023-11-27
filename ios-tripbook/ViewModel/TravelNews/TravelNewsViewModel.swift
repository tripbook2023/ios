//
//  TravelNewsViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/17.
//

import Foundation
import SwiftUI

enum Sort: String {
    case createdDesc = "createdDesc"
    case createdAsc = "createdAsc"
    case popularity = "popularity"
}

/// 여행소식 화면 View Model
class TravelNewsViewModel: ObservableObject {
    let dataStorage = DataStorage.shared
    private let apiManager: APIManagerable
    private let tokenStorage: TokenStorage
    
    /// 에디터/관리자 본인 여행소식 게시물 List
    @Published var myTravelNewsList: [MyTravelNewsModel] = []
    /// 여행소식 게시물 LIst
    @Published var travelNewsList: [TravelNewsModel] = []
    
    @Published var isShowEditorView: Bool = false
    @Published var currentSort: Sort = .createdDesc    
    @Published var isSortPopup = false
    
    /// 현재 여행소식 게시물 List Page Number
    var currentPage = 0
    
    init(apiManager: APIManagerable, tokenStorage: TokenStorage) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
        self.myTravelNewsList = self.fetchMyTravelNewsList()
        self.travelNewsList = self.fetchTravelNewsList()
    }
    
    /// Load 에디터/관리자 본인 여행소식 게시물 LIst
    func fetchMyTravelNewsList() -> [MyTravelNewsModel] {
        // TODO: API Service 연동
        return [
            SampleMyTravelNewsModel(.done),
            SampleMyTravelNewsModel(.done),
            SampleMyTravelNewsModel(.done),
            SampleMyTravelNewsModel(.waiting)
        ]
    }
    
    /// Load 여행소식 게시물 List
    func fetchTravelNewsList() -> [TravelNewsModel] {
        // TODO: API Service 연동
        return Array(repeating: SampleTravelNewsModel(), count: 5)
    }
    
    func makeDetailVM() -> TravelNewsDetailViewModel {
        return TravelNewsDetailViewModel(apiManager: apiManager, tokenStorage: tokenStorage)
    }
}
