//
//  OnboardingViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/24.
//

import Foundation
@MainActor
class OnboardingViewModel: ObservableObject {
    @Published var isPresentRoot: Bool = false
    @Published var isHidden = false
    @Published var isAnimationFinish = false
    
    private let apiManager: APIManagerable
    private let tokenStorage: TokenStorage
    
    init(
        apiManager: APIManagerable = TBAPIManager(),
        tokenStorage: TokenStorage = .shared
    ) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
        requestTokenReissue(refreshToken: tokenStorage.refreshToken ?? "")
    }
    
    private func requestTokenReissue(refreshToken: String) {
        Task {
            do {
                let api = TBMemberAPI.refreshToken(refreshToken)
                _ = try await apiManager.request(api, encodingType: .url)
                isPresentRoot = true
            } catch {
                isPresentRoot = false
            }
            
        }
    }
}
