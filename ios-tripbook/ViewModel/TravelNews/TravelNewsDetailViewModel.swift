//
//  TravelNewsDetailViewModel.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/27.
//

import Foundation

class TravelNewsDetailViewModel: ObservableObject {
    private let dataStorage: DataStorage
    private let apiManager: APIManagerable
    private let tokenStorage: TokenStorage
    
    @Published var travelNews: TravelNewsModel
    @Published var isDownScroll: Bool = false
    var offset: CGFloat = 0
    
    init(
        apiManager: APIManagerable = TBAPIManager(),
        tokenStorage: TokenStorage = .shared,
        dataStorage: DataStorage = .shared,
        item: TravelNewsModel
    ) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
        self.dataStorage = dataStorage
        self.travelNews = item
    }
    
    var isOwner: Bool {
        dataStorage.user?.info?.name == travelNews.author.name
    }
    
    func setOffset(_ offset: CGFloat) {
        if self.offset < offset {
            isDownScroll = false
        } else {
            isDownScroll = true
        }
        self.offset = offset
    }
    
    func deletePost() async {
        do {
            let api = TBTravelNewsAPI.delete(id: travelNews.id)
            _ = try await apiManager.request(api, encodingType: .url)
        } catch {
            
        }
    }
    
    func likeButtonDidTap() {
        Task {
            do {
                let api = TBTravelNewsAPI.like(id: "\(travelNews.id)")
                let result = try await apiManager.request(api, type: LikeResponse.self, encodingType: .url)
                await MainActor.run {
                    travelNews.isLiked = result.heart
                    travelNews.likeCount = result.heartNum
                }
            } catch {
                
            }
        }
    }
}
