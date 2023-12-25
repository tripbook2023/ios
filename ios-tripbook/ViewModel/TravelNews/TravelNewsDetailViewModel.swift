//
//  TravelNewsDetailViewModel.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/27.
//

import Foundation

class TravelNewsDetailViewModel: ObservableObject {
    let dataStorage = DataStorage.shared
    
    let apiManager: APIManagerable
    let tokenStorage: TokenStorage
    let id: String
    
    @Published var travelNews: TravelNewsModel?
    
    init(
        apiManager: APIManagerable = TBAPIManager(),
        tokenStorage: TokenStorage = .shared,
        id: String
    ) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
        self.id = id
    }
    
    func loadData() async {
        let api = TBTravelNewsAPI.search(id: id)
        
        do {
            let travel = try await apiManager.request(api, type: ContentResponse.self).toDomain
            
            await MainActor.run {
                self.travelNews = travel
            }
        } catch {
            print("ERROR: \(error)")
        }
    }
    
}
