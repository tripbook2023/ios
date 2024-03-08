//
//  SignupProfileNameViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/15.
//

import Foundation

class SignupProfileNameViewModel: ObservableObject {
    private let apiManager: APIManagerable
    
    @Published var nicknameText: String = ""
    @Published var nicknameTextState: NicknameTextState = .none
    
    @Published var navigationTrigger: Bool = false
    
    init(apiManager: APIManagerable = TBAPIManager()) {
        self.apiManager = apiManager
    }
    
    func checkValidationNickname() {
        let regex = "^[가-힣a-zA-Z0-9]*$"
        
        if self.nicknameText.count > 10 {
            self.nicknameTextState = .invalid
        } else if self.nicknameText.range(of: regex, options: .regularExpression) == nil {
            self.nicknameTextState = .useSpecialCharacters
        } else {
            self.nicknameTextState = .none
        }
    }
}

extension SignupProfileNameViewModel: SignupProfileNameViewDelegate {
    func onChangedNicknameTextField() {
        checkValidationNickname()
    }
    
    func onSubmittedNicknameTextField() {
        if self.nicknameTextState == .none {
            Task {
                do {
                    let isValid = try await apiManager.request(
                        TBMemberAPI.nicknameValidate(name: nicknameText),
                        type: NicknameValidationResponse.self,
                        encodingType: .url
                    ).toDomain
                    await MainActor.run {
                        if !isValid {
                            nicknameTextState = .duplicate
                        } else {
                            nicknameTextState = .none
                        }
                    }
                } catch {
                    
                }
            }
        }
    }
    
    func didTapDoneButton() {
        self.navigationTrigger.toggle()
    }
}
