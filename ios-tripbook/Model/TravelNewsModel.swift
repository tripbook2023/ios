//
//  TravelNewsModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/14.
//

import Foundation

struct TravelNewsModel: Identifiable {
    /// 고유 ID
    let id: Int
    /// Document 작성자
    let author: Author
    
    let content: String
    
    /// 제목
    let title: String
    /// 썸네일 이미지
    let thumbnailURL: URL?
    
    /// 좋아요 수
    var likeCount: Int
    
    /// 좋아요 여부
    var isLiked: Bool
    
    /// 생성 날짜
    let createdAt: String
    
    init(
        id: Int,
        author: Author,
        content: String,
        title: String,
        thumbnailURL: String?,
        likeCount: Int,
        isLiked: Bool,
        createdAt: String
    ) {
        self.id = id
        self.author = author
        self.content = content
        self.title = title
        if let thumbnailURL = thumbnailURL {
            self.thumbnailURL = URL(string: thumbnailURL)
        } else {
            self.thumbnailURL = nil
        }
        self.likeCount = likeCount
        self.isLiked = isLiked
        self.createdAt = createdAt.prefix(10).replacingOccurrences(of: "-", with: ".")
    }
    
    #if DEBUG
    static var dummy: Self {
        return TravelNewsModel (
            id: UUID().hashValue,
            author: .init(
                name: "서지혜",
                profileUrl: "https://tripbook-bucket.s3.ap-northeast-2.amazonaws.com/member/profile/51fa4c27-0a0a-4c69-ba79-7ff1b8eaef358964%20bytes.jpeg",
                role: ""
            ),
            content: "xxxx",
            title: "뚜벅이가 여행하기 좋은 장소 Top 5",
            thumbnailURL: "https://tripbook-bucket.s3.ap-northeast-2.amazonaws.com/member/profile/51fa4c27-0a0a-4c69-ba79-7ff1b8eaef358964%20bytes.jpeg",
            likeCount: 3,
            isLiked: false,
            createdAt: "2023.06.30"
        )
    }
    #endif
}
