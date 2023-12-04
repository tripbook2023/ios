//
//  TravelNewsModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/14.
//

import Foundation

struct TravelNewsModel {
    /// 고유 ID
    let id: Int
    /// Document 작성자
    let author: Author
    
    /// 제목
    let title: String
    /// 썸네일 이미지
    let thumbnailURL: String?
    
    /// 좋아요 수
    var likeCount: Int
    
    /// 좋아요 여부
    var isLiked: Bool
    
    /// 생성 날짜
    let createdAt: String
    
    init(
        id: Int,
        author: Author,
        title: String,
        thumbnailURL: String?,
        likeCount: Int,
        isLiked: Bool,
        createdAt: String
    ) {
        self.id = id
        self.author = author
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.likeCount = likeCount
        self.isLiked = isLiked
        self.createdAt = createdAt
    }
    
    #if DEBUG
    static var dummy: Self {
        return TravelNewsModel (
            id: UUID().hashValue,
            author: .init(name: "서지혜", profileUrl: "", role: ""),
            title: "뚜벅이가 여행하기 좋은 장소 Top 5",
            thumbnailURL: Bundle.main.path(forResource: "SampleFeedThumbnail", ofType: "jpg", inDirectory: "Assets.xcassets"),
            likeCount: 1,
            isLiked: false,
            createdAt: "2023.06.30"
        )
    }
    #endif
}
