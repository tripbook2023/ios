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
class DataStorage: ObservableObject {
    static var shared = DataStorage()
    
    private let apiManager: APIManagerable
    private let tokenStorage: TokenStorage
    
    init(apiManager: APIManagerable = TBAPIManager(), tokenStorage: TokenStorage = .shared) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
    }
    /// User Data
    @Published var user: MyProfile?
    
    func getUser() {
        Task {
            guard let profile = try? await apiManager.request(
                TBMemberAPI.select(),
                type: GetUserResponse.self,
                encodingType: .url
            ).toDomain else { return }
            await MainActor.run {
                user = profile
            }
        }
    }
}
