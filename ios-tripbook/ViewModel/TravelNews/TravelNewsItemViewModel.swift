//
//  TravelNewsItemViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/18.
//

import Foundation

/// 여행소식 게시물 Item View Model
class TravelNewsItemViewModel: ObservableObject {
    @Published var data: TravelNewsModel
    
    init(_ data: TravelNewsModel) {
        self.data = data
    }
}

/// 여행소식 게시물 Action Event Delegate
extension TravelNewsItemViewModel: DocumentActionBarDelegate {
    func didTapLikeButton() {
        
    }
    
    func didTapCommentButton() {
        
    }
    
    func didTapShareButton() {
        
    }
    
    func didTapSaveButton() {
        
    }
}
