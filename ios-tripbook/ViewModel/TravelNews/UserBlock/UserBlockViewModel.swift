//
//  UserBlockViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 4/10/24.
//

import Foundation

final class UserBlockViewModel: ObservableObject {
    private let apiManager: APIManagerable
    let user: Author
    private var onBlock: () -> Void
    
    init(
        apiManager: APIManagerable = TBAPIManager(),
        user: Author,
        onBlock: @escaping () -> Void
    ) {
        self.apiManager = apiManager
        self.user = user
        self.onBlock = onBlock
    }
    
    func requestBlock() async throws {
        let api = TBUserBlockAPI.addBlocks(id: user.id)
        _ = try await apiManager.request(api, encodingType: .url)
    }
    
    func finishBlocking() {
        NotificationCenter.default.post(name: .refreshMain, object: nil)
        onBlock()
    }
}
