//
//  FeedItemViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/04.
//

import SwiftUI

class FeedItemViewModel: ObservableObject {
    @Published var data: FeedModel
    
    init(_ data: FeedModel) {
        self.data = data
    }
    
    struct FeedItemButtonConfigure {
        let image: Image
        let backgroundColor: Color
    }
    
    func getLikeButtonConfigure() -> FeedItemButtonConfigure {
        if data.isLiked {
            return .init(image: Image(systemName: "heart.fill"), backgroundColor: .pink)
        } else {
            return .init(image: Image(systemName: "heart"), backgroundColor: .primary)
        }
    }
    
    func getSaveButtonConfigure() -> FeedItemButtonConfigure {
        if data.isSaved {
            return .init(image: Image(systemName: "bookmark.fill"), backgroundColor: .yellow)
        } else {
            return .init(image: Image(systemName: "bookmark"), backgroundColor: .primary)
        }
    }
    
    func didTapLikeButton() {
        // here is API Service
        
        // after...
        data.isLiked = !data.isLiked
        if data.isLiked {
            data.likeCount += 1
        } else {
            data.likeCount -= 1
        }
    }
    
    func didTapSaveButton() {
        // here is API Service
        
        // after...
        data.isSaved = !data.isSaved
    }
}
