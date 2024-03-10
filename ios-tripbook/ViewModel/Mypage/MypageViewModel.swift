//
//  MypageViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/15/23.
//

import Foundation
import Combine

final class MypageViewModel: ObservableObject {
    private var dataStorage: DataStorage
    private var tokenStorage: TokenStorage
    private var apiManager: APIManagerable
    private var anyCancellable = Set<AnyCancellable>()
    
    @Published var isPresentInquiryView = false
    @Published var userInfo: MyProfile?
    @Published var isShowLogOutPopup: Bool = false
    @Published var isShowMemberDeletePopup: Bool = false
    @Published var deleteName: String = ""
    @Published var warningMessage: String?
    
    init(
        dataStorage: DataStorage = .shared,
        tokenStorage: TokenStorage = .shared,
        apiManager: APIManagerable = TBAPIManager()
    ) {
        self.dataStorage = dataStorage
        self.tokenStorage = tokenStorage
        self.apiManager = apiManager
        dataStorage.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
            self?.userInfo = $0
        }.store(in: &self.anyCancellable)
    }
    
    func deleteToken() {
        tokenStorage.deleteTokens()
    }
    
    func deleteMember(completion: () -> Void) async {
        do {
            guard let email = dataStorage.user?.info?.email else { return }
            let api = TBMemberAPI.delete(email: email)
            _ = try await apiManager.request(api, encodingType: .url)
            deleteToken()
            await MainActor.run {
                completion()
            }
        } catch {
            print("deleteMember error: " + error.localizedDescription)
        }
        
    }
    
    func checkValidationNickname() {
        let regex = "^[가-힣a-zA-Z0-9]*$"
        
        if self.deleteName.count > 10 {
            self.warningMessage = NicknameTextState.invalid.getWarningMessage()
        } else if self.deleteName.range(of: regex, options: .regularExpression) == nil {
            self.warningMessage = NicknameTextState.useSpecialCharacters.getWarningMessage()
        } else {
            checkMyName()
        }
    }
    
    private func checkMyName() {
        if deleteName == dataStorage.user?.info?.name {
            self.warningMessage = nil
        } else {
            self.warningMessage = NicknameTextState.notSame.getWarningMessage()
        }
    }
}
