//
//  TBArticlesAPIPath.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/09/30.
//

import Foundation

struct TBArticlesAPIPath {
    let search = "/articles"
    let save = "/articles"
    let temp = "/articles/temp"
    func like(id: String) -> String { "/articles/\(id)/like" }
    func comments(id: Int) -> String { "/articles/\(id)/comments" }
    func bookmark(id: Int) -> String { "/articles/\(id)/bookmark" }
    func detail(id: Int) -> String { "/articles/\(id)" }
    func delete(id: Int) -> String { "/articles/\(id)" }
    func deleteComment(commentId: Int) -> String { "/articles/comments/\(commentId)" }
}
