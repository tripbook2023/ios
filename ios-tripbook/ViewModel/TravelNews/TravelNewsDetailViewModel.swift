//
//  TravelNewsDetailViewModel.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/27.
//

import Foundation

class TravelNewsDetailViewModel: ObservableObject {
    private let dataStorage = DataStorage.shared
    
    private let apiManager: APIManagerable
    private let tokenStorage: TokenStorage
    let id: String
    
    @Published var travelNews: TravelNewsModel?
    @Published var isDownScroll: Bool = false
    var offset: CGFloat = 0
    
    init(
        apiManager: APIManagerable = TBAPIManager(),
        tokenStorage: TokenStorage = .shared,
        id: String
    ) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
        self.id = id
    }
    
    func setOffset(_ offset: CGFloat) {
        if self.offset < offset {
            isDownScroll = false
        } else {
            isDownScroll = true
        }
        self.offset = offset
    }
    
    func loadData() async {
        let api = TBTravelNewsAPI.search(id: id)
        
        do {
            let travel = try await apiManager.request(api, type: ContentResponse.self, encodingType: .url).toDomain
            
            await MainActor.run {
                self.travelNews = travel
            }
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    func likeButtonDidTap() {
        Task {
            do {
                let api = TBTravelNewsAPI.like(id: self.id)
                let result = try await apiManager.request(api, type: LikeResponse.self, encodingType: .url)
                await MainActor.run {
                    travelNews?.isLiked = result.heart
                    travelNews?.likeCount = result.heartNum
                }
            } catch {
                
            }
        }
    }
    
}
