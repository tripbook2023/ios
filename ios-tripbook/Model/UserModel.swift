//
//  UserModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/18.
//

import Foundation
import UIKit

/// 사용자 Data Model
/// - Author: 김민규
/// - Date: 2023/05/20
struct User {
    /// 사용자 권한
    enum Authority {
        /// 일반
        case usual
        
        /// 에디터
        case editor
        
        /// 관리자
        case manager
    }
    
    /// 사용자 권한
    let authority: Authority
    
    /// 이름(닉네임)
    let name: String
    /// 프로필 이미지
    let profileImage: UIImage
}
