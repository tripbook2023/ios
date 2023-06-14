//
//  Document.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/18.
//

import Foundation
import UIKit

/// 게시글 Model
/// - Author: 김민규
/// - Date: 2023/05/20
class Document: Identifiable {
    /// 고유 ID
    let id: UUID = UUID()
    /// Document 작성자
    let author: User
    
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
    
    init(
        author: User,
        title: String,
        image: UIImage,
        likeCount: Int,
        commentCount: Int,
        isLiked: Bool,
        isSaved: Bool,
        createdAt: Date
    ) {
        self.author = author
        self.title = title
        self.image = image
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.isLiked = isLiked
        self.isSaved = isSaved
        self.createdAt = createdAt
    }
}
