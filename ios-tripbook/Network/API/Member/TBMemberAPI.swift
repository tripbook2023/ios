//
//  TBMemberAPI.swift
//  ios-tripbook
//
//  Created by DDang on 6/25/23.
//

import Foundation
import Alamofire

struct TBMemberAPI {
    static func signup() async {
        
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
