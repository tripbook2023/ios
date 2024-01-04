//
//  RegisterTravelNewsViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/29/23.
//

import Foundation

final class RegisterTravelNewsViewModel: ObservableObject {
    private var apiManager: APIManagerable
    
    @Published var tempItems: [TravelNewsModel] = []
    @Published var isShowTemporaryStorageListView = false
    @Published var isShowSearchLocationView = false
    
    init(apiManager: APIManagerable = TBAPIManager()) {
        self.apiManager = apiManager
    }
    
    func fatchTempList() {
        Task {
            do {
                let api = TBMemberAPI.selectTemp()
                let result = try await apiManager.request(api, type: [ContentResponse].self).map { $0.toDomain }
                await MainActor.run {
                    tempItems = result
                }
            } catch {
                // 에러처리
            }
           
        }
    }
    
    
}
