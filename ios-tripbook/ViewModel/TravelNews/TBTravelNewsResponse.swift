//
//  TBTravelNewsResponse.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/28.
//

import Foundation
// MARK: - TBNews
struct TBTravelNewsResponse: Decodable {
    let id: Int
    let title, content: String
    let author: Author
    let imageList: [Media]
    let thumbnail: Media
    let tagList: [String]
    let heartNum: Int
    let bookmarkNum: Int
    let commentList: [String]
    let createdAt: String
    let updatedAt: String
    let heart: Bool
    let bookmark: Bool
    
    var toDomain: TravelNews {
        let author = AuthorRepresentable(id: author.id, name: author.name, profileURL: author.profileURL, role: author.role)
        
        return TravelNews(author: author, title: title, thumbnailURL: thumbnail.url, likeCount: heartNum, commentCount: commentList.count, isLiked: heart, isSaved: false, createdAt: createdAt)
    }
}

// MARK: - Author
struct Author: Codable {
    let id: Int
    let name, profileURL, role: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileURL = "profileUrl"
        case role
    }
}

// MARK: - Thumbnail
struct Media: Codable {
    let id: Int
    let url: String
}
