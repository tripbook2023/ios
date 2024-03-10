//
//  ReportViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 1/30/24.
//

import Foundation

final class ReportViewModel: ObservableObject {
    private let apiManager: APIManagerable
    
    @Published var content: String = ""
    
    init(
        apiManager: APIManagerable = TBAPIManager()
    ) {
        self.apiManager = apiManager
    }
    
    func requestReport(id: Int) async {
        do {
            let api = TBTravelNewsAPI.report(id: id, content: content)
            _ = try await apiManager.request(api, encodingType: .json)
            await MainActor.run {
                NotificationCenter.default.post(name: .refreshMain, object: nil)
            }
        } catch {
            
        }
    }
}
