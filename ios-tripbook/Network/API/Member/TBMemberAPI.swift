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
                if let imageFile = parameter.imageFile?.jpegData(compressionQuality: 0.5) {
                    print(imageFile)
                    multipartFormData.append(imageFile, withName: "imageFile", fileName: "\(imageFile).jpeg", mimeType: "image/jpeg")
                }
                multipartFormData.append(parameter.termsOfService.description.data(using: .utf8)!, withName: "termsOfService")
                multipartFormData.append(parameter.termsOfPrivacy.description.data(using: .utf8)!, withName: "termsOfPrivacy")
                multipartFormData.append(parameter.termsOfLocation.description.data(using: .utf8)!, withName: "termsOfLocation")
                multipartFormData.append(parameter.marketingConsent.description.data(using: .utf8)!, withName: "marketingConsent")
                multipartFormData.append(parameter.gender.data(using: .utf8)!, withName: "gender")
                multipartFormData.append(parameter.birth.data(using: .utf8)!, withName: "birth")
            },
            to: TBAPIPath.base + TBAPIPath.Member.signup,
            usingThreshold: UInt64.init(),
            method: .post,
            headers: [
                .contentType("multipart/form-data"),
                .userAgent("IOS_APP")
            ]
        )
        .validate(statusCode: 200..<300)
        .response { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonDecoder = JSONDecoder()
                    let res = try jsonDecoder.decode(SignupResponse.self, from: value!)
                    
                    TokenStorage.shared.setTokens(accessToken: res.accessToken, refreshToken: res.refreshToken)
                    
                    completion()
                    break
                } catch(let error) {
                    print("signup Error: \(error)")
                    break
                }
            case .failure(let failure):
                print("signup Error: \(failure)")
                break
            }
        }
    }
    
    static func validationNickname(_ parameter: NicknameValidationRequest, completion: @escaping (Bool) -> Void) {
        guard let data: Data = try? JSONEncoder().encode(parameter) else { return }
        let router = TBAPIRouter(path: TBAPIPath.Member.nicknameValidate, parameters: data, apiType: .member)
        
//        TBAPIManager.shared.sessionManager.request(router).responseDecodable(of: NicknameValidationResponse.self, completionHandler: { response in
//            switch response.result {
//            case .success(let value):
//                completion(value.toDomain)
//                break
//            case .failure(let error):
//                print("validationNickname Error: \(error)")
//            }
//        })
        TBAPIManager.shared.sessionManager.request(router).validate(statusCode: 200...200).response { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    static func getUser(completion: @escaping (MyProfile) -> Void) {
        let router = TBAPIRouter(path: TBAPIPath.Member.getUser, httpMethod: .get, apiType: .member)
        
        TBAPIManager.shared.sessionManager.request(router).responseDecodable(of: GetUserResponse.self, completionHandler: { response in
            switch response.result {
            case .success(let value):
                completion(value.toDomain)
                break
            case .failure(let error):
                print("getUser Error: \(error)")
            }
        })
    }
}
