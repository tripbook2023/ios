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
class DataObject: ObservableObject {
    /// User Data
    @Published var user: User? = .init(authority: .manager, name: "홍길동", profileImage: .init(named: "SampleProfileImage")!)
}
