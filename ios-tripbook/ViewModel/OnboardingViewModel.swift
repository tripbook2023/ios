//
//  OnboardingViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/24.
//

import Foundation
@MainActor
class OnboardingViewModel: ObservableObject {
    enum ViewState {
        case root
        case login
    }
    
    @Published var presentView: ViewState? = nil
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
                let result = try await apiManager.request(TBMemberAPI.tokenReissue(refreshToken: refreshToken), type: TokenReissueResponse.self)
                tokenStorage.setTokens(accessToken: result.accessToken, refreshToken: result.refreshToken)
                presentView = .root
            } catch {
                presentView = .login
            }
            
        }
    }
}
