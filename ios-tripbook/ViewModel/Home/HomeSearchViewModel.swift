//
//  HomeSearchViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/27.
//

import SwiftUI

class HomeSearchViewModel: ObservableObject {
    
    enum SearchResultTabs: String, CaseIterable, Identifiable {
        var id: String { return self.rawValue }
        
        case travelReport = "여행기록"
        case travelNews = "여행소식"
        case user = "작성자"
    }
    
    @Published var recentKeywords: [SearchKeywordModel] = []
    @Published var searchKeyword: String = ""
    @Published var matchSearchKeywords: [SearchKeywordModel] = []
    @Published var searchResults: [SearchResultTabs: [SearchKeywordModel]] = [
        .travelReport: [],
        .travelNews: [],
        .user: []
    ]
    
    @Published var selectedSearchKeyword: SearchKeywordModel?
    @Published var selectedResultTab: SearchResultTabs = .travelReport
    
    init() {
        for _ in 0..<20 {
            recentKeywords.append(TravelReportSearchKeywordModel(name: String(Int.random(in: 0..<1000))))
            
            matchSearchKeywords.append(TravelReportSearchKeywordModel(name: String(Int.random(in: 0..<1000))))
            
            searchResults[.travelReport]!.append(TravelReportSearchKeywordModel(name: String(Int.random(in: 0..<1000))))
            searchResults[.travelNews]!.append(TravelReportSearchKeywordModel(name: String(Int.random(in: 0..<1000))))
            searchResults[.user]!.append(TravelReportSearchKeywordModel(name: String(Int.random(in: 0..<1000))))
        }
    }
}

extension HomeSearchViewModel {
    func returnInitState() {
        self.resetSearchKeyword()
        self.selectedSearchKeyword = nil
    }
}

extension HomeSearchViewModel {
    func selectSearchKeyword(keyword: SearchKeywordModel) {
        self.searchKeyword = keyword.name
        self.selectedSearchKeyword = keyword
    }
}

extension HomeSearchViewModel {
    private func resetSearchKeyword() {
        self.searchKeyword = ""
    }
    
    private func setSearchKeyword(keyword: String) {
        self.searchKeyword = keyword
    }
}
