//
//  SignupViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/14.
//

import Foundation
import SwiftUI
import Combine

class SignupViewModel: ObservableObject {
    private let apiManager: APIManagerable
    private let tokenStorage: TokenStorage
    
    init(
        apiManager: APIManagerable = TBAPIManager(),
        tokenStorage: TokenStorage = .shared
    ) {
        self.apiManager = apiManager
        self.tokenStorage = tokenStorage
    }
    
    enum SocialLoginMethod {
        case KAKAO
        case APPLE
    }
    
    var userData = RegisterationUser()
    
    func registerUserEmail(_ email: String) {
        self.userData.email = email
    }
    
    func registerUserTerms(_ terms: [String:Bool]) {
        self.userData.terms = terms
    }
    
    func registerUserName(_ name: String) {
        self.userData.name = name
    }
    
    func registerUserProfileImage(_ image: UIImage) {
        self.userData.profileImage = image
    }
    
    func registerUserGender(_ gender: Gender) {
        self.userData.gender = gender
    }
    
    func registerUserBirth(_ birth: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.userData.birth = dateFormatter.string(from: birth)
    }
    
    func registerUser() -> AnyPublisher<Void, Error> {
        print("User: ", self.userData)
        let request: SignupRequest = .init(
            name: self.userData.name,
            email: self.userData.email,
            termsOfService: self.userData.terms[Term.Service.rawValue]!,
            termsOfPrivacy: self.userData.terms[Term.PersonalInfo.rawValue]!,
            termsOfLocation: self.userData.terms[Term.Location.rawValue]!,
            marketingConsent: self.userData.terms[Term.Marketing.rawValue]!,
            gender: self.userData.gender!.rawValue,
            birth: self.userData.birth
        )
        
        return Future<Void, Error> { [weak self] promise in
            guard let owner = self else { return }
            let imageData = owner.userData.profileImage?.jpegData(compressionQuality: 0.5)
            Task {
                do {
                    let response = try await owner.apiManager.upload(
                        TBMemberAPI.signup(request: request, images: ["imageFile": [imageData]]),
                        type: SignupResponse.self
                    )
                    owner.tokenStorage.setTokens(accessToken: response.accessToken, refreshToken: response.refreshToken)
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension SignupViewModel: SignupSocialViewModelDelegate {
    func completionAuthentication(email: String) {
        self.registerUserEmail(email)
        
        print("Current User Data: ", self.userData)
    }
}
