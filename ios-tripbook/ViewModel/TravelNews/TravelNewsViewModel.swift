//
//  TravelNewsViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/17.
//

import Foundation
import SwiftUI

/// 여행소식 화면 View Model
class TravelNewsViewModel: ObservableObject {
    let dataStorage = DataStorage.shared
    
    /// 에디터/관리자 본인 여행소식 게시물 List
    @Published var myTravelNewsList: [MyTravelNewsModel] = []
    /// 여행소식 게시물 LIst
    @Published var travelNewsList: [TravelNewsModel] = []
    
    @Published var isShowEditorView: Bool = false
    @Published var currentSort: Sort = .createdDesc    
    @Published var isSortPopup = false
    
    /// 현재 여행소식 게시물 List Page Number
    var currentPage = 0
    
    init() {
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
}
