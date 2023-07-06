//
//  DataObject.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/20.
//

import Foundation

/// 전역 Data 관리
/// - Author: 김민규
/// - Date: 2023/05/20
class DataStorage {
    static let shared = DataStorage()
    
    /// User Data
    var user: MyProfile?
    
    init() {
        self.getUser()
    }
    
    func getUser() {
        TBMemberAPI.getUser { user in
            print(user.info?.email)
            self.user = user
        }
    }
}
