//
//  MypageViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/15/23.
//

import Foundation
import Combine

@MainActor
final class MypageViewModel: ObservableObject {
    private var dataStorage: DataStorage
    private var tokenStorage: TokenStorage
    private var anyCancellable = Set<AnyCancellable>()
    
    @Published var isPresentInquiryView = false
    @Published var userInfo: MyProfile?
    @Published var isShowPopup: Bool = false
    
    init(
        dataStorage: DataStorage = .shared,
        tokenStorage: TokenStorage = .shared
    ) {
        self.dataStorage = dataStorage
        self.tokenStorage = tokenStorage
        dataStorage.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
            self?.userInfo = $0
        }.store(in: &self.anyCancellable)
    }
    
    func deleteToken() {
        tokenStorage.deleteTokens()
    }
}
