//
//  FeedModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/04.
//

import Foundation
import UIKit

/// 여행 기록 Data Model
/// - Author: 김민규
/// - Date: 2023/05/15
class TravelReportModel: Document {
    /// 내용
    let content: String
    /// 위치
    let locate: String
    
    init(
        author: User,
        title: String,
        image: UIImage,
        likeCount: Int,
        commentCount: Int,
        isLiked: Bool,
        isSaved: Bool,
        createdAt: Date,
        content: String,
        locate: String
    ) {
        self.content = content
        self.locate = locate
        
        super.init(
            author: author,
            title: title,
            image: image,
            likeCount: likeCount,
            commentCount: commentCount,
            isLiked: isLiked,
            isSaved: isSaved,
            createdAt: createdAt
        )
    }
}

/// 여행 기록 Dummy Data Model
/// - Author: 김민규
/// - Date: 2023/05/15
class SampleTravelReportModel: TravelReportModel {
    /// Default 여행 기록 Dummy Data Model Initializer
    init() {
        super.init(
            author: .init(authority: .usual, name: "서지혜", profileImage: UIImage(named: "SampleProfileImage")!),
            title: "title",
            image: UIImage(named: "SampleFeedThumbnail")!,
            likeCount: 1,
            commentCount: 2,
            isLiked: false,
            isSaved: false,
            createdAt: .init(),
            content: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent",
            locate: "부산 태종대"
        )
    }
}
