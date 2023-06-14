//
//  MyTravelNewsItemViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/18.
//

import Foundation
import SwiftUI

/// 본인 여행소식 Item View Model
class MyTravelNewsItemViewModel: ObservableObject {
    @Published var data: MyTravelNewsModel
    
    /// 날짜 표시 Formatter
    var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init(_ data: MyTravelNewsModel) {
        self.data = data
    }
}

/// 게시물 Action Bar Event Delegate 정의
extension MyTravelNewsItemViewModel: DocumentActionBarDelegate {
    func didTapLikeButton() {
        
    }
    
    func didTapCommentButton() {
        
    }
    
    func didTapShareButton() {
        
    }
    
    func didTapSaveButton() {
        
    }
}
