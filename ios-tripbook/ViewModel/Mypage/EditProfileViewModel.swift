//
//  EditProfileViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/22/23.
//

import Foundation

import Kingfisher
import AVFoundation

final class EditProfileViewModel: ObservableObject {
    private var apiManager: APIManagerable
    private var tokenStorage: TokenStorage
    private var dataStorage: DataStorage
    
    init(
        apiManager: APIManagerable = TBAPIManager(),
        tokenStorage: TokenStorage = .shared,
        dataStorage: DataStorage = .shared
    ) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
        self.dataStorage = dataStorage
        
        self.newName = dataStorage.user?.info?.name ?? ""
        guard let url = URL(string: dataStorage.user?.profileImageURL ?? "") else { return }
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] in
            self?.newProfileImageData = try? $0.get().data()
        }
        
    }
    @Published var newName: String
    @Published var newProfileImageData: Data?
    @Published var warningMessage: String?
    @Published var isDismiss: Bool = false
    @Published var isShowImagePicker: Bool = false
    @Published var isShowOptionView: Bool = false
    @Published var isShowCameraView: Bool = false
    
    func checkValidationNickname() {
        let regex = "[가-힣a-zA-Z0-9]"
        
        if self.newName.count > 10 {
            self.warningMessage = NicknameTextState.Invalid.getWarningMessage()
        } else if !((self.newName.range(of: regex, options: .regularExpression)) != nil) {
            self.warningMessage = NicknameTextState.Invalid.getWarningMessage()
        } else {
            checkNicknameUseSpecialCharacters()
        }
    }
    
    private func checkNicknameUseSpecialCharacters() {
        let regex = #"[`~!@#$%^&*|\\\'\";:\/?]"#
        
        if (self.newName.range(of: regex, options: .regularExpression)) != nil {
            self.warningMessage = NicknameTextState.UseSpecialCharacters.getWarningMessage()
        } else {
            self.warningMessage = nil
        }
    }
    
    func checkNicknameDuplication() {
        guard newName != dataStorage.user?.info?.name else {
            self.warningMessage = nil
            return
        }
        Task {
            do {
                let api = TBMemberAPI.nicknameValidate(name: newName)
                try await apiManager.request(api)
                DispatchQueue.main.async {
                    self.warningMessage = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self.warningMessage = NicknameTextState.Duplicate.getWarningMessage()
                }
            }
        }
    }
    
    func updateProfile() {
        Task {
            do {
                let api = TBMemberAPI.update(
                    accessToken: tokenStorage.accessToken ?? "",
                    name: newName == dataStorage.user?.info?.name ? nil : newName,
                    images: ["imageFile": [newProfileImageData]]
                )
                try await apiManager.upload(api)
                DispatchQueue.main.async {
                    self.dataStorage.getUser()
                    self.isDismiss = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.isDismiss = false
                }
            }
        }
    }
}

extension EditProfileViewModel: SignupProfileImageSelectOptionViewDelegate {
    func didTapCancelButton() {
        isShowOptionView = false
    }
    
    func didTapSelectPhotoButton() {
        isShowImagePicker = true
        isShowOptionView = false
    }
    
    func didTapCameraButton() {
        isShowCameraView = true
        isShowOptionView = false
    }
    
    func didTapUseDefaultImageButton() {
        newProfileImageData = nil
        isShowOptionView = false
    }
}
