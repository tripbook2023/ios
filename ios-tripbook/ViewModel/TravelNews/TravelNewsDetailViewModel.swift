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
    
    @Published var travelNews: TravelNews?
    
    init(apiManager: APIManagerable, tokenStorage: TokenStorage) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
    }
    
    func loadData() async {
        let api = TBTravelNewsAPI.search(accessToken: tokenStorage.accessToken ?? "", id: "74")
        
        do {
            let data = try await apiManager.request(api)
            let travel = try JSONDecoder().decode(TBTravelNewsResponse.self, from: data).toDomain
            
            travelNews = travel
        } catch {
            print("ERROR: \(error)")
        }
    }
    
}
