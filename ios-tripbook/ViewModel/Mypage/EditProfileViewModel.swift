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
        guard let url = dataStorage.user?.profileImageURL else { return }
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
    var isUseDefaultProfile: Bool = false
    var isChangedProfile: Bool = false
    
    func checkValidationNickname() {
        let regex = "^[가-힣a-zA-Z0-9]*$"
        
        if self.newName.count > 10 {
            self.warningMessage = NicknameTextState.invalid.getWarningMessage()
        } else if self.newName.range(of: regex, options: .regularExpression) == nil {
            self.warningMessage = NicknameTextState.useSpecialCharacters.getWarningMessage()
        } else {
            self.warningMessage = nil
        }
    }
    
    func checkNicknameDuplication() {
        guard newName != dataStorage.user?.info?.name else {
            self.warningMessage = nil
            return
        }
        guard warningMessage == nil else { return }
        Task {
            do {
                let api = TBMemberAPI.nicknameValidate(name: newName)
                try await apiManager.request(api, encodingType: .url)
                await MainActor.run {
                    self.warningMessage = nil
                }
            } catch {
                await MainActor.run {
                    self.warningMessage = NicknameTextState.duplicate.getWarningMessage()
                }
            }
        }
    }
    
    func updateProfile() {
        Task {
            do {
                let api = TBMemberAPI.update(
                    name: newName == dataStorage.user?.info?.name ? nil : newName,
                    isDefaultProfile: isUseDefaultProfile,
                    images: ["imageFile": [isChangedProfile ? newProfileImageData : nil]]
                )
                try await apiManager.upload(api)
                await MainActor.run {
                    self.dataStorage.getUser()
                    self.isDismiss = true
                }
            } catch {
                await MainActor.run {
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
