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
    let location: LocationInfo?
    /// 좋아요 수
    var likeCount: Int
    
    /// 좋아요 여부
    var isLiked: Bool
    
    /// 생성 날짜
    let createdAt: String
    let isReport: Bool
    
    init(
        id: Int,
        author: Author,
        content: String,
        title: String,
        thumbnailURL: String?,
        location: LocationInfo?,
        likeCount: Int,
        isLiked: Bool,
        createdAt: String,
        isReport: Bool
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
        self.location = location
        self.likeCount = likeCount
        self.isLiked = isLiked
        self.createdAt = createdAt.prefix(10).replacingOccurrences(of: "-", with: ".")
        self.isReport = isReport
    }
    
    #if DEBUG
    static var dummy: Self {
        return TravelNewsModel (
            id: UUID().hashValue,
            author: .init(
                id: 0,
                name: "서지혜",
                profileUrl: "https://tripbook-bucket.s3.ap-northeast-2.amazonaws.com/member/profile/51fa4c27-0a0a-4c69-ba79-7ff1b8eaef358964%20bytes.jpeg",
                role: ""
            ),
            content: "\n<p class=\"p1\" style=\"margin: 0.0px 0.0px 0.0px 0.0px; font: 20.0px '.AppleSystemUIFont'; color: #000000\"><span class=\"s1\" style=\"font-family: '.SFUI-Regular'; font-weight: normal; font-style: normal; font-size: 20.00px\">풀풀풀</span></p>\n<p class=\"p2\" style=\"margin: 0.0px 0.0px 0.0px 0.0px; font: 16.0px '.AppleSystemUIFont'; color: #000000\"><span class=\"s2\" style=\"font-family: '.SFUI-Regular'; font-weight: normal; font-style: normal; font-size: 16.00px\">풀풀풀</span></p>\n<p class=\"p3\" style=\"margin: 0.0px 0.0px 0.0px 0.0px; font: 14.0px '.AppleSystemUIFont'; color: #000000\"><span class=\"s3\" style=\"font-family: '.SFUI-Regular'; font-weight: normal; font-style: normal; font-size: 14.00px\">풀풀풀</span></p><img id=518 style=\"border-radius:12.56px;\" src=\"https://tripbook-bucket.s3.ap-northeast-2.amazonaws.com/article/image/7e79c357-4bdb-4a97-9e08-bfb19da16a1557875%20bytes.jpeg\" width=\"335\">\n",
            title: "뚜벅이가 여행하기 좋은 장소 Top 5",
            thumbnailURL: "https://tripbook-bucket.s3.ap-northeast-2.amazonaws.com/member/profile/51fa4c27-0a0a-4c69-ba79-7ff1b8eaef358964%20bytes.jpeg",
            location: nil,
            likeCount: 3,
            isLiked: false,
            createdAt: "2023.06.30",
            isReport: false
        )
    }
    #endif
}
