//
//  ReportViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 1/30/24.
//

import Foundation

final class ReportViewModel: ObservableObject {
    private let apiManager: APIManagerable
    private var postId: Int?
    private var onBlock: () -> Void
    
    @Published var content: String = ""
    
    init(
        apiManager: APIManagerable = TBAPIManager(),
        postId: Int?,
        onBlock: @escaping () -> Void
    ) {
        self.apiManager = apiManager
        self.postId = postId
        self.onBlock = onBlock
    }
    
    func requestReport() async throws {
        guard let id = postId else { return }
        let api = TBTravelNewsAPI.report(id: id, content: content)
        _ = try await apiManager.request(api, encodingType: .json)
    }
    
    func finishReporting() {
        NotificationCenter.default.post(name: .refreshMain, object: nil)
        onBlock()
    }
}
