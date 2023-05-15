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
class TravelReportModel {
    /// 사용자 Data Model
    let user: User
    
    /// 썸네일 이미지
    let image: UIImage
    /// 제목
    let title: String
    /// 내용
    let content: String
    /// 위치
    let locate: String
    
    /// 좋아요 수
    var likeCount: Int
    /// 댓글 수
    var commentCount: Int
    /// 좋아요 여부
    var isLiked: Bool
    /// 저장 여부
    var isSaved: Bool
    
    /// Data 생성 날짜
    let createdAt: Date
    
    /// 사용자 Data Model
    struct User {
        // - TODO: 수정 필요 및 예정.
        /// 이름(닉네임)
        let name: String
        /// 프로필 이미지
        let profileImage: UIImage
    }
    
    /// Default 여행 기록 Data Model Initializer
    /// - Parameters:
    ///     - user: 사용자 Data Model
    ///     - image: 썸네일 이미지
    ///     - title: 제목
    ///     - content: 내용
    ///     - locate: 위치
    ///     - likeCount: 좋아요 수
    ///     - commentCount: 댓글 수
    ///     - isLiked: 좋아요 여부
    ///     - isSaved: 저장 여부
    ///     - createdAt: Data 생성 날짜
    init(
        user: User,
        image: UIImage,
        title: String,
        content: String,
        locate: String,
        likeCount: Int,
        commentCount: Int,
        isLiked: Bool,
        isSaved: Bool,
        createdAt: Date
    ) {
        self.user = user
        self.image = image
        self.title = title
        self.content = content
        self.locate = locate
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.isLiked = isLiked
        self.isSaved = isSaved
        self.createdAt = createdAt
    }
}

/// 여행 기록 Dummy Data Model
/// - Author: 김민규
/// - Date: 2023/05/15
class SampleTravelReportModel: TravelReportModel {
    /// Default 여행 기록 Dummy Data Model Initializer
    init() {
        super.init(
            user: .init(name: "서지혜", profileImage: UIImage(named: "SampleProfileImage")!),
            image: UIImage(named: "SampleFeedThumbnail")!,
            title: "title",
            content: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent",
            locate: "부산 태종대",
            likeCount: 1,
            commentCount: 2,
            isLiked: false,
            isSaved: false,
            createdAt: .init()
        )
    }
}
