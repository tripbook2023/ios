//
//  DataObject.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/20.
//

import Foundation
import Combine

/// 전역 Data 관리
/// - Author: 김민규
/// - Date: 2023/05/20
class DataStorage: ObservableObject {
    static let shared = DataStorage()
    
    private let apiManager: APIManagerable
    
    init(apiManager: APIManagerable = TBAPIManager()) {
        self.apiManager = apiManager
        self.getUser()
    }
    /// User Data
    @Published var user: MyProfile?
    
    func getUser() {
        Task {
            guard let profile = try? await apiManager.request(
                TBMemberAPI.select(),
                type: GetUserResponse.self
            ).toDomain else { return }
            user = profile
        }
    }
}
