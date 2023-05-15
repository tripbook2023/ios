//
//  TravelNewsModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/14.
//

import Foundation
import UIKit

/// 여행 소식 Data Model
/// - Author: 김민규
/// - Date: 2023/05/15
class TravelNewsModel {
    /// 사용자 Data Model
    let user: User
    
    /// 제목
    let title: String
    /// 썸네일 이미지
    let image: UIImage
    
    /// 좋아요 수
    var likeCount: Int
    /// 댓글 수
    var commentCount: Int
    /// 좋아요 여부
    var isLiked: Bool
    /// 저장 여부
    var isSaved: Bool
    
    /// 생성 날짜
    let createdAt: Date
    
    /// 사용자 Data Model
    struct User {
        /// 이름(닉네임)
        let name: String
        /// 프로필 이미지
        let profileImage: UIImage
    }
    
    /// 여행 소식 Data Model Initializer
    /// - Parameters:
    ///     - user: 사용자 Data Model
    ///     - title: 제목
    ///     - image: 썸네일 이미지
    ///     - likeCount: 좋아요 수
    ///     - commentCount: 댓글 수
    ///     - isLiked: 좋아요 여부
    ///     - isSaved: 저장 여부
    ///     - createdAt: 생성 날짜
    init(
        user: User,
        title: String,
        image: UIImage,
        likeCount: Int,
        commentCount: Int,
        isLiked: Bool,
        isSaved: Bool,
        createdAt: Date
    ) {
        self.user = user
        self.title = title
        self.image = image
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.isLiked = isLiked
        self.isSaved = isSaved
        self.createdAt = createdAt
    }
}

/// 여행 소식 Dummy Data Model
/// - Author: 김민규
/// - Date: 2023/05/15
class SampleTravelNewsModel: TravelNewsModel {
    /// 여행 소식 Dummy Data Model Initializer
    init() {
        super.init(
            user: .init(name: "서지혜", profileImage: UIImage(named: "SampleProfileImage")!),
            title: "뚜벅이가 여행하기 좋은 장소 Top 5",
            image: UIImage(named: "SampleFeedThumbnail")!,
            likeCount: 1,
            commentCount: 2,
            isLiked: false,
            isSaved: false,
            createdAt: .init()
        )
    }
}
