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
    
    init(apiManager: APIManagerable, tokenStorage: TokenStorage) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
    }
    
}
