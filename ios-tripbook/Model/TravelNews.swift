//
//  TravelNews.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/28.
//

import Foundation

struct TravelNews {
    let id: Int = 0
    let author: AuthorRepresentable
    let title: String
    let content: String
    let thumbnailURL: String
    var likeCount: Int
    var commentCount: Int
    var isLiked: Bool
    var isSaved: Bool
    let createdAt: String
    
    init(author: AuthorRepresentable,
         title: String,
         content: String,
         thumbnailURL: String,
         likeCount: Int,
         commentCount: Int,
         isLiked: Bool,
         isSaved: Bool,
         createdAt: String
    ) {
        self.author = author
        self.title = title
        self.content = content
        self.thumbnailURL = thumbnailURL
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.isLiked = isLiked
        self.isSaved = isSaved
        self.createdAt = createdAt
    }
}
