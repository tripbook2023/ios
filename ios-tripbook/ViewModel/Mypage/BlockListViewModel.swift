//
//  BlockListViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 4/11/24.
//

import Foundation

final class BlockListViewModel: ObservableObject {
    private let apiManager: APIManagerable
    
    @Published var blockUsers: [Author] = []
    
    init(apiManager: APIManagerable = TBAPIManager()) {
        self.apiManager = apiManager
    }
    
    func requestBlockList() {
        Task {
            do {
                let api = TBUserBlockAPI.getBlocks()
                let result = try await apiManager.request(
                    api,
                    type: [AuthorResponse].self,
                    encodingType: .url
                ).map { $0.toDomain }
                await MainActor.run { blockUsers = result }
            } catch {
                
            }
        }
    }
    
    func requestDeleteBlock(index: Int) {
        Task {
            do {
                let id = blockUsers[index].id
                let api = TBUserBlockAPI.deleteBlocks(id: id)
                let _ = try await apiManager.request(
                    api,
                    encodingType: .url
                )
                requestBlockList()
                await MainActor.run {
                    NotificationCenter.default.post(name: .refreshMain, object: nil)
                }
            } catch {
                
            }
        }
    }
}
