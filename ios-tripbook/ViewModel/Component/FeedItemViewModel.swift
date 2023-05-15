//
//  FeedItemViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/04.
//

import SwiftUI

/// 여행 기록 Item View - View Model
/// - Author: 김민규
/// - Date: 2023/05/15
class FeedItemViewModel: ObservableObject {
    @Published var data: TravelReportModel
    
    /// 날짜 표시를 위한 포맷터
    /// - Returns: Example) 23년 5월 15일(월)
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yy년 M월 d일(E)"
        return formatter
    }()
    
    init(_ data: TravelReportModel) {
        self.data = data
    }
    
    /// 좋아요 버튼 Tap
    func didTapLikeButton() {
        // here is API Service
    }
    
    /// 댓글 버튼 Tap
    func didTapCommentButton() {
        
    }
    
    /// 공유 버튼 Tap
    func didTapShareButton() {
        
    }
    
    /// 저장 버튼 Tap
    func didTapSaveButton() {
        // here is API Service
    }
}
