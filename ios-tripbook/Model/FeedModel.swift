//
//  FeedModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/04.
//

import Foundation
import UIKit

struct FeedModel {
    let user: User
    
    let image: UIImage
    var likeCount: Int
    var commentCount: Int
    var isSaved: Bool
    let title: String
    let content: String
    
    var isLiked: Bool
    let createdAt: Date
    
    struct User {
        let name: String
        let profileImage: UIImage
    }
    
    
}
