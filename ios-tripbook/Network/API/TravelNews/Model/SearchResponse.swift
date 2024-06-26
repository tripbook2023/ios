//
//  SearchResponse.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/27/23.
//

import Foundation

class SearchResponse: Decodable {
    let content: [ContentResponse]
    let pageable: PageableResponse
    let size: Int
    let number: Int
    let sort: SortResponse
    let numberOfElements: Int
    let first: Bool
    let last: Bool
    let empty: Bool
    
    var toDomain: [TravelNewsModel] {
        return content.map { $0.toDomain }
    }
}

struct ContentResponse: Decodable {
    let id: Int
    let title: String
    let content: String
    let author: AuthorResponse
    let thumbnailUrl: String?
    let tagList: [String]?
    let heartNum: Int
    let bookmarkNum: Int
    let commentList: [CommentResponse]
    let location: [LocationResponse]?
    let createdAt: String
    let updatedAt: String
    let heart: Bool
    let bookmark: Bool
    let report: Bool
    
    var toDomain: TravelNewsModel {
        return TravelNewsModel(
            id: id,
            author: author.toDomain,
            content: content,
            title: title, 
            thumbnailURL: thumbnailUrl,
            location: self.location?.first?.toDomain,
            likeCount: heartNum,
            isLiked: heart,
            createdAt: createdAt,
            isReport: report
        )
    }
}

struct AuthorResponse: Decodable {
    let id: Int
    let name: String
    let profileUrl: String?
    let role: String
    
    var toDomain: Author {
        return Author(
            id: id,
            name: name,
            profileUrl: profileUrl,
            role: role)
    }
}

struct PageableResponse: Decodable {
    let sort: SortResponse
    let offset: Int
    let pageNumber: Int
    let pageSize: Int
    let paged: Bool
    let unpaged: Bool
}

struct SortResponse: Decodable {
    let empty: Bool
    let unsorted: Bool
    let sorted: Bool
}

struct CommentResponse: Decodable {
    let id: Int
    let content: String
    let author: AuthorResponse
    let childList: [String]
    let createdAt: String
    let updateAt: String
}

struct LocationResponse: Decodable {
    let id: Int
    let locationX: String
    let locationY: String
    let name: String
    
    var toDomain: LocationInfo {
        return LocationInfo(placeName: name, x: locationX, y: locationY)
    }
}
