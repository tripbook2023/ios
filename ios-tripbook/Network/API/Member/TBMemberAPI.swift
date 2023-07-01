//
//  TBMemberAPI.swift
//  ios-tripbook
//
//  Created by DDang on 6/25/23.
//

import Foundation
import Alamofire

struct TBMemberAPI {
    static func signup(_ parameter: SignupRequest, completion: @escaping () -> Void) {
        TBAPIManager.shared.sessionManager.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(parameter.name.data(using: .utf8)!, withName: "name")
                multipartFormData.append(parameter.email.data(using: .utf8)!, withName: "email")
                if let imageFile = parameter.imageFile?.pngData() {
                    print(imageFile)
                    multipartFormData.append(imageFile, withName: "imageFile", fileName: "\(imageFile).png", mimeType: "image/png")
                }
                multipartFormData.append(parameter.termsOfService.description.data(using: .utf8)!, withName: "termsOfService")
                multipartFormData.append(parameter.termsOfPrivacy.description.data(using: .utf8)!, withName: "termsOfPrivacy")
                multipartFormData.append(parameter.termsOfLocation.description.data(using: .utf8)!, withName: "termsOfLocation")
                multipartFormData.append(parameter.marketingConsent.description.data(using: .utf8)!, withName: "marketingConsent")
                multipartFormData.append(parameter.gender.data(using: .utf8)!, withName: "gender")
                multipartFormData.append(parameter.birth.data(using: .utf8)!, withName: "birth")
            },
            to: TBAPIPath.base + TBAPIPath.Member.signup,
            method: .post,
            headers: [
                .contentType("multipart/form-data")
            ]
        )
        .validate(statusCode: 200..<300)
        .response { response in
            switch response.result {
            case .success(let value):
                completion()
                break
            case .failure(let failure):
                print("signup Error: \(failure)")
            }
        }
    }
    
    static func validationNickname(_ parameter: NicknameValidationRequest, completion: @escaping (Bool) -> Void) {
        guard let data: Data = try? JSONEncoder().encode(parameter) else { return }
        let router = TBAPIRouter(path: TBAPIPath.Member.nicknameValidate, parameters: data, apiType: .member)
        
        TBAPIManager.shared.sessionManager.request(router).responseDecodable(of: NicknameValidationResponse.self, completionHandler: { response in
            switch response.result {
            case .success(let value):
                completion(value.toDomain)
                break
            case .failure(let error):
                print("validationNickname Error: \(error)")
            }
        })
    }
}
