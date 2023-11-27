//
//  SearchResponse.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/27/23.
//

import Foundation

struct SearchResponse: Decodable {
    let content: [ContentResponse]
    let pageable: PageableResponse
    let size, number: Int
    let sort: SortResponse
    let numberOfElements: Int
    let first: Bool
    let last: Bool
    let empty: Bool
}

struct ContentResponse: Decodable {
    let id: Int
    let title : String
    let content: String
    let author: AuthorResponse
    let imageList: [ImageURLResponse]
    let thumbnail: ImageURLResponse
    let tagList: [String]?
    let heartNum : Int
    let bookmarkNum: Int
    let commentList: [CommentResponse]
    let createdAt : String
    let updatedAt: String
    let heart : Bool
    let bookmark: Bool
}

struct AuthorResponse: Decodable {
    let id: Int
    let name: String
    let profileUrl: String
    let role: String
}

struct ImageURLResponse: Decodable {
    let id: Int
    let url: String
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
